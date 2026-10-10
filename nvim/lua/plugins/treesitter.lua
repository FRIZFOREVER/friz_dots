---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  init = function(plugin)
    require("lazy.core.loader").add_to_rtp(plugin)
    local query = vim.treesitter.query
    local add_predicate, add_directive = query.add_predicate, query.add_directive

    -- The master branch expects single nodes; Neovim 0.12 passes node lists.
    local function adapt(register)
      return function(name, handler, opts)
        register(name, function(match, ...)
          local nodes = {}
          for id, captures in pairs(match) do
            nodes[id] = type(captures) == "table" and captures[#captures] or captures
          end
          return handler(nodes, ...)
        end, opts)
      end
    end

    if vim.fn.has "nvim-0.12" == 1 then
      query.add_predicate = adapt(add_predicate)
      query.add_directive = adapt(add_directive)
    end
    local ok, err = pcall(require, "nvim-treesitter.query_predicates")
    -- Adapt only this plugin's registrations, then restore the public API.
    query.add_predicate, query.add_directive = add_predicate, add_directive
    if not ok then error(err) end
  end,
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "python",
      "yaml",
      "go",
      "dockerfile",
    },
  },
}
