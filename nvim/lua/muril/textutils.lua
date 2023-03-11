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

return M
-- Functions
-- function NextClosedFold(mov)
--     local cmd = 'norm!za :' .. mov
--     local view = vim.api.
--     -- code
-- end

-- Commands 

-- vim.api.nvim_create_user_command('TrimWhitespaces', '[[%s/\s\+$//e | exe "normal ``"]]', {nargs = 0} )

-- vim.api.nvim_create_user_command('TrimWhitespaces', ': %s/\s+$//e | exe "normal ``"', {nargs=1} )
