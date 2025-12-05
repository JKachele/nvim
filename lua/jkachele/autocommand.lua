vim.api.nvim_create_autocmd({"BufWinLeave"}, {
  pattern = {"*.*"},
  desc = "save view (folds), when closing file",
  command = "mkview",
})
vim.api.nvim_create_autocmd({"BufWinEnter"}, {
  pattern = {"*.*"},
  desc = "load view (folds), when opening file",
  command = "silent! loadview"
})

vim.api.nvim_create_autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('detect_verilog', { clear = true }),
  desc = 'Set filetype for *.v files',
  pattern = { '*.v' },
  callback = function()
    vim.cmd('set filetype=verilog')
  end,
})
