local async = require('neotest.async')
local context_manager = require('plenary.context_manager')
local lib = require('neotest.lib')
local open = context_manager.open
local Path = require('plenary.path')
local with = context_manager.with
local xml = require('neotest.lib.xml')

local adapter = { name = 'neotest-boosttest' }

adapter.root = lib.files.match_root_pattern("compile_commands.json") --[[ TODO: see if there's a better way to identify the root pattern ]]

function adapter.root(dir)
end

function adapter.filter_dir(name, rel_path, root)
end

function adapter.is_test_file(file_path)
end

function adapter.discover_positions(path)

-- the expressione 'parameter_list .' allows to match only the first element in the parameter list
    local query = [[
    (function_declarator
        declarator: (identifier) @bmacro (#match? @bmacro "BOOST_.*_TEST_CASE")
        (parameter_list .
            (parameter_declaration) @fname )) 
    ]]

    return lib.treesitter.parse_positions(path, query, {
        require_namespaces = false,
        position_id = function(position, namespaces)
            return table.concat(
                vim.tbl_flatten
            )
    }
    )
end

function adapter.build_spec(args)
end

function adapter.results(spec, result, tree)
end

return adapter

