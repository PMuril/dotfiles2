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

-- TODO(pbaldan): add code to extract version number from string and sort by version number
local vscodeExtDir = vim.env.HOME .. "/.vscode/extensions"
local cpptoolsDapExe = vim.fn.system("find " .. vscodeExtDir .. " -name 'OpenDebugAD7' | sort -n -r | head -n 1 | cut -d '/' -f 4-")

-- print( type(cpptoolsDapExe) .. ';;' .. cpptoolsDapExe)
-- print("cpptoolsDapExe: " .. cpptoolsDapExe)
-- code --list-extensions --show-versions | grep 'ms-vscode.cpptools' | sed -e 's/@/-/g'
local cppToolsDir = 'ms-vscode.cpptools-1.14.4-linux-x64'

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = vim.env.HOME .. '/.vscode/extensions/' .. cppToolsDir .. '/debugAdapters/bin/OpenDebugAD7',
  -- command = vim.env.HOME .. '/' .. cpptoolsDapExe
}
