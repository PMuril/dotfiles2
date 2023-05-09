local dap = require('dap')

-- dap.defaults.fallback.auto_continue_if_many_stopped = false
-- dap.defaults.cpp.auto_continue_if_many_stopped = false
-- dap.defaults.cppdbg.auto_continue_if_many_stopped = false

dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        command = vim.env.HOME .. "/workspace/sysconfig/dap/codelldb/adapter/codelldb",
        args = {"--port", "${port}"},
    },
}

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb'
}


local vscodeExtDir = vim.env.HOME .. '/.vscode/extensions'
-- local cppToolsDir  = vim.fn.system("find " .. vscodeExtDir .. " -name 'OpenDebugAD7' | sort -n -r | head -n 1") -- Pick most recent
local cppToolsDir  = "/Users/paolobaldan/.vscode/extensions//ms-vscode.cpptools-1.15.3-darwin-x64/debugAdapters/bin/OpenDebugAD7"

print(dbgAbsPath)

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = cppToolsDir,
}
