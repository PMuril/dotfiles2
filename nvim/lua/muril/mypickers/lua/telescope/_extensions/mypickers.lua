local has_telescope, telescope = pcall(require, "telescope")

if not has_telescope then 
    error("This plugin requires nvim-telescope/telescope.nvim")
end

local edit_neovim = function()

  require('telescope.builtin').find_files {
      shorten_path = true,
      cwd = "~/.config/nvim",
      prompt = "Neovim files",
      height = 10,

      layout_strategy = 'horizontal',
      layout_options = {
          preview_width = 0.75,
      }
  }
end

local find_notes = function()

  require('telescope.builtin').find_files {
      shorten_path = true,
      cwd = "~/workspace/myannotations/dendron/notes",
      prompt = "Annotations",
      height = 10,

      layout_strategy = 'horizontal',
      layout_options = {
          preview_width = 0.75,
      }
  }
end

local find_test_files = function () 

    require('telescope.builtin').find_files {
        shorten_path = true,
        cwd = vim.fn.getcwd() .. "test/elt",
        prompt = "Find Test Files",
        height = 10,

        layout_strategy = 'horizontal',
        layout_options = {
            preview_width = 0.75,
        }
    }
end


--  local find_args = function()
--     vim.api.nvim_ar
--     require('telescope.builtin').
-- end


return require("telescope").register_extension {
    setup = function(ext_config, config)
    end,

    exports = {
        find_notes = find_notes,
        nvim_files = edit_neovim,
        test_files = find_test_files,
    }
}
