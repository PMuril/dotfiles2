local M = {}

-- function M.overreturn ()
--     local prev = vim.inspect( vim.opt.formatoptions:get() )
--     -- prev.r = true
--     print(prev)
--     -- vim.opt.formatoptions = curr
-- end

function M.toggler ()
    local prev = vim.opt.formatoptions:get()
    prev.r = not prev.r
    vim.opt.formatoptions = prev
end

vim.api.nvim_create_user_command('ToggleR', ':lua require("muril.textutils").toggler()', {nargs = 0} )


vim.api.nvim_create_user_command('TrimWhitespaces', ':lua vim.cmd([[%s/\\s\\+$//e]])', {nargs = 0} )

---The function moves the cursor to the closest fold in the specified direction
---@param dir movement direction [j|k]
-- function M.next_closed_fold(direction)
--     local toggle_fold_kbd = 'za'
--     local move_kbd = ':' .. direction
--     local toggle_and_move_cmd = 'normal!' .. toggle_fold_kbd .. move_kbd
--
-- end

-- function M.basic_text_objects()
--     local chars = { '_', '.', ':', ',', ';', '|', '/', '\\', '*', '+', '%', '`', '?' }
--     for _,char in ipairs(chars) do
--         for _,mode in ipairs({ 'x', 'o' }) do
--             vim.api.nvim_set_keymap(mode, "i" .. char, string.format(':<C-u>silent! normal! f%sF%slvt%s<CR>', char, char, char), { noremap = true, silent = true })
--             vim.api.nvim_set_keymap(mode, "a" .. char, string.format(':<C-u>silent! normal! f%sF%svf%s<CR>', char, char, char), { noremap = true, silent = true })
--         end
--     end
-- end


-- vim.api.nvim_create_user_command('TrimWhitespaces', ': %s/\s+$//e | exe "normal ``"', {nargs=1} )

-- Custom Treesitter Queries
-- based on https://alpha2phi.medium.com/neovim-101-tree-sitter-d8c5a714cb03
local cpp_enum_class_query_string = [[
 (enum_specifier) @foo
]]

local cpp_enum_class_type_query_string = [[
(enum_specifier
    name: (type_identifier) @etype )
]]


local cpp_enum_item_query_string = [[
(enum_specifier
    name: (type_identifier)
    body: (enumerator_list
            (enumerator) @eitem))
]]

local enum_lookup = {
    eclass = cpp_enum_class_query_string,
    etype = cpp_enum_class_type_query_string,
    eitem = cpp_enum_item_query_string,
}

local itemlistToString = function (enum)
    local type = enum[1]
    local itemlist = enum[2]

    local result = ""
    for _, item in ipairs(itemlist) do
        local foo = string.format(
            [[
                case %s::%s: 
                    result = %s;
                break;
            ]],
            type, item, "\"" .. item .. "\"")
        result = result .. foo
    end

    return result
end

local enumToString = function (enum)

    local vtype = enum[1]
    local vname = vtype:gsub("^%l", string.lower)

return string.format(
    [[
    std::string toString( %s %s)
    {
        std::string result{};
        switch (%s)
        {
            %s
        }

        return result;
    }
]], vtype, vname, vname,  itemlistToString(enum)
)
end


local function unpack_enum(bufnr, lang, enum_node, lookup)
    local etype_query = vim.treesitter.query.parse(lang, lookup.etype)
    local eitem_query = vim.treesitter.query.parse(lang, lookup.eitem)

    local tname
    for _, tcapt, _ in etype_query:iter_matches( enum_node, bufnr) do
        tname = vim.treesitter.get_node_text(tcapt[1], bufnr)
        -- print('Enum class type: ' .. name)
    end

    local item_list = {}
    for _,  icapt, _ in eitem_query:iter_matches( enum_node, bufnr) do
        table.insert( item_list, vim.treesitter.get_node_text(icapt[1], bufnr) )
        -- print('Enum item name: ' .. name)
    end
    local result = {tname, item_list}

    print(enumToString(result))
    return result
end


local function get_enum_classes(bufnr, lang, lookup)
  local parser = vim.treesitter.get_parser(bufnr, lang)
  local syntax_tree = parser:parse()[1]
  local root = syntax_tree:root()
  local query = vim.treesitter.query.parse(lang, lookup.eclass)
  local func_list = {}

  -- for _, captures, metadata in query:iter_matches(root, bufnr) do
  --   local row, col, _ = captures[1]:start()
  --   print("metadata: " .. vim.inspect(metadata))
  --   local name = vim.treesitter.get_node_text(captures[1], bufnr)
  --   print("name: " .. name)
  --   table.insert(func_list, { name, row, col, metadata[1].range })
  -- end

    for _, node, _ in query:iter_captures(root, bufnr) do
        unpack_enum(bufnr, lang, node, lookup)
    end

    -- for pattern, match, _ in query:iter_matches(root, bufnr) do
    --     print("pattern: " .. pattern)
    --     for id, node in pairs(match) do
    --         local name = query.captures[id]
    --         print("name: " .. name)
    --         local txt = vim.treesitter.get_node_text(node, bufnr)
    --         print("enum class dump: " .. txt)
    --     end
    -- end

  return func_list
end


function M.dump_enums(bufnr, lang)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  lang = lang or vim.api.nvim_buf_get_option(bufnr, "filetype")

  -- local query_string = func_lookup[lang]
  local query_string = cpp_enum_class_query_string
  if not query_string then
    vim.notify(lang .. " is not supported", vim.log.levels.INFO)
    return
  end
  local func_list = get_enum_classes(bufnr, lang, enum_lookup)
  -- if vim.tbl_isempty(func_list) then
  --   return
  -- end
  -- local funcs = {}
  -- for _, func in ipairs(func_list) do
  --   table.insert(funcs, func[1])
  -- end
-- vim.api.nvim_buf_set_text()
-- vim.api.nvim_buf_set_lines()
end

vim.api.nvim_create_user_command("TUDumpEnums", ":lua require('muril.textutils').dump_enums()", {nargs = 0})

return M

