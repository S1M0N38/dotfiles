local wezterm = require("wezterm") --[[@as Wezterm]]

---@class Sessions
local M = {}

-- Track previous workspace for quick switching
local workspace_history = {
	current = nil,
	previous = nil,
}

---Update workspace history when switching workspaces
---@param new_workspace string
local function update_workspace_history(new_workspace)
	if workspace_history.current ~= new_workspace then
		workspace_history.previous = workspace_history.current
		workspace_history.current = new_workspace
	end
end

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
	return wezterm.action_callback(function(window, pane)
		local current = wezterm.mux.get_active_workspace()
		update_workspace_history(current)

		local workspace_names = wezterm.mux.get_workspace_names()
		local choices = {}

		for _, name in ipairs(workspace_names) do
			local label = name
			if name == workspace_history.previous then
				label = name .. " (previous)"
			end
			table.insert(choices, {
				label = label,
				id = name,
			})
		end

		window:perform_action(
			wezterm.action.InputSelector({
				title = "Workspaces",
				choices = choices,
				fuzzy = true,
				action = wezterm.action_callback(function(child_window, child_pane, id, label)
					if not id then
						return
					end
					child_window:perform_action(
						wezterm.action.SwitchToWorkspace({
							name = id,
						}),
						child_pane
					)
				end),
			}),
			pane
		)
	end)
end

---Switch to the previous workspace
M.switch_to_previous = function()
	return wezterm.action_callback(function(window, pane)
		local current = wezterm.mux.get_active_workspace()
		update_workspace_history(current)
		
		if workspace_history.previous and workspace_history.previous ~= current then
			window:perform_action(
				wezterm.action.SwitchToWorkspace({
					name = workspace_history.previous,
				}),
				pane
			)
			-- Swap current and previous for true toggle behavior
			local temp = workspace_history.current
			workspace_history.current = workspace_history.previous
			workspace_history.previous = temp
		end
	end)
end

---Initialize the current workspace on startup
M.init = function()
	workspace_history.current = wezterm.mux.get_active_workspace()
end

---Cycle through workspaces by relative offset
---@param offset number
M.cycle_workspace_relative = function(offset)
	return wezterm.action_callback(function(window, pane)
		local current = wezterm.mux.get_active_workspace()
		local workspaces = wezterm.mux.get_workspace_names()

		-- Find current workspace index
		local current_idx = 1
		for i, name in ipairs(workspaces) do
			if name == current then
				current_idx = i
				break
			end
		end

		-- Calculate new index with wrapping
		local new_idx = ((current_idx - 1 + offset) % #workspaces) + 1
		local new_workspace = workspaces[new_idx]

		if new_workspace and new_workspace ~= current then
			update_workspace_history(current)
			window:perform_action(
				wezterm.action.SwitchToWorkspace({
					name = new_workspace,
				}),
				pane
			)
		end
	end)
end

---Jump to workspace by index (1-based)
---@param index number
M.jump_to_workspace_by_index = function(index)
	return wezterm.action_callback(function(window, pane)
		local workspaces = wezterm.mux.get_workspace_names()
		local target_workspace = workspaces[index]

		if target_workspace then
			local current = wezterm.mux.get_active_workspace()
			update_workspace_history(current)
			window:perform_action(
				wezterm.action.SwitchToWorkspace({
					name = target_workspace,
				}),
				pane
			)
		end
	end)
end

---Close the current workspace
M.close_current_workspace = function()
	return wezterm.action_callback(function(window, pane)
		local current = wezterm.mux.get_active_workspace()
		local workspaces = wezterm.mux.get_workspace_names()

		-- Don't close if it's the only workspace
		if #workspaces <= 1 then
			return
		end

		-- Find a different workspace to switch to
		local target_workspace = nil
		for _, name in ipairs(workspaces) do
			if name ~= current then
				target_workspace = name
				break
			end
		end

		if target_workspace then
			-- Switch to another workspace first
			window:perform_action(
				wezterm.action.SwitchToWorkspace({
					name = target_workspace,
				}),
				pane
			)

			-- Close all tabs in the old workspace
			-- Note: WezTerm will automatically clean up empty workspaces
			for _, tab in ipairs(wezterm.mux.get_workspace(current):tabs()) do
				tab:panes()[1]:close()
			end
		end
	end)
end

return M
