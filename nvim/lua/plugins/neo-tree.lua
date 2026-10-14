---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      -- Use the same sidebar for directory startup and the explorer shortcut.
      hijack_netrw_behavior = "open_default",
    },
  },
}
