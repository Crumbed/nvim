local status, treesitter = pcall(require,'nvim-treesitter.configs')
if not status then
    return
end


treesitter.setup {
    -- A list of parser names, or "all" (the four listed parsers should always be installed)
    ensure_installed = { "help", "javascript", "typescript", "java", "python", "lua", "vim", "rust" },

    sync_install = false,
    auto_install = true,

    highlight = { enable = true },
    indent = { enable = true },
    autotag = { enable = true },

}
