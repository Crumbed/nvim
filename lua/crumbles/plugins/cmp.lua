--local function setup_cmp()
--    local cmp = require("cmp")
--
--    cmp.setup({
--        snippet = {
--            expand = function(args)
--                require("luasnip").lsp_expand(args.body)
--            end,
--        },
--
--        mapping = cmp.mapping.preset.insert({
--            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--            ['<C-f>'] = cmp.mapping.scroll_docs(4),
--            ['<C-Space>'] = cmp.mapping.complete(),
--            ['<C-q>'] = cmp.mapping.abort(),
--            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--        }),
--
--        sources = cmp.config.sources({
--            { name = "nvim_lsp" },
--            { name = "luasnip" },
--            { name = "buffer" },
--        })
--    })
--end

local function snip()
    local ls = require("luasnip")

    -- TODO: Think about `locally_jumpable`, etc.
    -- Might be nice to send PR to luasnip to use filters instead for these functions ;)

    vim.snippet.expand = ls.lsp_expand

    ---@diagnostic disable-next-line: duplicate-set-field
    vim.snippet.active = function(filter)
        filter = filter or {}
        filter.direction = filter.direction or 1

        if filter.direction == 1 then
            return ls.expand_or_jumpable()
        else
            return ls.jumpable(filter.direction)
        end
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    vim.snippet.jump = function(direction)
        if direction == 1 then
            if ls.expandable() then
                return ls.expand_or_jump()
            else
                return ls.jumpable(1) and ls.jump(1)
            end
        else
            return ls.jumpable(-1) and ls.jump(-1)
        end
    end

    vim.snippet.stop = ls.unlink_current
end

function CMP()
    snip()

    vim.opt.completeopt = { "menu", "menuone", "noselect" }
    vim.opt.shortmess:append "c"

    local lspkind = require "lspkind"
    lspkind.init {
        symbol_map = {
            Copilot = "",
        },
    }

    vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

    local kind_formatter = lspkind.cmp_format {
        mode = "symbol_text",
        menu = {
            buffer = "[buf]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[api]",
            path = "[path]",
            luasnip = "[snip]",
            gh_issues = "[issues]",
            tn = "[TabNine]",
            eruby = "[erb]",
        },
    }

    local cmp = require "cmp"
    cmp.setup {
        sources = {
            {
                name = "lazydev",
                group_index = 0,
            },
            { name = "luasnip" },
            { name = "nvim_lsp" },
            { name = "path" },
            { name = "buffer" },
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-q>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        snippet = {
            expand = function(args)
                vim.snippet.expand(args.body)
            end,
        },
        formatting = {
            fields = { "abbr", "kind", "menu" },
            expandable_indicator = true,
            format = function(entry, vim_item)
                -- Lspkind setup for icons
                vim_item = kind_formatter(entry, vim_item)

                -- Tailwind colorizer setup
                -- vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)

                return vim_item
            end,
        },
        sorting = {
            priority_weight = 2,
            comparators = {
                -- Below is the default comparitor list and order for nvim-cmp
                cmp.config.compare.offset,
                -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                cmp.config.compare.exact,
                cmp.config.compare.score,
                cmp.config.compare.recently_used,
                cmp.config.compare.locality,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },
    }
end

return {
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        priority = 100,
        dependencies = {
            "onsails/lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
            "saadparwaiz1/cmp_luasnip",
            --{
            --    "supermaven-inc/supermaven-nvim",
            --    config = function()
            --        require("supermaven-nvim").setup {
            --            -- disable_inline_completion = true,
            --        }
            --    end,
            --},
        },
        config = CMP,
    },
}
