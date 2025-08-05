local wezterm = require("wezterm") --[[@as Wezterm]]

---@class Sessions
local M = {}

---Return a list of project directories (i.e. ~/Developer/*)
---@return string[]
local function project_dirs()
	local projects = { wezterm.home_dir }
	for _, dir in ipairs(wezterm.glob(os.getenv("HOME") .. "/Developer/*")) do
		table.insert(projects, dir)
	end
	return projects
end

---Create a new session for a project
M.project = function()
	local choices = {}
	for _, value in ipairs(project_dirs()) do
		table.insert(choices, { label = value })
	end
	return wezterm.action.InputSelector({
		title = "Projects",
		choices = choices,
		fuzzy = true,
		action = wezterm.action_callback(function(child_window, child_pane, _, label)
			if not label then
				return
			end
			child_window:perform_action(
				---@diagnostic disable-next-line: param-type-mismatch
				wezterm.action.SwitchToWorkspace({
					name = label:match("([^/]+)$"),
					spawn = { cwd = label },
				}),
				child_pane
			)
		end),
	})
end

---Open a session
function M.open()
	return wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES|LAUNCH_MENU_ITEMS" })
end

return M
