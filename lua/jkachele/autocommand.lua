-- vim.cmd "autocmd BufNewFile,BufRead ~/6502Computer/*.asm set ft=oldasm"
-- vim.cmd "autocmd BufNewFile,BufRead ~/commands.txt set ft=sh"
-- vim.cmd "autocmd BufNewFile,BufRead ~/.config/i3blocks/config set ft=ini"
--
-- vim.cmd "autocmd FileType c setlocal cindent cinoptions+=:0"
--
-- -- vim.cmd "autocmd BufWinLeave *.* mkview"
-- -- vim.cmd "autocmd BufWinEnter *.* silent loadview"
--
-- vim.cmd('set viewoptions-=options')
-- vim.cmd([[
--     augroup vimrc
--     autocmd BufWritePost *
--     \   if expand('%') != '' && &buftype !~ 'nofile'
--     \|      mkview
--     \|  endif
--     autocmd BufRead *
--     \   if expand('%') != '' && &buftype !~ 'nofile'
--     \|      silent loadview
--     \|  endif
--     augroup END
-- ]])

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

-- vim.cmd([[
--     if exists("g:loaded_restore_view")
--         finish
--     endif
--     let g:loaded_restore_view = 1

--     if !exists("g:skipview_files")
--         let g:skipview_files = []
--     endif

--     function! MakeViewCheck()
--         if &l:diff | return 0 | endif
--         if &buftype != '' | return 0 | endif
--         if expand('%') =~ '\[.*\]' | return 0 | endif
--         if empty(glob(expand('%:p'))) | return 0 | endif
--         if &modifiable == 0 | return 0 | endif
--         if len($TEMP) && expand('%:p:h') == $TEMP | return 0 | endif
--         if len($TMP) && expand('%:p:h') == $TMP | return 0 | endif

--         let file_name = expand('%:p')
--         for ifiles in g:skipview_files
--             if file_name =~ ifiles
--                 return 0
--             endif
--         endfor

--         return 1
--     endfunction

--     augroup AutoView
--         autocmd!
--         " Autosave & Load Views.
--         autocmd BufWritePre,BufWinLeave ?* if MakeViewCheck() | silent! mkview | endif
--         autocmd BufWinEnter ?* if MakeViewCheck() | silent! loadview | endif
--     augroup END
-- ]])
