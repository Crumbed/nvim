

local function copilot_setup()
    local copilot = require("copilot")
    --local km = vim.keymap
    --        vim.keymap.set("n", "<leader>p", function()
    --            vim.cmd.Git('push')
    --        end, opts)
    copilot.setup({
        suggestion = { enabled=true }
    })
end


return {
    "ThePrimeagen/vim-be-good",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/playground",
    "theprimeagen/refactoring.nvim",
    "nvim-treesitter/nvim-treesitter-context",
    "eandrju/cellular-automaton.nvim",
    "laytan/cloak.nvim",
    {
        "github/copilot.vim",
        enabled = true,
    },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle }
        }
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    }
}
