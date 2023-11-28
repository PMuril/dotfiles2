local nvim_lsp = require('lspconfig')
local servers = {
    'neocmake',
    'texlab',
    'marksman',
    'pyright',
    --'pylsp',
    -- 'awk_ls',
    -- 'lemminx', -- xml lsp
    -- 'yamlls'
}

for _, server in ipairs(servers) do
        nvim_lsp[server].setup {
    }
end

local on_attach = function(client, bufnr) vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc') end

require('lspconfig').lua_ls.setup {
    settings = {
        Lua = {
            completion = {      -- Required by neodev
                callSnippet = "Replace",
            },
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

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
          executable = "sioyek",
          args = {
            "--inverse-search",
            "'nvim' %1 +%2",
            "--reuse-instance",
            "--forward-search-file",
            "%f",
            "--forward-search-line",
            "%l",
            "%p",
          }
        },
        latexFormatter = "latexindent",
        latexindent = {
          modifyLineBreaks = true
        }
      }
    }
}

-- require("clangd_extensions").prepare()

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require("clangd_extensions").setup {
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {
            "clangd",
            "-j=3",
            "--log=verbose",
            "--pretty",
            "--background-index",
            "--enable-config",
            "--all-scopes-completion",
            "--function-arg-placeholders",
            "--header-insertion=iwyu",
            "--header-insertion-decorators",
            "--completion-style=detailed",
            "--clang-tidy",  --TODO: check if the clangd-tidy flag is required or if it is sufficient to declare cland-tidy checks in the clangd configuration file
        },
    },
}

require('lspconfig').bashls.setup {
    cmd_env = { SHELLCHECK_PATH = '/home/pbaldan/workspace/sysconfig/lsp/bashlsp/shellcheck/shellcheck' }
}

require('lspconfig').marksman.setup {
    -- cmd = { "/home/pbaldan/workspace/sysconfig/lsp/marksman/marksman", "server" }
}

vim.lsp.set_log_level("INFO")
