


local km = vim.keymap
local autocmd = vim.api.nvim_create_autocmd


km.set("n", "<leader><leader>", ":so<enter>")
km.set("n", "<leader>pv", vim.cmd.Ex)
km.set("i", "jk", "<esc>")

km.set("n", "d{", "di{")
km.set("n", "y{", "yi{")
km.set("n", "c{", "ci{")

km.set("n", "d(", "di(")
km.set("n", "y(", "yi(")
km.set("n", "c(", "ci(")

km.set("n", "d\"", "di\"")
km.set("n", "y\"", "yi\"")
km.set("n", "c\"", "ci\"")

km.set("n", "d<", "di<")
km.set("n", "y<", "yi<")
km.set("n", "c<", "ci<")

km.set("n", "<C-u>", "<C-u>zz")
km.set("n", "<C-d>", "<C-d>zz")

km.set("n", "j", "jzz")
km.set("n", "k", "kzz")

km.set("v", "J", ":m '>+1<CR>gv=gv")
km.set("v", "K", ":m '<-2<CR>gv=gv")



autocmd("LspAttach", {
    group = CrumblesGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
 
        km.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        km.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        km.set("n", "<leader>d", function() vim.diagnostic.open_float() end, opts)
        km.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        km.set("n", "<leader>re", function() vim.lsp.buf.rename() end, opts)
        km.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end
})



















