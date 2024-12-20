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

local workspace_path = function()
  if isdir("D:\\KELREY'S\\Temporary Vaults") then
    print("You're in your home")
    return {
        name = 'Kelrey\'s',
        path = "D:\\KELREY'S\\Temporary Vaults",
        overrides = {
          notes_subdir = 'vim_notes',
          templates = {
            folder = "D:\\KELREY'S\\Temporary Vaults\\bins\\templates",
            date_format = '%Y-%b-%d',
            time_format = '%H:%M:%m',
          },
          new_notes_location = 'notes_subdir',

        }
      }
  else
    print("You're in Geosiesmal's house")
    return {
        name = 'LediaPed',
        path = "C:\\Users\\LediaPed\\Kelreys\\obsidian_vaults",
        overrides = {
          notes_subdir = 'vim_notes',
          templates = {
            folder = "C:\\Users\\LediaPed\\Kelreys\\obsidian_vaults\\bins\\templates",
            date_format = '%Y-%b-%d',
            time_format = '%H:%M:%m',
          },
          new_notes_location = 'notes_subdir',

        }
      }
  end
end

return{ -- Obsidian
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      workspace_path(),
    },

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
      enable = true,
    },
  },
}
