local nvim_lsp = require('lspconfig')
local servers = { 'clangd', 'cmake', 'bashls', 'ltex', 'sumneko_lua' }

for _, server in ipairs(servers) do
        nvim_lsp[server].setup {
    }
end


require('lspconfig').texlab.setup {
    settings = {
      texlab = {
        auxDirectory = ".",
        bibtexFormatter = "texlab",
        build = {
          args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
          executable = "latexmk",
          forwardSearchAfter = false,
          onSave = false
        },
        chktex = {
          onEdit = false,
          onOpenAndSave = false
        },
        diagnosticsDelay = 300,
        formatterLineLength = 80,
        forwardSearch = {
          args = {}
        },
        latexFormatter = "latexindent",
        latexindent = {
          modifyLineBreaks = true
        }
      }
    }
}

vim.lsp.set_log_level("trace") -- TODO remove when lsp debugging  is completed
