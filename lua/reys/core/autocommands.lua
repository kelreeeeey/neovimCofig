local api = vim.api

api.nvim_create_autocmd( 'TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
      vim.highlight.on_yank()
    end,
  }
)

api.nvim_create_user_command('ReloadConfig',
function()
    for name, _ in pairs(package.loaded) do
        if name:match('^plugins') then
            package.loaded[name] = nil
        end
    end

    dofile(vim.env.MYVIMRC)
    vim.notify('Nvim configuration reloaded!', vim.log.levels.INFO)
end,
{})

-- api.nvim_create_autocmd(
--     "FIleType",
--     {
--         pattern = "tex" ,
--         group = optional_group,
--         command = "TSBufDisable highlight"
--     }
-- )
