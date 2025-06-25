







function setup_trouble()
    require("trouble").setup {
        icons = false,
    }
end


return {
    {
        "folke/trouble.nvim",
        config = setup_trouble
    },
}
