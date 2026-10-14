---@type LazySpec
return {
  "AstroNvim/astrocore",
  opts = {
    treesitter = {
      ensure_installed = { "lua", "vim", "python", "yaml", "go", "dockerfile" },
      highlight = true,
      indent = true,
    },
  },
}
