local function augroup(name)
  return vim.api.nvim_create_augroup("config_" .. name, { clear = true })
end

-- sync with server on save (only if the sync script exists)
vim.api.nvim_create_autocmd("BufWritePost", {
  group = augroup("sync_with_server"),
  callback = function()
    local path = vim.fn.getcwd() .. "/scripts/sync.sh"
    local file = io.open(path, "r")
    if file ~= nil and io.close(file) then
      vim.fn.jobstart("SIMPLE=1 bash " .. path .. " --upload", {
        on_stdout = function(_, data, _)
          local message = table.concat(data, "\n", 2, #data - 1)
          vim.notify("Uploaded\n" .. message, vim.log.levels.INFO)
        end,
        on_exit = function(_, code, _)
          if code == 0 then
          elseif code == 225 then
            vim.notify("Unable to connect to the server", vim.log.levels.ERROR)
          elseif code == 23 then
            vim.notify("Wrong filename in upload.txt", vim.log.levels.ERROR)
          else
            vim.notify("Unknown error code", vim.log.levels.ERROR)
            print(code)
          end
        end,
        stdout_buffered = true,
      })
    end
  end,
})

-- Compile single C file on save
vim.api.nvim_create_autocmd("BufWritePost", {
  group = augroup("compile_c"),
  pattern = "*.c",
  callback = function()
    local cmd = "gcc " .. vim.fn.expand("%") .. " -o " .. vim.fn.expand("%:r")
    vim.fn.jobstart(cmd, {
      on_exit = function(_, code, _)
        if code == 0 then
          vim.notify("Compiled", vim.log.levels.INFO)
        else
          vim.notify("Compilation failed", vim.log.levels.ERROR)
        end
      end,
    })
  end,
})
