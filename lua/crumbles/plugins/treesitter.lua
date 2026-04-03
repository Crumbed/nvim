




function Init()
    local ts = require("nvim-treesitter")
    ts.install({
        "javascript",
        "typescript",
        "c",
        "lua",
        "rust",
        "go",
        "json",
        "zig",
    })
    --local installed = ts.get_installed()

    vim.api.nvim_create_autocmd("FileType", {
        --pattern = "*",
        callback = function(args)
            local bufnr = args.buf
            local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
            if not ok or not parser then
                return
            end
            pcall(vim.treesitter.start)
        end,
    })

    -- require("nvim-treesitter.config")({
    --     ensure_installed = {
    --     },
    --     auto_install = true,
    --     sync_install = false,
    --     --indent = { enable = true },
    --     highlight = {
    --         enable = true,
    --         additional_vim_regex_highlighting = { "markdown" },
    --     }
    -- })

    --local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    --treesitter_parser_config.templ = {
    --    install_info = {
    --        url = "https://github.com/vrischmann/tree-sitter-templ.git",
    --        files = { "src/parser.c", "src/scanner.c" },
    --        branch = "master",
    --    },
    --}

    --vim.treesitter.language.register("templ", "templ")
end





return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        lazy = false,
        config = Init
    },
}
