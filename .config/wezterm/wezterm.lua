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
config.macos_window_background_blur = 000
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
-- config.audible_bell = "Disabled"

-- Font
config.font_size = 13
config.font = wezterm.font("Maple Mono NF")

-- Colors
config.color_scheme = theme.get_system_color_scheme()

-- Update status every 30 seconds
config.status_update_interval = 1

-- Setup status bar handlers
wezterm.on("update-right-status", function(window, _)
	local workspaces = wezterm.mux.get_workspace_names()
	local active_workspace = wezterm.mux.get_active_workspace()
	local colors = theme.get_system_colors()

	local elements = {}

	for i, workspace in ipairs(workspaces) do
		local is_active = workspace == active_workspace

		-- Set colors based on active state
		local bg_color = is_active and colors.tab_bar.active_tab.bg_color or colors.tab_bar.inactive_tab.bg_color
		local fg_color = is_active and colors.tab_bar.active_tab.fg_color or colors.tab_bar.inactive_tab.fg_color

		-- Add workspace tab
		table.insert(elements, { Background = { Color = bg_color } })
		table.insert(elements, { Foreground = { Color = fg_color } })
		table.insert(elements, {
			Text = " " .. workspace .. " ",
		})
	end

	window:set_right_status(wezterm.format(elements))
end)

-- Setup scrollback editor
wezterm.on("edit-scrollback", function(window, pane)
	scrollback.edit_scrollback(window, pane)
end)

-- Initialize workspace tracking
sessions.init()

---Keys

config.keys = {
	-- Workspace-scoped actions (cmd+key)
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
	{
		key = "h", -- tab left
		mods = "SUPER",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "l", -- tab right
		mods = "SUPER",
		action = act.ActivateTabRelative(1),
	},

	-- Workspace management (cmd+shift+key)
	{
		key = "h", -- workspace left
		mods = "SUPER|SHIFT",
		action = sessions.cycle_workspace_relative(-1),
	},
	{
		key = "l", -- workspace right
		mods = "SUPER|SHIFT",
		action = sessions.cycle_workspace_relative(1),
	},
	{
		key = "o", -- open project
		mods = "SUPER|SHIFT",
		action = sessions.project(),
	},
	{
		key = "w", -- close workspace
		mods = "SUPER|SHIFT",
		action = sessions.close_current_workspace(),
	},

	{ key = "Enter", mods = "SHIFT", action = wezterm.action({ SendString = "\x1b\r" }) },
	{
		key = "=",
		mods = "CTRL",
		action = wezterm.action.Nop,
	},
	{
		key = "-",
		mods = "CTRL",
		action = wezterm.action.Nop,
	},
	{
		key = "-",
		mods = "CTRL|SHIFT",
		action = wezterm.action.Nop,
	},
	{
		key = "=",
		mods = "CTRL|SHIFT",
		action = wezterm.action.Nop,
	},
}

return config
