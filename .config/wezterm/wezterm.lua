local wezterm = require("wezterm") --[[@as Wezterm]]
local theme = require("theme") --[[@as Theme]]
local sessions = require("sessions") --[[@as Sessions]]
local scrollback = require("scrollback") --[[@as Scrollback]]

local act = wezterm.action
local config = wezterm.config_builder()

-- Window
---@diagnostic disable-next-line: assign-type-mismatch
config.window_decorations = "RESIZE | MACOS_FORCE_DISABLE_SHADOW"
---@diagnostic disable-next-line: inject-field
config.macos_fullscreen_extend_behind_notch = true
config.window_background_opacity = 1.8
config.macos_window_background_blur = 100
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.enable_scroll_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.inactive_pane_hsb = {
	hue = 1.0,
	saturation = 0.9,
	brightness = 0.9,
}

-- Notifications
config.audible_bell = "Disabled"

-- Font
config.font_size = 13
config.font = wezterm.font("Maple Mono NF")

-- Colors
config.color_scheme = theme.get_system_color_scheme()

-- Update status every 30 seconds
config.status_update_interval = 1

-- Setup status bar handlers
wezterm.on("update-right-status", function(window, _)
	local workspace = wezterm.mux.get_active_workspace()
	local status_text = workspace .. " "
	window:set_right_status(wezterm.format({
		{ Text = status_text },
	}))
end)

-- Setup scrollback editor
wezterm.on("edit-scrollback", function(window, pane)
	scrollback.edit_scrollback(window, pane)
end)

---Keys

config.keys = {
	{
		key = "p", -- project
		mods = "SUPER",
		action = sessions.project(),
	},
	{
		key = "o", -- open
		mods = "SUPER",
		action = sessions.open(),
	},
	{
		key = "k", -- "klear"
		mods = "SUPER",
		action = act.Multiple({
			act.ClearScrollback("ScrollbackAndViewport"),
			act.SendKey({ key = "L", mods = "CTRL" }),
		}),
	},
	{
		key = "e", -- edit scrollback
		mods = "SUPER",
		action = act.EmitEvent("edit-scrollback"),
	},
}

return config
