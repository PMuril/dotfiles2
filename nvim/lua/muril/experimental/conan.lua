local M = {}

M.conan_packages_paths = {} --[[ override any  ]]
M.conan_packages_names = {} --[[ override any  ]]
M.conan_profile = nil

function set_profile()
    local profile_handle = io.popen("conan profile list")
end

function M.fill_packages_paths()

    M.conan_packages_paths = {} --[[ override any  ]]
    M.conan_packages_names = {} --[[ override any  ]]

    local conan_profile = "sensor_14"

    local lsp_wks = vim.fn.getcwd()
    local handle = io.popen("source /home/pbaldan/Conanenv/bin/activate && conan info " ..
        lsp_wks ..
        "/conanfile.py --paths --only build_folder -pr " ..
        conan_profile ..
        "| grep -o '/home.*' | awk -F'/' '{print $6, $0}'")

    while true do
        local pkg_info = handle:read()
        if pkg_info == nil then break
        else
            local k, v = string.match(pkg_info, "([^ ]+) ([^ ]+)")
            M.conan_packages_paths[k] = v
            table.insert(M.conan_packages_names, k)
        end
    end
end

function M.get_packages_paths()
    print(vim.inspect( M.conan_packages_paths) )
end

function M.get_packages_names()
    print(vim.inspect( M.conan_packages_names ) )
end

function M.add_conan_dir_to_wksp()
    vim.ui.select( M.conan_packages_names, {
        prompt = "Select a Conan package",
        }, function(package, _ --[[  idx ]])
        if package then
            local package_path = M.conan_packages_paths[package]
            vim.cmd.Explore(package_path)

            print("Added package " .. package .. "to LSP workspace folder")
        else
            print("You cancelled")
        end
            end)
end

function M.open_data_dir()
    vim.ui.select( M.conan_packages_names, {
        prompt = "Select a Conan package to open",
    }, function(package, _ --[[  idx ]])
    if package then
        local package_path = M.conan_packages_paths[package]
        -- vim.api.nvim_set_current_dir(package_path)
        vim.cmd('cd ' .. package_path)
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
vim.api.nvim_create_user_command('ConanOpenDataDir', ':lua require"muril.experimental.conan".open_data_dir()<CR>', {nargs = 0})

return M
