-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local python_markers = { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt" }

local function python_workspace_root(cwd)
  cwd = vim.uv.fs_realpath(cwd) or vim.fs.normalize(cwd)
  local root = vim.fs.root(cwd, python_markers)
  if root then return root end

  local boundary = vim.fs.root(cwd, ".git") or cwd
  boundary = vim.uv.fs_realpath(boundary) or boundary
  local function inside(path)
    return path == boundary or path:sub(1, #boundary + 1) == boundary .. "/"
  end
  local function has_marker(path)
    for _, marker in ipairs(python_markers) do
      local stat = vim.uv.fs_stat(path .. "/" .. marker)
      if stat and stat.type == "file" then return true end
    end
    return false
  end

  local environment = vim.env.VIRTUAL_ENV
  local environment_path = environment and vim.uv.fs_realpath(environment)
  if environment_path and inside(environment_path) then
    local path = vim.fs.dirname(environment_path)
    while inside(path) do
      if has_marker(path) then return path end
      if path == boundary then break end
      path = vim.fs.dirname(path)
    end
  end

  -- Only select a child project when the choice is unambiguous.
  local candidate
  for name, kind in vim.fs.dir(cwd) do
    if kind == "directory" and name:sub(1, 1) ~= "." then
      local path = cwd .. "/" .. name
      if has_marker(path) then
        if candidate then return nil end
        candidate = path
      end
    end
  end
  return candidate
end

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  init = function()
    vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
      group = vim.api.nvim_create_augroup("ty_workspace_diagnostics", { clear = true }),
      desc = "Start ty checks without opening a Python file",
      callback = function()
        vim.schedule(function()
          local root = python_workspace_root(vim.fn.getcwd())
          if not root then return end
          require("lazy").load { plugins = { "astrolsp" } }
          local config = vim.tbl_extend("force", vim.lsp.config.ty, { name = "ty", root_dir = root })
          vim.lsp.start(config, { attach = false })
        end)
      end,
    })
  end,
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        -- allow_filetypes = { -- enable format on save for specified filetypes only
        --   -- "go",
        -- },
        -- ignore_filetypes = { -- disable format on save for specified filetypes
        --   -- "python",
        -- },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      "ty",
      "ruff",
    },
    -- customize native language server configuration
    ---@diagnostic disable: missing-fields
    config = {
      lua_ls = { settings = { Lua = { format = { enable = false } } } },
      ty = {
        -- Start workspace checks before opening Python files.
        cmd = { "ty", "server" },
        filetypes = { "python" },
        root_markers = {
          "ty.toml",
          "pyproject.toml",
          "setup.py",
          "setup.cfg",
          "requirements.txt",
          ".git",
        },
        -- Make workspace diagnostics available as soon as ty initializes.
        capabilities = { textDocument = { diagnostic = { dynamicRegistration = false } } },
        on_init = function(client)
          if client:supports_method "workspace/diagnostic" then
            vim.lsp.buf.workspace_diagnostics { client_id = client.id }
          end
        end,
        settings = {
          ty = {
            -- Report diagnostics for unopened files in the workspace too.
            diagnosticMode = "workspace",
          },
        },
      },
    },
    -- Keep previously installed alternative Python servers from auto-enabling.
    handlers = { basedpyright = false, pyright = false, pyrefly = false },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_codelens_refresh = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/codeLens",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "InsertLeave", "BufEnter" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client:supports_method("textDocument/semanticTokens/full") and vim.lsp.semantic_tokens ~= nil
          end,
        },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  },
}
