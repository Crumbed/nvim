local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig then
    return
end

local coc_nvim_lsp_status, coc_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not coc_nvim_lsp then
    return
end

local typescript_setup, typescript = pcall(require, "typescript")
if not typescript then
    return
end


local km = vim.keymap
local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    km.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
    km.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
    km.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
    km.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
    km.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
    km.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
    km.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
    km.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
    km.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
    km.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
    km.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
    km.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig['jdtls'].setup({
    capabilities = capabilities,
    on_attach = on_attach
})

typescript.setup({
    server =  {
        capabilities = capabilities,
        on_attach = on_attach
    }
})


lspconfig["sumneko_lua"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = { -- custom settings for lua
    Lua = {
        -- make the language server recognize "vim" global
        diagnostics = {
            globals = { "vim" },
        },
        workspace = {
            -- make language server aware of runtime files
            library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
            },
        },
    },
},
})

lspconfig['pyright'].setup({
    capabilities = capabilities,
    on_attach = on_attach
})

lspconfig['rust_analyzer'].setup({
    capabilities = capabilities,
    on_attach = on_attach
})

















