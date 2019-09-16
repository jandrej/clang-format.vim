local api = vim.api

function LuaClangFormat()
  lstart = api.nvim_eval('a:firstline')
  lstop = api.nvim_eval('a:lastline')

  buf = api.nvim_get_current_buf()

  lines = api.nvim_buf_get_lines(buf, 0, -1, 0)

  -- Get current cursor position
  -- print(vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())[1])

  text = table.concat(lines, "\n")

  text = text:gsub("'", "'\\''")
  cf_cmd = string.format("clang-format -assume-filename=input.cpp -lines=%d:%d", lstart, lstop)
  text_fmt = assert(io.popen("printf '%s' '" .. text .. "' | " .. cf_cmd))

  -- Convert io to string array
  lines_fmt = {}
  for line in text_fmt:lines() do
    table.insert(lines_fmt, line)
  end

  api.nvim_buf_set_lines(buf, 0, -1, 0, lines_fmt) 

  text_fmt:close()
end
