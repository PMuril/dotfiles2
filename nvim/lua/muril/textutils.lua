local M = {}

-- function M.overreturn ()
--     local prev = vim.inspect( vim.opt.formatoptions:get() )
--     -- prev.r = true
--     print(prev)
--     -- vim.opt.formatoptions = curr
-- end

function M.toggler ()
    local prev = vim.opt.formatoptions:get()
    prev.r = not prev.r
    vim.opt.formatoptions = prev
end

vim.api.nvim_create_user_command('ToggleR', ':lua require("muril.textutils").toggler()', {nargs = 0} )


vim.api.nvim_create_user_command('TrimWhitespaces', ':lua vim.cmd([[%s/\\s\\+$//e]])', {nargs = 0} )

---The function moves the cursor to the closest fold in the specified direction
---@param dir movement direction [j|k]
-- function M.next_closed_fold(direction)
--     local toggle_fold_kbd = 'za'
--     local move_kbd = ':' .. direction
--     local toggle_and_move_cmd = 'normal!' .. toggle_fold_kbd .. move_kbd
--
-- end

-- function M.basic_text_objects()
--     local chars = { '_', '.', ':', ',', ';', '|', '/', '\\', '*', '+', '%', '`', '?' }
--     for _,char in ipairs(chars) do
--         for _,mode in ipairs({ 'x', 'o' }) do
--             vim.api.nvim_set_keymap(mode, "i" .. char, string.format(':<C-u>silent! normal! f%sF%slvt%s<CR>', char, char, char), { noremap = true, silent = true })
--             vim.api.nvim_set_keymap(mode, "a" .. char, string.format(':<C-u>silent! normal! f%sF%svf%s<CR>', char, char, char), { noremap = true, silent = true })
--         end
--     end
-- end


-- vim.api.nvim_create_user_command('TrimWhitespaces', ': %s/\s+$//e | exe "normal ``"', {nargs=1} )

return M

