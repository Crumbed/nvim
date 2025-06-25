





return {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/playground",
    "theprimeagen/refactoring.nvim",
    "nvim-treesitter/nvim-treesitter-context",
    "eandrju/cellular-automaton.nvim",
    "laytan/cloak.nvim",
    {
        "github/copilot.vim",
        enabled = false
    },

    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle }
        }
    }
}
