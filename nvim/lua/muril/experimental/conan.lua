local M = {}

conan_packages_path = {} --[[ override any  ]]
conan_packages_names = {} --[[ override any  ]]

function M.fill_packages_paths()

    conan_packages_path = {} --[[ override any  ]]
    conan_packages_names = {} --[[ override any  ]]

    local lsp_wks = "/home/pbaldan/workspace/Virgilius/EcmLibraryConverter"
    -- local lsp_wks = vim.fn.getcwd()
    local handle = io.popen("source /home/pbaldan/Conanenv/bin/activate && conan info " .. 
        lsp_wks .. 
        "/conanfile.py --paths --only build_folder | grep -o '/home.*' | awk -F'/' '{print $6, $0}'")

    while true do
         pkg_info = handle:read()
        if pkg_info == nil then break
        else
            k, v = string.match(pkg_info, "([^ ]+) ([^ ]+)")
            conan_packages_path[k] = v
            table.insert(conan_packages_names, k)
        end
    end
end

function M.get_packages_paths()
    print(vim.inspect( conan_packages_path) )
end

function M.get_packages_names()
    print(vim.inspect( conan_packages_names ) )
end

function M.add_conan_dir_to_wksp()
    vim.ui.select( conan_packages_names, {
        prompt = "Select a Conan package",
        }, function(package, idx)
        if package then
            package_path = conan_packages_path[package]
            print(package_path)
            vim.lsp.buf.add_workspace_folder(package_path)
           print("Added package " .. package .. "to LSP workspace folder") 
        else
            print("You cancelled")  
        end
            end)
end

-- Commands
vim.api.nvim_create_user_command('ConanAddDir', ':lua require"muril.experimental.conan".add_conan_dir_to_wksp()<CR>', {nargs = 0})
vim.api.nvim_create_user_command('ConanFilePath', ':lua require"muril.experimental.conan".get_packages_paths()<CR>', {nargs = 0})
vim.api.nvim_create_user_command('ConanFileNames', ':lua require"muril.experimental.conan".get_packages_names()<CR>', {nargs = 0})
vim.api.nvim_create_user_command('ConanFillPaths', ':lua require"muril.experimental.conan".fill_packages_paths()<CR>', {nargs = 0})

return M
