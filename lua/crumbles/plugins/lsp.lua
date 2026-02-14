
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.zig',
    callback = function()
        vim.lsp.buf.format { async = true }
    end
})

function Setup()
    local capabilities = nil
    if pcall(require, "cmp_nvim_lsp") then
        capabilities = require("cmp_nvim_lsp").default_capabilities()
    end

    local servers = {
        bashls = true,
        gopls = {
            manual_install = true,
            settings = {
                gopls = {
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true,
                    },
                },
            },
        },
        zls = {
            manual_install = true,
            settings = {
                zls = {
                    enable_build_on_save = true,
                    enable_argument_placeholders = false,
                    build_on_save_args = { "check" },
                },
            },
        },
        lua_ls = {
            cmd = { "lua-language-server" },
        },
        pyright = true,
        jsonls = {
            server_capabilities = {
                documentFormattingProvider = false,
            },
            settings = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                    validate = { enable = true },
                },
            },
        },
        clangd = {
            -- cmd = { "clangd", unpack(require("custom.clangd").flags) },
            -- TODO: Could include cmd, but not sure those were all relevant flags.
            --    looks like something i would have added while i was floundering
            init_options = { clangdFileStatus = true },

            filetypes = { "c" },
        },
    }

    local servers_to_install = vim.tbl_filter(function(key)
        local t = servers[key]
        if type(t) == "table" then
            return not t.manual_install
        else
            return t
        end
    end, vim.tbl_keys(servers))

    require("mason").setup()
    local ensure_installed = {
        "stylua",
        "lua_ls",
    }

    vim.list_extend(ensure_installed, servers_to_install)
    require("mason-tool-installer").setup { ensure_installed = ensure_installed }

    vim.lsp.config("*", {
        capabilities = capabilities,
    })

    for name, config in pairs(servers) do
        if config == true then
            config = {}
        end

        -- Only call vim.lsp.config if there are server-specific settings
        if next(config) ~= nil then
            -- Remove manual_install flag as it's not an LSP config field
            local lsp_config = vim.tbl_deep_extend("force", {}, config)
            lsp_config.manual_install = nil
            vim.lsp.config(name, lsp_config)
        end

        vim.lsp.enable(name)
    end

    local disable_semantic_tokens = {
        -- lua = true,
    }

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local bufnr = args.buf
            local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

            local settings = servers[client.name]
            if type(settings) ~= "table" then
                settings = {}
            end

            local builtin = require "telescope.builtin"

            vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
            -- vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })

            vim.keymap.set({ "n", "i" }, "<C-h>", vim.lsp.buf.signature_help, { buffer = 0 })
            vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = 0 })
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
            vim.keymap.set("n", "gj", builtin.lsp_references, { buffer = 0 })
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
            vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

            vim.keymap.set("n", "<leader>re", vim.lsp.buf.rename, { buffer = 0 })
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
            vim.keymap.set("n", "<leader>wd", builtin.lsp_document_symbols, { buffer = 0 })
            vim.keymap.set("n", "<leader>ww", function()
                builtin.diagnostics { root_dir = true }
            end, { buffer = 0 })

            local filetype = vim.bo[bufnr].filetype
            if disable_semantic_tokens[filetype] then
                client.server_capabilities.semanticTokensProvider = nil
            end

            -- Override server capabilities
            if settings.server_capabilities then
                for k, v in pairs(settings.server_capabilities) do
                    if v == vim.NIL then
                        ---@diagnostic disable-next-line: cast-local-type
                        v = nil
                    end

                    client.server_capabilities[k] = v
                end
            end

        end,
    })

    require("lsp_lines").setup()
    vim.diagnostic.config {virtual_text = true, virtual_lines = false}

    vim.keymap.set("", "<leader>l", function()
        local config = vim.diagnostic.config() or {}
        if config.virtual_text then
            vim.diagnostic.config { virtual_text = false, virtual_lines = true }
        else
            vim.diagnostic.config { virtual_text = true, virtual_lines = false }
        end
    end, { desc = "Toggle lsp_lines" })
end

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
                -- used for completion, annotations and signatures of Neovim apis
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "luvit-meta/library", words = { "vim%.uv" } },
                        { path = "/usr/share/awesome/lib/", words = { "awesome" } },
                    },
                },
            },
            { "Bilal2453/luvit-meta", lazy = true },
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            { "j-hui/fidget.nvim", opts = {} },
            { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
            "b0o/SchemaStore.nvim",
        },
        config = Setup,
    }
}


--
--
--
--return {
--    "neovim/nvim-lspconfig",
--    dependencies = {
--        "williamboman/mason.nvim",
--        "williamboman/mason-lspconfig.nvim",
--        "j-hui/fidget.nvim",
--    },
--    config = function ()
--        setup_cmp()
--
--        require("fidget").setup({})
--        require("mason").setup()
--        require("mason-lspconfig").setup({
--            ensure_installed = {
--                "lua_ls"
--            },
--
--            handlers = {
--                zls = function()
--                    local lspconfig = require("lspconfig")
--                    lspconfig.zls.setup({
--                        settings = {
--                            zls = {
--                                enable_build_on_save = true,
--                                enable_argument_placeholders = false,
--                                build_on_save_args = { "check" },
--                            },
--                        },
--                    })
--                end,
--
--                ["lua_ls"] = function ()
--                    local lspconfig = require("lspconfig")
--                    lspconfig.lua_ls.setup {
--                        settings = {
--                            Lua = {
--                                diagnostics = {
--                                    globals = { "vim" },
--                                },
--                            },
--                        },
--                    }
--                end,
--
--                function(server_name) -- default server handler
--                    require("lspconfig")[server_name].setup {}
--                end,
--            }
--        })
--
--        setup_cmp()
--
--        vim.diagnostic.config({
--            virtual_text = true
--        })
--    end,
--    --"williamboman/mason-lspconfig.nvim",
--    --config = setup,
--
--    --dependencies = {
--    --    "williamboman/mason.nvim",
--    --    "neovim/nvim-lspconfig",
--    --    "hrsh7th/cmp-nvim-lsp",
--    --    "hrsh7th/cmp-buffer",
--    --    "hrsh7th/cmp-path",
--    --    "hrsh7th/cmp-cmdline",
--    --    "hrsh7th/nvim-cmp",
--    --    "L3MON4D3/LuaSnip",
--    --    "saadparwaiz1/cmp_luasnip",
--    --    "j-hui/fidget.nvim",
--    --}
--}
