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

local function workspace_path()
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
    -- event = { "VeryLazy" },
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
      search_max_lines = 250,
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

      ---@return table
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
          note:add_alias(note.title)
        end

        local out = { id = note.id, aliases = note.aliases, tags = note.tags,
                      created = note.created }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,
    },
}
