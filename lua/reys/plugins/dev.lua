if vim.loop.os_uname().sysname ~= "Linux" then
    return {
            {
                dir = "~/Kelreys/nvim-plugins/present.nvim",
                config = function()
                    require("present").setup({
                        name = "Rey"
                    })
                end
            },
    }
else
    return {
        {},
    }
end
