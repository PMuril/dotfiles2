local async = require('neotest.async')
local context_manager = require('plenary.context_manager')
local lib = require('neotest.lib')
local open = context_manager.open
local Path = require('plenary.path')
local with = context_manager.with
local xml = require('neotest.lib.xml')

local adapter = { name = 'neotest-boosttest' }

-- TODO(pbaldan): generalize pattern matching
local get_package_root = lib.files.match_root_pattern("compile_commands.json")

function adapter.root(dir)
    return get_package_root(dir)
end

function adapter.filter_dir(name, rel_path, root)
end

function adapter.is_test_file(file_path)
        return vim.endswith(file_path, "TestSuite.cpp") and #adapter.discover_positions(file_path):to_list() ~= 1
    end

local function path_to_test_path(path_string)
    -- return path_string
    -- local root = get_package_root(path_string)
    --
    -- local path = Path:new(path_string)
    -- path = path:make_relative(root .. Path.path.sep .. "tests")
    --
    -- if path:find(Path.path.sep) then
    --     path = path:gsub("^.+" .. Path.path.sep, "")
    -- end
    --
    -- path = path:gsub(Path.path.sep, "::")
    --
    -- print(path)
    --
    -- return path
end


function adapter.discover_positions(path)
    -- INFO: in the treesitter query below, the expressione 'parameter_list .' 
    -- allows to match only the first element in the parameter list
    local test_query = [[
        ;;test query
        (function_definition
            declarator: (function_declarator
                (parameter_list .
                      (parameter_declaration) @test.name)) @bar (#match? @bar "BOOST_.*_TEST_CASE")
            body: (compound_statement) @test.definition)

        ;;namespace query
        (call_expression 
          function: (identifier) @foo (#match? @foo "BOOST.*_TEST_SUITE")
          arguments: (argument_list
               (identifier) @namespace.name))
    ]]

    local full_query =
    [[
    (function_declarator
        declarator: (identifier) @macro_name (#match? @macro_name "BOOST_.*_TEST_CASE")
        (parameter_list .
            (parameter_declaration) @test.name))
    ]]

    local query =
    [[
    (function_declarator
        declarator: (identifier) @macro_name (#match? @macro_name "BOOST_.*_TEST_CASE")) @test.definition
    ]]

local parse_options = {
        -- require_namespaces = false, --[[ TODO(pbaldan): check what changes when replacing to true ]]
        position_id = function(position, namespaces)
            return table.concat(
                vim.tbl_flatten({
                    -- path_to_test_path(path),
                    vim.tbl_map(function(pos)
                        return pos.name
                    end, namespaces),
                    position.name,
                }),
                "::"
            )
        end,
    }

    local foo = lib.treesitter.parse_positions(path, test_query, {})

    vim.print(foo)

    return foo
end

function adapter.build_spec(args)
end

function adapter.results(spec, result, tree)
end

local is_callable = function(obj)
    return type(obj) == "function" or (type(obj) == "table" and obj.__call)
end

setmetatable(adapter, {
    __call = function(_, opts)
        if is_callable(opts.args) then
            get_args = opts.args
        elseif opts.args then
            get_args = function()
                return opts.args
            end
        end
        if is_callable(opts.dap_adapter) then
            get_dap_adapter = opts.dap_adapter
        elseif opts.dap_adapter then
            get_dap_adapter = function()
                return opts.dap_adapter
            end
        end
        return adapter
    end,
})

return adapter
