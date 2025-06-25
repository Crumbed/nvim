

local function colors()
    require("rose-pine").setup({
        disable_background = true
    })

    vim.cmd("colorscheme rose-pine")
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end


return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = colors
    }
}
