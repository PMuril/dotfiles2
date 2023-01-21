local nvim_lsp = require('lspconfig')
local servers = {
    'neocmake', 
    'texlab',
    'marksman',
    'pyright',
    --'pylsp',
}

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

-- require("clangd_extensions").prepare()

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("clangd_extensions").setup {
    server = {
        capabilities = capabilities,
        cmd = {
            "clangd",
            "-j=3",
            "--log=info",
            "--pretty",
            "--background-index",
            "--all-scopes-completion",
            "--clang-tidy",
            "--function-arg-placeholders",
            "--header-insertion=never",
            "--header-insertion-decorators",
            "--completion-style=detailed",
        },
    },
    extensions = {
        -- defaults:
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,
        -- These apply to the default ClangdSetInlayHints command
        inlay_hints = {
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",
            -- whether to show parameter hints with the inlay hints or not
            show_parameter_hints = true,
            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",
            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = "Comment",
            -- The highlight group priority for extmark
            priority = 100,
        },
        ast = {
            -- These are unicode, should be available in any font
            role_icons = {
                 type = "🄣",
                 declaration = "🄓",
                 expression = "🄔",
                 statement = ";",
                 specifier = "🄢",
                 ["template argument"] = "🆃",
            },
            kind_icons = {
                Compound = "🄲",
                Recovery = "🅁",
                TranslationUnit = "🅄",
                PackExpansion = "🄿",
                TemplateTypeParm = "🅃",
                TemplateTemplateParm = "🅃",
                TemplateParamObject = "🅃",
            },
            --[[ These require codicons (https://github.com/microsoft/vscode-codicons)
            role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
            },

            kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
            }, ]]

            highlights = {
                detail = "Comment",
            },
        },
        memory_usage = {
            border = "none",
        },
        symbol_info = {
            border = "none",
        },
    },
}



require('lspconfig').clangd.setup {
    capabilities = capabilities,
    cmd = {
        "clangd",
        -- "-j=3",
        -- "--log=info",
        -- "--pretty",
        -- "--background-index",
        -- "--all-scopes-completion",
        -- "--clang-tidy",
        -- "--function-arg-placeholders",
        -- "--header-insertion=never",
        -- "--header-insertion-decorators",
        -- "--completion-style=detailed",
    }
}

require('lspconfig').bashls.setup {
    cmd_env = { SHELLCHECK_PATH = '/home/pbaldan/workspace/sysconfig/lsp/bashlsp/shellcheck/shellcheck' }
}

require('lspconfig').marksman.setup {
    cmd = { "/home/pbaldan/workspace/sysconfig/lsp/marksman/marksman", "server" }
}

vim.lsp.set_log_level("info") 
