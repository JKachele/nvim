vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.fillchars = [[eob:~,fold: ,foldopen:,foldsep:▏,foldclose:]]
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.cmd "augroup mycolors"
vim.cmd "autocmd!"
vim.cmd "autocmd ColorScheme * highlight FoldColumn guibg=black guifg=#404040"
vim.cmd "augroup END"

vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zK', function()
        local winid = require('ufo').peakFoldedLinesUnderCursor()
        if not winid then
                vim.lsp.buf.hover()
        end
end)

local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, {chunkText, hlGroup})
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                end
                curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, {suffix, 'MoreMsg'})
        return newVirtText
end

require('ufo').setup({
        provider_selector = function()
                -- return {'lsp', 'indent'}
                return {'treesitter', 'indent'}
        end,
        fold_virt_text_handler = handler
})
