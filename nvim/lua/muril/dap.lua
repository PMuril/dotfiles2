require("dap").adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        command = vim.env.HOME .. "/workspace/sysconfig/dap/codelldb/adapter/codelldb",
        args = {"--port", "${port}"},
    }
}

local lldb = {
	name = "Launch lldb",
	type = "codelldb", -- matches the adapter
	request = "launch", -- could also attach to a currently running process
	program = function()
		return vim.fn.input(
			"Path to executable: ",
			vim.fn.getcwd() .. "/",
			"file"
		)
	end,
	cwd = function()
        return vim.fn.input(
            "Path to cwd: ",
            vim.fn.getcwd() .. "/",
            "file"
        )
    end,
	stopOnEntry = false,
	args = {},
	runInTerminal = true,
}

require('dap').configurations.cpp = {
    lldb
}

local dap = require("dap")
local dapui = require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

dapui.setup()
