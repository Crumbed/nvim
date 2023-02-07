-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'


    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- use ( 'dikiaap/minimalist' )
    -- use ( 'ayu-theme/ayu-vim' )
    -- use ( 'preservim/vim-colors-pencil' )
    use ( 'joshdick/onedark.vim' )
    use ( 'sheerun/vim-polyglot' )

    use ( 'ThePrimeagen/harpoon' )
    use ( 'mbbill/undotree' )
    use ( 'tpope/vim-fugitive' )
    use ( 'tpope/vim-commentary' )-- For Commenting gcc & gc 
    use ( 'terryma/vim-multiple-cursors' )-- CTRL + N for multiple cursors
    use ( 'preservim/tagbar' )-- Tagbar for code navigation
    use ( 'kshenoy/vim-signature' )
    use ( 'tpope/vim-surround' )-- Surround text with ys
    use ( 'vim-airline/vim-airline' ) -- Status bar

    use ( 'hrsh7th/nvim-cmp' )
    use ( 'hrsh7th/cmp-buffer' )
    use ( 'hrsh7th/cmp-path' )

    use ( 'L3MON4D3/LuaSnip' )
    use ( 'saadparwaiz1/cmp_luasnip' )
    use ( 'rafamadriz/friendly-snippets' )

    use ( 'williamboman/mason.nvim' )
    use ( 'williamboman/mason-lspconfig.nvim' )
    use ( 'neovim/nvim-lspconfig' )

    use ( 'hrsh7th/cmp-nvim-lua' )
    use ( 'hrsh7th/cmp-nvim-lsp' )
    use ( {'glepnir/lspsaga.nvim', branch = 'main'} )
    use ( 'jose-elias-alvarez/typescript.nvim' )
    use ( 'onsails/lspkind.nvim' )

    use ({
        'nvim-treesitter/nvim-treesitter',
        run = function ()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
    })

    use ( 'windwp/nvim-autopairs' )
    use ( 'windwp/nvim-ts-autotag' )
    use ( 'lewis6991/gitsigns.nvim' )

    use ( 'nvim-lua/plenary.nvim' )
    use ( 'mfussenegger/nvim-dap' )
    use ( 'github/copilot.vim' )

end)
