 -- sets the leader key
vim.g.mapleader = "\\"

local key_mapper = vim.keymap.set

-- -- Disable ex mode
key_mapper('n', 'Q', '<Nop>')

-- MOVEMENT KEYS
-- Disables arrows keys in Normal Mode nnoremap <Up> <Nop>
key_mapper('n', '<Up>', '<Nop>', {noremap = true} )
key_mapper('n', '<Down>', '<Nop>', {noremap = true} )
key_mapper('n', '<Left>', '<Nop>', {noremap = true} )
key_mapper('n', '<Right>', '<Nop>', {noremap = true} )

-- Disables arrows keys in Insert Mode
key_mapper('i', '<Up>', '<Nop>', {noremap = true} )
key_mapper('i', '<Down>', '<Nop>', {noremap = true} )
key_mapper('i', '<Left>', '<Nop>', {noremap = true} )
key_mapper('i', '<Right>', '<Nop>', {noremap = true} )


-- HIGHLIGHTING
-- makes the highlight under the current line persistent
-- press \l to highlight, :match to remove the highlight
-- opts = { noremap=true, silent=true }
-- key_mapper('', '<Leader>l ', "ml:execute 'match Search /\%'.line('.').'l/'<CR>", opts )

-- FUZZY SEARCH
--
-- key_mapper('n', '<C-p>', ':lua require"telescope.builtin".find_files()<CR>')
-- key_mapper('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
-- key_mapper('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
-- key_mapper('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')
--
--
--
-- -- LSP
key_mapper('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
key_mapper('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
key_mapper('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
key_mapper('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>')
key_mapper('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>')
key_mapper('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
key_mapper('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>')
key_mapper('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
key_mapper('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>')
key_mapper('n', '<leader>af', ':lua vim.lsp.buf.code_action()<CR>')
key_mapper('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
--
--
--
