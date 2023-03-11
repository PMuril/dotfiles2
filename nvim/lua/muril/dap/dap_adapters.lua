local dap = require('dap')

dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        command = vim.env.HOME .. "/workspace/sysconfig/dap/codelldb/adapter/codelldb",
        args = {"--port", "${port}"},
    }
}

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb'
}


dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/pbaldan/.vscode/extensions/ms-vscode.cpptools-1.13.9-linux-x64/debugAdapters/bin/OpenDebugAD7',
}
