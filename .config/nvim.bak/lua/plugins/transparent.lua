return {
  {
    "xiyaowong/transparent.nvim",
    cmd = { "TransparentEnable", "TransparentDisable", "TransparentToggle" },
    opts = {
      -- leave groups = {} to use defaults
      extra_groups = {
        "NormalFloat", "NvimTreeNormal", "TelescopeNormal", "TelescopeBorder",
        "LazyNormal", "WhichKeyFloat", "FloatBorder", "Pmenu", "PmenuSbar",
      },
      exclude_groups = {}, -- keep these opaque if you want
    },
    -- optional: load after your colorscheme to ensure highlights are set
    event = "VeryLazy",
  },
}

