-- Ported from the old custom/rules.conf.

-- Let kitty handle its own transparency and avoid compositor blur there.
hl.window_rule({
    match = { class = "^(kitty)$" },
    no_blur = true
})
