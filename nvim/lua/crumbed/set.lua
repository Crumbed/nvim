local o = vim.opt


o.nu = true
o.relativenumber = true

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

o.smartindent = true

o.wrap = false

o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true

o.hlsearch = false
o.incsearch = true

o.termguicolors = true

o.scrolloff = 16
o.signcolumn = "yes"
o.isfname:append("@-@")

o.updatetime = 50


o.foldmethod = "indent"
o.smartcase = true
o.ignorecase = true
o.mouse = "a"
o.hlsearch = true

o.cursorline = true
o.termguicolors = true
o.background = "dark"
o.signcolumn = "yes"

o.clipboard:append("unnamedplus")

o.iskeyword:append("-")

