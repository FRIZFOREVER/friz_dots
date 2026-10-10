---@type LazySpec
return {
  "saghen/blink.cmp",
  opts = function(_, opts)
    -- Navigate the menu before snippet/AI actions, then fall back to indentation.
    table.insert(opts.keymap["<Tab>"], 1, "select_next")
    table.insert(opts.keymap["<S-Tab>"], 1, "select_prev")
  end,
}
