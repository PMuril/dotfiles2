-- Module that defines custom NeoVim keybindings
-- mapleader key is defined in the 'options' module
--
local key_mapper = vim.keymap.set

-- -- Disable ex mode
key_mapper('n', 'Q', '<Nop>')

-- MOVEMENT KEYS
-- Disables arrows keys in Normal Mode nnoremap <Up> <Nop>
key_mapper('n', '<Up>', '<Nop>', {noremap = true} )
key_mapper('n', '<Down>', '<Nop>', {noremap = true} )
key_mapper('n', '<Left>', '<Nop>', {noremap = true} )
key_mapper('n', '<Right>', '<Nop>', {noremap = true} )
-- -- Disables arrows keys in Insert Mode
key_mapper('i', '<Up>', '<Nop>', {noremap = true} )
key_mapper('i', '<Down>', '<Nop>', {noremap = true} )
key_mapper('i', '<Left>', '<Nop>', {noremap = true} )
key_mapper('i', '<Right>', '<Nop>', {noremap = true} )
key_mapper('n', '<BS>', ':noh<CR>', {silent = true, noremap = true} )


-- HIGHLIGHTING
-- makes the highlight under the current line persistent
-- press \l to highlight, :match to remove the highlight
-- opts = { noremap=true, silent=true }
-- key_mapper('', '<Leader>l ', "ml:execute 'match Search /\%'.line('.').'l/'<CR>", opts )

-- [[ TELESCOPE ]] 
-- git
key_mapper('n', '<leader>gc', ':lua require"telescope.builtin".git_commits()<CR>')
key_mapper('n', '<leader>gs', ':lua require"telescope.builtin".git_status()<CR>')
key_mapper('n', '<leader>gb', ':lua require"telescope.builtin".git_branches()<CR>')
-- lsp
key_mapper('n', '<leader>fd', ':lua require"telescope.builtin".lsp_document_symbols()<CR>')
key_mapper('n', '<leader>fe', ':lua require"telescope.builtin".diagnostics()<CR>')
key_mapper('n', '<leader>fw', ':lua require"telescope.builtin".lsp_dynamic_workspace_symbols()<CR>')
key_mapper('n', '<leader>fr', ':lua require"telescope.builtin".lsp_references()<CR>')
key_mapper('n', '<leader>fi', ':lua require"telescope.builtin".lsp_incoming_calls()<CR>')
key_mapper('n', '<leader>fI', ':lua require"telescope.builtin".lsp_implementations()<CR>')
-- dap 
key_mapper('n', '<leader>bb', ':lua require"telescope".extensions.dap.list_breakpoints()<CR>')
key_mapper('n', '<leader>bf', ':lua require"telescope".extensions.dap.frames()<CR>')
key_mapper('n', '<leader>bc', ':lua require"telescope".extensions.dap.configurations()<CR>')
-- bookmarks
key_mapper('n', '<leader>k', ':lua require"telescope".extensions.vim_bookmarks.all()<CR>') --[[ 'Displays all the boo[k]marks in the current project' ]]
--
-- misc
key_mapper('n', '<C-p>',      ':lua require"telescope.builtin".find_files()<CR>')
key_mapper('n', '<leader>fs', ':lua require"telescope.builtin".grep_string()<CR>')
-- key_mapper('n', '<leader>lg', ':lua require"telescope.builtin".live_grep()<CR>')
key_mapper('n', '<leader>lg', ':lua require"telescope".extensions.live_grep_args.live_grep_args()<CR>')
key_mapper('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
key_mapper('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')
key_mapper('n', '<leader>fj', ':lua require"telescope.builtin".jumplist()<CR>')
key_mapper('n', '<leader>fo', ':lua require"telescope.builtin".oldfiles()<CR>') --[[ Displays all the recent ([o]ld) files opened') ]]
-- custom pickers
key_mapper('n', '<leader>fn', ':lua require"telescope".extensions.mypickers.find_notes()<CR>')
key_mapper('n', '<leader>ft', ':lua require"telescope".extensions.mypickers.test_files()<CR>')
key_mapper('n', '<C-s>', ':lua require"telescope".extensions.mypickers.nvim_files()<CR>')

--
-- [[ LSP ]] 

-- local bufopts = {noremap = true, silent=true, buffer=bufnr }
key_mapper('n', '<leader>wl', ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
key_mapper('n', '<leader>do', ':lua vim.diagnostic.open_float()<CR>')
key_mapper('n', '[d'        , ':lua vim.diagnostic.goto_prev()<CR>')
key_mapper('n', ']d'        , ':lua vim.diagnostic.goto_next()<CR>')
key_mapper('n', '[e'        , ':lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>')
key_mapper('n', ']e'        , ':lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>')
key_mapper('n', 'gd'        , ':lua vim.lsp.buf.definition()<CR>')
key_mapper('n', 'gD'        , ':lua vim.lsp.buf.declaration()<CR>')
key_mapper('n', 'gi'        , ':lua vim.lsp.buf.implementation()<CR>')
key_mapper('n', 'gw'        , ':lua vim.lsp.buf.document_symbol()<CR>')
key_mapper('n', 'gW'        , ':lua vim.lsp.buf.workspace_symbol()<CR>')
key_mapper('n', 'gr'        , ':lua vim.lsp.buf.references()<CR>')
key_mapper('n', 'gt'        , ':lua vim.lsp.buf.type_definition()<CR>')
key_mapper('n', 'K'         , ':lua vim.lsp.buf.hover()<CR>')
key_mapper('n', 'gs'        , ':lua vim.lsp.buf.signature_help()<CR>')
key_mapper('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
key_mapper('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')
key_mapper('n', '<leader>ff', ':lua vim.lsp.buf.format { async = true }<CR>')
key_mapper('n', '<C-w>gd'   , ':belowright vsplit | lua vim.lsp.buf.definition()<CR>')
key_mapper('n', '<C-w>gD'   , ':belowright vsplit | lua vim.lsp.buf.declaration()<CR>')


-- See `:help vim.diagnostic.*` for documentation on any of the below functions
--
key_mapper('n', '<M-o>', ': ClangdSwitchSourceHeader<CR>')
-- key_mapper('n', '<M-t>', ': SwitchSourceTestSuite<CR>')
--
-- [[ DAP ]] 
key_mapper('n', '<F5>',  ':lua require"dap".continue()<CR>')
key_mapper('n', '<F10>', ':lua require"dap".step_over()<CR>')
key_mapper('n', '<F11>', ':lua require"dap".step_into()<CR>')
key_mapper('n', '<F12>', ':lua require"dap".step_out()<CR>')
key_mapper('n', 'gbb', ':lua require"dap".toggle_breakpoint()<CR>')
key_mapper('n', 'gbB', ':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
key_mapper('n', 'gbl', ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
key_mapper('n', 'gbr', ':lua require"dap".repl.open()<CR>')
key_mapper('n', '<leader>bi', ':lua require"dap.ui.widgets".hover()<CR>')
key_mapper('n', '<leader>bp', ':lua require"dap.ui.widgets".preview()<CR>')
key_mapper('n', '<leader>b?', ':lua local widgets=require"dap.ui.widgets"; widgets.centered_float(widgets.scopes)<CR>')
key_mapper('n', '<leader>bt', ':lua local widgets=require"dap.ui.widgets"; widgets.centered_float(widgets.threads)<CR>')
key_mapper('n', '<Leader>bs', ':lua local widgets=require"dap.ui.widgets"; widgets.centered_float(widgets.scopes)<CR>') 
-- key_mapper('n', '<leader>ba', ':lua require"debugHelper".attach()<CR>')

-- [[ Completion ]]
-- Luasnip
key_mapper('n', '<space>ss', ':lua require"luasnip.loaders.from_lua".load( { paths = {"~/workspace/sysconfig/snippets/mysnippets/luasnippets"} } )<CR>')
-- key_mapper('i', '<C-u>', ':lua require("luasnip.extras.select_choice")<CR>')

key_mapper({ 'i', 's' }, '<C-e>', function () 
    if require"luasnip".expand_or_jumpable () then
        require"luasnip".expand_or_jump()
    end
end, { silent = true })
--
key_mapper({ 'i', 's' }, '<C-d>', function () 
    if require"luasnip".jumpable(-1) then
        require"luasnip".jump(-1)
    end
end, { silent = true })
--
key_mapper({ 'i', 's' }, '<C-l>', function () 
    if require"luasnip".choice_active() then
        require"luasnip".change_choice(1)
    end
end, { silent = true })
-- key_mapper('n', '<leader><leader>s', '<cmd>source ~/wo ')

-- [[ Bookmarks ]]
key_mapper('n', ']k', ': BookmarkNext<CR>')
key_mapper('n', '[k', ': BookmarkPrev<CR>')
key_mapper('n', 'gkt', ': BookmarkToggle<CR>')
key_mapper('n', 'gka', ': BookmarkAnnotate<CR>')

--[[ Lists navigation ]]
-- Arglist
key_mapper('n', ']a', ': next<CR>')
key_mapper('n', '[a', ': prev<CR>')

-- 
-- [[ GitSigns ]]
 -- Navigation
key_mapper('n', ']h', ': Gitsigns next_hunk<CR>')
key_mapper('n', '[h', ': Gitsigns prev_hunk<CR>')
key_mapper('n', 'ghp', ': Gitsigns preview_hunk<CR>')
key_mapper({'n', 'v'}, 'ghs', ': Gitsigns stage_hunk<CR>')
key_mapper('n', 'ghu', ': Gitsigns undo_stage_hunk<CR>')
key_mapper({'n', 'v'}, 'ghr', ': Gitsigns reset_hunk<CR>')
