






return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                icons = false
            })
        end,

        keys = {
            { "<leader>tt", function()
                require("trouble").toggle()
            end },

            { "<leader>tn", function()
                require("trouble").next({ skip_groups = true, jump = true })
            end },

            { "<leader>tu", function()
                require("trouble").previous({ skip_groups = true, jump = true })
            end },

            { "<leader>qf", function()
                require("trouble").toggle("quickfix")
            end },
        }
    }
}
