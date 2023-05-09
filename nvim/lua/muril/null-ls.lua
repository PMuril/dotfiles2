local has_null_ls, null_ls = pcall(require, 'null-ls')

if not has_null_ls then
    error("This plugin requires null-ls")
end

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.formatting.cmake_format,
    },
})
