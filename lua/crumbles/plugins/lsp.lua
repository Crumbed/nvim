







local function setup_cmp()
    local cmp = require("cmp")

    cmp.setup({
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },

        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-q>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),

        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
        })
    })
end

local function setup()
    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = {
            "lua_ls",
            "rust_analyzer",
            "gopls",
        },

        handlers = {
            function(server_name) -- default server handler
                require("lspconfig")[server_name].setup {}
            end,

            ["lua_ls"] = function ()
                local lspconfig = require("lspconfig")
                lspconfig.lua_ls.setup {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" }
                            }
                        }
                    }
                }
            end
        }
    })

    setup_cmp()

    vim.diagnostic.config({
        virtual_text = true
    })
end


return {
    {"williamboman/mason-lspconfig.nvim",
        config = setup,

        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "j-hui/fidget.nvim",
        }
    },

}
