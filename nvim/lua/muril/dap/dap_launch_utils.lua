-- Predefined dap launch configurations, for ease of execution
local codelldbTmpl = {
    type = "codelldb", -- matches the adapter
    request = "launch", -- could also attach to a currently running process
    stopOnEntry = false,
    runInTerminal = true,
    -- initCommands = {"command source " .. vim.env.HOME .. "/.lldbinit"},
}

local vscode = {
    name = 'lldb-vscode',
    type = 'lldb',
    request = 'launch',
    program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
}

-- Cppdbg dap launch configuration template
local cppdbgTempl =
{
    type = "cppdbg",
    request = "launch",
    stopAtEntry = false,
    -- auto_continue_if_many_stopped = false,
    setupCommands = {
        {
            text = '-enable-pretty-printing',
            description = 'enable pretty printing',
            ignoreFailures = false,
        },
    },
    miDebuggerPath = '/usr/bin/gdb',
    -- Opt-in when sudo privileges are required
    -- miDebuggerPath = vim.env.HOME .. "/workspace/sysconfig/debuggers/gdb/sugdb",
    MIMode = "gdb",
}

local dapProvidersTempl = {
    cppdbg = cppdbgTempl,
    codelldb = codelldbTmpl,
}

-- Companion Plugins
-- Dapui
require("dapui").setup()
-- Dap Virtual Text
require("nvim-dap-virtual-text").setup()

require('dap').configurations.cpp = {
    vscode,
}

vim.api.nvim_create_user_command('DapClearBreakpoints', ':lua require("dap").clear_breakpoints()<CR>', { nargs = 0 })
vim.api.nvim_create_user_command('DapUiToggle', ':lua require("dapui").toggle()<CR>', { nargs = 0 })
vim.api.nvim_create_user_command('DapUiFloat', ':lua require("dapui").float_element()<CR>', { nargs = 0 })
-- dap_launch_utils

local M = {}

-- It just works if whe layer 1 element are not themselves table. Ideally one should implement a recursive function
---@param t input table
---@return copy of the input table
-- function table.copy( t )
--     local result = {}
--     for k, v in pairs(t) do
--        result[k] = v
--     end
--
--     return result
-- end

local function make_launch_config_helper(launch_template)
    local program_path = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    local def_cwd_path = string.match(program_path, '(.*)/.*$')
    local def_program_name = string.match(program_path, '.*/(.*)$')
    local cwd_path = vim.fn.input('Path to cwd: ', def_cwd_path, 'file')
    local argstring = vim.fn.input('Executable arguments: ')
    local launch_name = vim.fn.input('Launch name: ', def_program_name .. "_dbg")

    launch_template['name'] = launch_name
    launch_template['program'] = program_path
    launch_template['cwd'] = cwd_path
    launch_template['args'] = vim.split(argstring, " ", {})

    return launch_template
end

function M.add_dap_config(dapTempl)
    table.insert(require('dap').configurations.cpp, vim.fn.deepcopy(make_launch_config_helper(dapProvidersTempl[dapTempl])))
end

-- To know more about user-defined commands run ':h user-commands' ':h lua-guide-commands-create|
vim.api.nvim_create_user_command('DapUtilsAddConfig',
    function(opts)
        local args = opts.fargs[1] or cppdbgTempl
        require("muril.dap.dap_launch_utils").add_dap_config(args)
    end,
    {
        nargs = 1,
        complete = function(ArgLead, CmdLine, CursorPos)
            -- return completion candidates as a list-like table
            return vim.tbl_keys(dapProvidersTempl)
        end,
    })

return M

-- Scratch
