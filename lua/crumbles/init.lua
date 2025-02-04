require("crumbles.set")
require("crumbles.lazy")
require("crumbles.remap")


local augroup = vim.api.nvim_create_augroup
local group = augroup("Crumbles", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})


function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40
        })
    end,
})



--autocmd({ "BufWritePre" }, {
--    group = group,
--    pattern = "*",
--    callback = function()
--        vim.api.nvim_command([[silent! %s/\s\+$//e]])
--        vim.lsp.buf.format()
--    end,
--})


autocmd("LspAttach", {
    group = group,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>re", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end
})
