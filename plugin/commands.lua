vim.api.nvim_create_user_command('DeleteFile', function()
  vim.cmd [[
    call delete(expand('%'))
    bd!
  ]]
end, {})
