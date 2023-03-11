local function make_launch_config_helper( launch_template )
    
    local program_name = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    local cwd_name =  string.match(program_name, '(.*)/.*$') 
    local cwd_name = vim.fn.input('Path to cwd: ', cwd_name, 'file')
    local argstring = vim.fn.input('Executable arguments: ')
    local launch_name = vim.fn.input('Launch name: ', "Launch cppdbg")

    launch_template['name'] = launch_name
    launch_template['program'] = program_name
    launch_template['cwd'] = cwd_name 
    launch_template['args'] = vim.split(argstring, " ")

    return launch_template
end


local debugBit = {
	name = "debugBit",
	type = "codelldb", -- matches the adapter
	request = "launch", -- could also attach to a currently running process
	program = "/home/pbaldan/workspace/NH90/RpuController/build-simulator/controllermanager-test",
	cwd = "/home/pbaldan/workspace/NH90/RpuController/build-simulator",
	stopOnEntry = false,
	args = {"-t", "*/*testIBitRequestManagement"},
	runInTerminal = true,
    -- initCommands = "command source /home/pbaldan/.lldbinit",
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

-- local cppdbgIbit =
--   {
--     name = "cppdbg Ibit",
--     type = "cppdbg",
--     request = "launch",
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = '${workspaceFolder}/build_simulator',
-- 	args = {'-t','"*/*testOngoingProcessUpdating"'},
--     stopAtEntry = false,
--     setupCommands = {  
--         { 
--              text = '-enable-pretty-printing',
--              description =  'enable pretty printing',
--              ignoreFailures = false 
--         },
--     },
--   }
--

local cppdbgTemplOrig =
  {
    name = "Run cppdbg",
    type = "cppdbg",
    request = "launch",
    stopAtEntry = false,
    setupCommands = {  
        { 
             text = '-enable-pretty-printing',
             description =  'enable pretty printing',
             ignoreFailures = false 
        },
    },
  }

cppdbgTempl =
  {
    type = "cppdbg",
    request = "launch",
    stopAtEntry = false,
    setupCommands = {  
        { 
             text = '-enable-pretty-printing',
             description =  'enable pretty printing',
             ignoreFailures = false 
        },
    },
}

require('dap').configurations.cpp = {
    vscode,
}

local function add_dap_config(name, launch_tmpl)
    name = name or "customLauncher"
    require('dap').configurations.cpp[name] = make_launch_config_helper(launch_tmpl)
end

function add_cppconfig()
   table.insert( require('dap').configurations.cpp, make_launch_config_helper(cppdbgTempl))
end

-- Companion Plugins
-- Dapui
require("dapui").setup()
-- Dap Virtual Text
require("nvim-dap-virtual-text").setup()

vim.api.nvim_create_user_command('DapClearBreakpoints', ':lua require("dap").clear_breakpoints()<CR>', {nargs = 0})
vim.api.nvim_create_user_command('DapUiToggle', ':lua require("dapui").toggle()<CR>', {nargs = 0})
vim.api.nvim_create_user_command('DapUiFloat', ':lua require("dapui").float_element()<CR>', {nargs = 0})
