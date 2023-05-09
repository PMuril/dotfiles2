-- Dapui
require("dapui").setup()
-- Dap Virtual Text
require("nvim-dap-virtual-text").setup({})

vim.api.nvim_create_user_command('DapClearBreakpoints', ':lua require("dap").clear_breakpoints()<CR>', {nargs = 0})
vim.api.nvim_create_user_command('DapUiToggle', ':lua require("dapui").toggle()<CR>', {nargs = 0})
vim.api.nvim_create_user_command('DapUiFloat', ':lua require("dapui").float_element()<CR>', {nargs = 0})
vim.api.nvim_create_user_command('DapAddConfig', ':lua require("dapui").float_element()<CR>', {nargs = 0})
