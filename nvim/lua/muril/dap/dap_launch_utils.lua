-- Predefined dap launch configurations, for ease of execution

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
             description =  'enable pretty printing',
             ignoreFailures = false,
        },
    },
    -- miDebuggerPath = vim.env.HOME .. "/workspace/sysconfig/debuggers/gdb/sugdb",
    MIMode =  vim.loop.os_uname().sysname == "Darwin" and "lldb" or "gdb"
}

local codelldbTempl = {
    type = "codelldb", -- matches the adapter
    request = "launch", -- could also attach to a currently running process
    stopOnEntry = false,
    runInTerminal = true,
}

local dbgAdaptersTemplMap = {
    codelldb = codelldbTempl,
    cppdbg = cppdbgTempl,
}


-- Companion Plugins
-- Dapui
require("dapui").setup()
-- Dap Virtual Text
require("nvim-dap-virtual-text").setup()

require('dap').configurations.cpp = {
    vscode,
}

vim.api.nvim_create_user_command('DapClearBreakpoints', ':lua require("dap").clear_breakpoints()<CR>', {nargs = 0})
vim.api.nvim_create_user_command('DapUiToggle', ':lua require("dapui").toggle()<CR>', {nargs = 0})
vim.api.nvim_create_user_command('DapUiFloat', ':lua require("dapui").float_element()<CR>', {nargs = 0})
-- dap_launch_utils

local M = {}

-- It just works if whe layer 1 element are not themselves table. Ideally one should implement a recursive function
---@param t input table
---@return copy of the input table
function table.copy( t )
    local result = {}
    for k, v in pairs(t) do
       result[k] = v
    end

    return result
end

local function make_launch_config_helper( launch_template )
    local program_path = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    local def_cwd_path =  string.match(program_path, '(.*)/.*$')
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

local function selectDbgTmpl ()
    vim.ui.select( {"cppdb", "codelldb", "vscode"} , {
        prompt = "Select a debug adapter implementation"}, function(adapter, _)
            local result = dbgAdaptersTemplMap[adapter]
            vim.print(result)
            return result
        end
    )
end

function M.add_dap_config(launch_tmpl)
    launch_tmpl = launch_tmpl or selectDbgTmpl()
    -- table.insert(require('dap').configurations.cpp, table.copy( make_launch_config_helper(launch_tmpl)) )
    table.insert(require('dap').configurations.cpp, vim.deepcopy( make_launch_config_helper(launch_tmpl)) )
end

vim.api.nvim_create_user_command('DapUtilsAddConfig', ':lua require("muril.dap.dap_launch_utils").add_dap_config()<CR>', {nargs=0})

return M

-- Scratch 
