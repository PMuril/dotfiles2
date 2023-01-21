local has_telescope, telescope = pcall(require, "telescope")

if not has_telescope then 
    error("This plugin requires nvim-telescope/telescope.nvim")
end
-- local pickers = require("telescope.pickers")
-- local finders = require("telescope.finders")
-- local conf    = require("telescope.config").values
--
-- local colors = function(opts)
--     opts = opts or {}
--     pickers.new(opts, {
--         prompt_title ="colors",
--         finder = finders.new_table {
--             results = { "red", "green", "blue"}
--         },
--         sorter = conf.generic_sorter(opts),
--     }):find()
-- end

  -- local should_reload = true
  -- local reloader = function ()
  --     if should_reload then
  --         RELOAD('plenary')
  --         RELOAD('telescope')
  --     end
  -- end

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


return require("telescope").register_extension {
    setup = function(ext_config, config)
    end,

    exports = {
        find_notes = find_notes,
        nvim_files = edit_neovim,
    }
}
