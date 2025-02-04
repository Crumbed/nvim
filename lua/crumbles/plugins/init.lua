return {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-context",
    "theprimeagen/refactoring.nvim",
    "eandrju/cellular-automaton.nvim",
    "laytan/cloak.nvim",
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        run = "make install_jsregexp"
    },
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
