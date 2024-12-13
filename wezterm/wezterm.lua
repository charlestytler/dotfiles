local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("Hack Nerd Font")
--config.font = wezterm.font 'Iosevka Nerd Font'
config.font_size = 14

-- config.color_scheme = "Palenight (Gogh)"
-- config.color_scheme = "Ayu Mirage"
config.color_scheme = "Decaf (base16)"

config.window_background_opacity = 0.92
config.macos_window_background_blur = 10

config.enable_tab_bar = false
config.window_decorations = "TITLE | RESIZE"

config.window_close_confirmation = "NeverPrompt"

return config
