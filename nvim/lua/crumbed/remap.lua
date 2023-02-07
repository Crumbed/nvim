vim.g.mapleader=' '
local km = vim.keymap

km.set( 'n', '<leader>pv', vim.cmd.Ex )
km.set( 'i', 'jk', '<ESC>' ) -- quick normal mode
km.set( 'n', 'x', '"_x' ) -- dont copy char when 'x'
km.set( 'n', '<leader>+', '<C-a>' ) -- easy increment
km.set( 'n', '<leader>-', '<C-x>' ) -- easy decrement
km.set( 'n', '<TAB>k', '<C-u>' ) -- half page up
km.set( 'n', '<TAB>j', '<C-d>' ) -- half page down

        -- WINDOW NAV -- 
km.set( 'n', '<leader>j', '<C-w>j' )
km.set( 'n', '<leader>k', '<C-w>k' )
km.set( 'n', '<leader>h', '<C-w>h' )
km.set( 'n', '<leader>l', '<C-w>l' )




