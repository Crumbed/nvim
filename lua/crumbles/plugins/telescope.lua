





return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",

        dependencies = { "nvim-lua/plenary.nvim" },

        config = function()
            require("telescope").setup({})
        end,

        keys = {
            { '<leader>pf', "<cmd>Telescope find_files<cr>" },
            { '<C-p>', "<cmd>Telescope git_files<cr>" },
            { '<leader>ps', "<cmd>Telescope live_grep<cr>" },
        }
    }

}
