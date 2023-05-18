local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip.loaders.from_vscode").lazy_load({ paths = {
    vim.env.HOME .. "/workspace/sysconfig/snippets/friendly-snippets",
    vim.env.HOME .. "/workspace/sysconfig/snippets/mysnippets"
} })

require("luasnip.loaders.from_lua").load( { paths = {
    vim.env.HOME .. "/workspace/sysconfig/snippets/mysnippets/luasnippets",
} } )

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

-- Icons for LSP integration
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

local my_cmp_mappings =  {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<C-u>"] = cmp.mapping {
        i = function(fallback)
        if luasnip.choice_active() then
            require "luasnip.extras.select_choice"()
        else fallback()
        end
        end,
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = true },
}

luasnip.config.set_config(
    {
        -- TODO: Create autocommand to enable autosnippets on latex/markdown files alone

        enable_autosnippets = false,
        store_selection_keys = "<Tab>",
    }
)

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },

  mapping = my_cmp_mappings,

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
        nvim_lsp = "[LSP]",
        -- nvim_lua = "[Nvim]"
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    -- { name = 'nvim_lua'},   -- we insert this as first becausse neovim recognizes
                            -- automatically that it is only useful in lua buffers
    { name = "luasnip" },
    { name = 'buffer', keyword_length = 5 },
    { name = "path" },
    { name = 'nvim_lsp'},
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  -- experimental = {
  --   ghost_text = true,
    -- native_menu = true,
  -- },
}

require("cmp").setup( {
    enabled = function ()
    return vim.api.nvim_buf_get_option(0, 'buftype') ~= "prompt"
        or require("cmp_dap").is_dap_buffer()
    end
})

require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    sources = {
        { name = "dap" },
    },
})


-- require("cmp").setup.cmdline(
--     '/', {
--         mapping = cmp.mapping.preset.cmdline(my_cmp_mappings),
--         -- mapping = cmp.mapping.preset.cmdline(my_cmp_mappings), It doesn't work
--         sources = {
--         { name = 'buffer' }
--         } } )

-- require("cmp").setup.cmdline(
--     ':', {
--       mapping = cmp.mapping.preset.cmdline(my_cmp_mappings),
--      -- mapping = cmp.mapping.preset.cmdline(my_cmp_mappings), It doesn't work
--
--       sources = cmp.config.sources({
--         { name = 'path' }
--       }, {
--         {
--           name = 'cmdline',
--           option = {
--             ignore_cmds = { 'Man', '!' }
--           }
--         }
--       })
--     })

-- require("cmp").setup.cmdline(
--     '@', {
--        mapping = cmp.mapping.preset.cmdline(my_cmp_mappings),
--       sources = cmp.config.sources({
--         { name = 'path' },
--         { name = 'cmdline'},
--       }),
--     })

-- Commands
vim.cmd [[command! LuaSnipLuaEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]
vim.cmd [[command! LuaSnipVSCodeEdit :lua require("luasnip.loaders.from_vscode").edit_snippet_files()]]


