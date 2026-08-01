require("hyprland.lib")

-- Personal bindings ported from the old custom/keybinds.conf.
hl.bind("CTRL + SUPER + Slash", hl.dsp.exec_cmd("xdg-open ~/.config/illogical-impulse/config.json"))
hl.bind("CTRL + SUPER + ALT + Slash", hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.lua"))

local numberKeys = { 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
local numpadKeys = { 87, 88, 89, 83, 84, 85, 79, 80, 81, 90 }

for i = 1, 10 do
    -- The packaged config uses SUPER+ALT for send-to-workspace.
    -- Restore the old preference of SUPER+SHIFT instead.
    hl.unbind("SUPER + ALT + " .. (i % 10))
    hl.unbind("SUPER + ALT + code:" .. numberKeys[i])
    hl.unbind("SUPER + ALT + code:" .. numpadKeys[i])

    hl.bind("SUPER + SHIFT + code:" .. numberKeys[i], function()
        hl.dispatch(hl.dsp.window.move({ workspace = workspace_in_group(i), follow = true }))
    end)

    hl.bind("SUPER + SHIFT + code:" .. numpadKeys[i], function()
        hl.dispatch(hl.dsp.window.move({ workspace = workspace_in_group(i), follow = true }))
    end)
end
