







return {
    {
        "theprimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local hp = require("harpoon")
            hp:setup()

            vim.keymap.set("n", "<leader>a", function() hp:list():add() end)
            vim.keymap.set("n", "<leader>e", function() hp.ui:toggle_quick_menu(hp:list()) end)

            vim.keymap.set("n", "<leader>1", function() hp:list():select(1) end)
            vim.keymap.set("n", "<leader>2", function() hp:list():select(2) end)
            vim.keymap.set("n", "<leader>3", function() hp:list():select(3) end)
            vim.keymap.set("n", "<leader>4", function() hp:list():select(4) end)
        end,
    }
}
