-- The following file is written with the help of ChatGPT
local json = vim.fn.json_decode
local cwd = vim.fn.getcwd()
local cmake_file = cwd .. "/CMakePresets.json"

vim.api.nvim_create_user_command("Run", function()
  if vim.fn.filereadable(cmake_file) == 0 then
    vim.notify("󰋗  No CMakePresets.json found in " .. cwd, vim.log.levels.ERROR)
    return
  end

  local ok, data = pcall(json, table.concat(vim.fn.readfile(cmake_file), "\n"))
  if not ok or not data or not data.configurePresets then
    vim.notify("󰅙  Invalid or unreadable CMakePresets.json", vim.log.levels.ERROR)
    return
  end

  local presets = {}
  for _, preset in ipairs(data.configurePresets) do
    table.insert(presets, preset.name)
  end

  if #presets == 0 then
    vim.notify("󰅙  No presets found in CMakePresets.json", vim.log.levels.WARN)
    return
  end

  vim.ui.select(presets, {
    prompt = "󱓞  Select Build Preset",
    format_item = function(item)
      return "󰄾  " .. item
    end,
  }, function(choice)
    if not choice then
      vim.notify("No preset selected.", vim.log.levels.WARN)
      return
    end

    -- Reuse if buildTerminal already exists
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf):find("buildTerminal") then
        vim.cmd("botright split | resize 15 | buffer " .. buf)
        vim.fn.chansend(vim.b.terminal_job_id, "\r")
        return
      end
    end

    -- Create a new build terminal
    vim.cmd("botright split | resize 15 | terminal ./run.sh " .. choice)
    local term_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_name(term_buf, "buildTerminal")

    -- q closes from inside terminal
    vim.api.nvim_buf_set_keymap(term_buf, "t", "q", [[<C-\><C-n>:bd!<CR>]], { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term_buf, "n", "q", [[:bd!<CR>]], { noremap = true, silent = true })

    -- global mapping to close from anywhere
    vim.keymap.set("n", "q", function()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf):find("buildTerminal") then
          vim.api.nvim_buf_delete(buf, { force = true })
          vim.notify("󰚌  Closed buildTerminal", vim.log.levels.INFO)
          return
        end
      end
      vim.notify("󰅖  No buildTerminal open", vim.log.levels.WARN)
    end, { noremap = true, silent = true, desc = "Close buildTerminal" })
  end)
end, { desc = "Run build preset from CMakePresets.json (buildTerminal)" })
