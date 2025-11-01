DebugState = {}

local function scratch_buffer()
  local buf_num = vim.fn.bufadd 'LuaScratch'
  local opt = vim.bo[buf_num]
  opt.bufhidden = 'hide'
  opt.swapfile = false
  opt.buftype = 'nofile'
  return buf_num
end

local function write_to_buffer(text)
  local buf_num = scratch_buffer()
  local lines = vim.fn.split(text, '\r\n\\|\n')
  local index = vim.api.nvim_buf_line_count(buf_num)
  vim.api.nvim_buf_set_lines(buf_num, index, index, false, lines)
end

function Pprint(item)
  write_to_buffer '>>'
  write_to_buffer(vim.inspect(item))
  local buf_num = scratch_buffer()
  local windows = vim.fn.win_findbuf(buf_num)
  if next(windows) == nil then
    vim.cmd 'vsplit LuaScratch'
  end
end

function Test(args)
  require('custom.lua_ft').setup()
  --
end

vim.api.nvim_create_user_command('Test', Test, { bang = true, desc = 'My test command' })
