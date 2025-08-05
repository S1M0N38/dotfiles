local wezterm = require("wezterm") --[[@as Wezterm]]

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

--- Load light or dark built-in colorscheme
local function get_system_color_scheme()
	if get_appearance():find("Dark") then
		return "tokyonight_moon"
	else
		return "tokyonight_day"
	end
end

--- Load light or dark colorscheme from toml files
local function get_system_colors()
	if get_appearance():find("Dark") then
		return wezterm.color.load_scheme(wezterm.config_dir .. "/colors/tokyonight_moon.toml")
	else
		return wezterm.color.load_scheme(wezterm.config_dir .. "/colors/tokyonight_day.toml")
	end
end

---@class Theme
---@field get_system_color_scheme fun(): string
---@field get_system_colors fun(): Palette
local M = {
	get_system_color_scheme = get_system_color_scheme,
	get_system_colors = get_system_colors,
}

return M
