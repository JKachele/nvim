vim.cmd "autocmd BufNewFile,BufRead ~/6502Computer/*.asm set ft=oldasm"
vim.cmd "autocmd BufNewFile,BufRead ~/commands.txt set ft=sh"
vim.cmd "autocmd BufNewFile,BufRead ~/.config/i3blocks/config set ft=ini"

-- vim.cmd "autocmd BufWinLeave *.* mkview"
-- vim.cmd "autocmd BufWinEnter *.* silent loadview"
vim.cmd('set viewoptions-=options')
vim.cmd([[
    augroup vimrc
    autocmd BufWritePost *
    \   if expand('%') != '' && &buftype !~ 'nofile'
    \|      mkview
    \|  endif
    autocmd BufRead *
    \   if expand('%') != '' && &buftype !~ 'nofile'
    \|      silent loadview
    \|  endif
    augroup END
]])
