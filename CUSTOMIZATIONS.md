# Local configuration snapshot

This branch records the local configuration as of 2026-08-01.  It is a
personal divergence from [`end-4/dots-hyprland`](https://github.com/end-4/dots-hyprland),
compared against upstream commit `aed4d1ec63f584905c28d2a678db5845579fdafc`
(2026-07-27).  The previous personal snapshot is `origin/master` at
`4676d4d00ead897f37a5f510b828e1283b9139a6`; it remains unchanged.

## Terminal and shell

- **Kitty** is the main terminal (`hypr/hyprland.conf` and
  `hypr/custom/variables.lua`), replacing the upstream Fish-first fallback
  usage.  Kitty uses the login shell, enables remote control on its runtime
  socket, disables close confirmation, and uses `0.8` background opacity.
- **Zsh** is the interactive shell.  `.zshrc` uses Oh My Zsh with Git,
  autosuggestions, and syntax-highlighting; enables correction and shared
  incremental history; initializes zoxide, fzf, keychain, and Starship; sets
  Neovim as `VISUAL`/`EDITOR`; and supplies the local eza, bat, fd, Git,
  Docker, and virtual-environment aliases.  It also starts fastfetch in
  interactive shells and sources `zshrc.d/auto-Hypr.sh`.
- **Starship** is configured in `starship.toml`.  The theme-generation template
  in `quickshell/ii/scripts/colors/terminal/kitty-theme.conf` adds Starship
  contrast overrides.

## Wallpaper-driven terminal colours

- Kitty includes the generated QuickShell state file
  `~/.local/state/quickshell/user/generated/terminal/kitty-theme.conf`.
- `quickshell/ii/scripts/colors/switchwall.sh` generates a palette from the
  selected wallpaper, honours terminal-generation options, then invokes
  `applycolor.sh`.
- `applycolor.sh` writes Kitty and terminal escape-sequence outputs under the
  QuickShell state directory and sends `SIGUSR1` to running Kitty instances
  so colours reload without restarting the terminal.  The repository also
  preserves the generated/legacy Kitty colour files and the new template.

## Hyprland and display setup

- The active `hypr/hyprland.conf` is a concise local stub: `SUPER` is the main
  modifier; `kitty`, `dolphin`, and `hyprlauncher` are the terminal, file
  manager, and launcher; it binds `SUPER+Q/C/M/E/V/R` for terminal, close,
  logout, file manager, floating toggle, and launcher.
- The migration retains the older `.conf` configuration and adds the current
  Lua-based layout (`hyprland.lua`, `hypr/custom/*.lua`, service, library, and
  shell-override files).  Personal variables prefer Kitty and use Zsh when
  launching Yazi or btop.
- Personal keybindings open the Illogical Impulse configuration and the
  keybinding file, move windows with `SUPER+SHIFT+1..0` (including numpad),
  and remove the packaged `SUPER+ALT` workspace-send bindings.  Kitty-specific
  rules disable compositor blur so Kitty controls its own transparency.
- `hypr/monitors.conf` is intentionally the `nwg-displays` managed placeholder;
  no machine-specific monitor mode, position, or scale is currently committed.
  New/legacy monitor and workspace migration files are retained as part of the
  snapshot.
- Hypridle, Hyprlock, colour, environment, execution, rule, and helper-script
  customizations are included, including the current removal/replacement of
  older workspace and zoom helpers.

## Neovim

- The local editor setup is AstroNvim with Catppuccin and transparent-nvim,
  plus Python (basedpyright and Ruff), Go, Lua, conform, and Markdown/LaTex
  community packs.
- Core options enable relative and absolute line numbers, disable wrapping and
  spell checking, and retain diagnostics/URL highlighting/completion.  Buffer
  navigation and picker-based buffer close mappings are customized.
- The lockfile, AstroCore/AstroUI configuration, and local `aerial.lua` are
  part of this saved state.

## QuickShell / Illogical Impulse divergence

- This checkout is a broad functional and visual fork of the current upstream
  QuickShell configuration.  It includes local changes across the II and
  Waffle panels, bars, dock, overview/search, lock/session UI, sidebars,
  sliders, notification centre, task view, wallpaper selector, OSD, screen
  snipping, and translations.
- Added local components include Google Cloud and Hyprland integration,
  anti-flashbang shader support, screen translation, multi-turn processes,
  new toggle models, toolbar/shape widgets, screenshots, generated icon
  assets, and extended locale files.  Existing QuickShell services and colour,
  AI, wallpaper, thumbnail, music-recognition, and code-theme scripts are
  customized as captured in this commit.
- `illogical-impulse/config.json` and its installed list are the local shell
  preference state and are deliberately included.

## Other retained local state

- Local Fish, Fuzzel, KDE, GTK, browser/application, media, systemd, and
  desktop-application settings exist in the working configuration.  The
  repository intentionally tracks the curated dotfile areas selected by
  `.gitignore` (Hyprland, Neovim, Illogical Impulse, Kitty, QuickShell, and
  Starship), rather than every application directory in `~/.config`.

## Upstream layout differences

Upstream now uses its `dots/.config` layout and Lua-first Hyprland files,
whereas this snapshot keeps a compatibility `.conf` layer and local migration
files.  It also contains a significantly customised QuickShell tree: local
files differ in the common models/widgets, II modules, Waffle modules,
panel-family definitions, scripts, services, and translations.  Conversely,
some newer upstream helper widgets, models, icon assets, Hyprlock helpers, and
an anti-flashbang shader variant are not present locally.  This document is a
configuration map, not an instruction to overwrite either side during future
updates.
