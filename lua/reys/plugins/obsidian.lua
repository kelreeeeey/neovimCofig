-- both exists() and isdir we're coming from stack overflow https://stackoverflow.com/a/40195356/28689941
local function exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

local function isdir(path)
   return exists(path.."/")
end

function workspace_path()
    if isdir("C:\\Users\\Lenovo\\obsidian_vault") then
        print("You're in your home")
        return {
                {
                    name = 'Kelrey\'s',
                    path = "~/obsidian_vault",
                    overrides = {
                        templates = {
                            folder = "~/obsidian_vault/bins/templates",
                            date_format = '%Y-%b-%d',
                            time_format = '%H:%M:%m',
                        },
                    }
                },
            }
    else
        print("You're in Geosiesmal's house")
        return {
            {
                name = 'Kelreys on Lediapad',
                path = "~/obsidian_vaults",
                overrides = {
                    templates = {
                        folder = "~/obsidian_vaults/bins/templates",
                        date_format = '%Y-%b-%d',
                        time_format = '%H:%M:%m',
                    },
                    notes_subdir = "./",
                }
            },
            {
                name = 'yap on public',
                path = "~/obsidian_public",
                overrides = {
                    templates = {
                        folder = "~/obsidian_public/bins/templates/neovim",
                        date_format = '%Y-%b-%d',
                        time_format = '%H:%M:%m',
                    },
                    notes_subdir = "content",
                }
            }
        }
    end
end

return{
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      workspaces = workspace_path(),

      daily_notes = {
        folder = 'log/daily',
      },

      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },

      preferred_link_style = 'markdown',
      markdown_link_func = function(opts)
        return require('obsidian.util').markdown_link(opts)
      end,
      sort_by = 'modified',
      sort_reversed = true,
      search_max_lines = 1000,
      picker = {
        name = 'telescope.nvim',
        note_mappings = {
          new = '<C-x>',
          insert_link = '<C-l>',
        },
        tag_mappings = {
          tag_note = '<C-x>',
          insert_tag = '<C-l>',
        },
      },
      ---@param url string
      follow_url_func = function(url)
        vim.ui.open(url) -- need Neovim 0.10.0+
      end,
      ---@param img string
      follow_img_func = function(img)
        vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
      end,

      use_advanced_uri = true,
      open_app_foreground = false,
      open_notes_in = 'vsplit',
      ui = {
        enable = false,
      },
    },
}
