-- Module to experiment with lua autocommands api
--
--
-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
-- pattern = {"*"},
-- callback = function () print("hello autocmd!") end,
-- -- group = 'myluacmdgroup',
-- })


-- function M.nvim_create_augroups(definitions)
--     for group_name, definition in pairs(definitions) do
--         api.nvim_command('augroup '..group_name)
--         api.nvim_command('autocmd!')
--         for _, def in ipairs(definition) do
--             local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
--             api.nvim_command(command)
--         end
--         api.nvim_command('augroup END')
--     end
-- end

-- vim.api.nvim_create_autocmd( {"BufWinEnter"},
-- {
--     pattern = {"*"},
--     callback = function () vim.api.nvim_command("normal zR") end,
-- })
--
--
vim.api.nvim_create_autocmd({"BufNewFile","BufRead" },
{
    pattern = {"*.clangd", ".clang-format"},
    callback = function () vim.cmd("set filetype=yaml") end,
})

-- Overrides the formatoptions set from ftplugin 
-- For reference see https://vi.stackexchange.com/questions/22641/how-to-override-ftplugin-set-commands-in-neovim
vim.api.nvim_create_autocmd({"BufWinEnter"},
{
    pattern = {"*"},
    callback = function () vim.cmd("setlocal formatoptions=jcql") end
})
