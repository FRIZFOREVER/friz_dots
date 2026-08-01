-- Ported from the old custom/general.conf into Hyprland 0.55 Lua config.

hl.config({
    input = {
        kb_layout = "us,ru",
        kb_options = "grp:alt_shift_toggle"
    },
    decoration = {
        -- Preserve the lighter blur profile from the old dots.
        blur = {
            enabled = true,
            xray = false,
            size = 1,
            passes = 1,
            brightness = 1,
            noise = 0,
            contrast = 0.98,
            vibrancy = 0.05,
            vibrancy_darkness = 0.1
        }
    }
})
