return {
    { "projekt0n/github-nvim-theme", lazy = false, opts = { transparent = true } },
    -- neoosolarized
    {
        "svrana/neosolarized.nvim",
        dependencies = { "tjdevries/colorbuddy.nvim" },
        config = function()
            local status, n = pcall(require, "neosolarized")
            if not status then return end

            n.setup({ comment_italics = true })

            local cb = require("colorbuddy.init")
            local Color = cb.Color
            local colors = cb.colors
            local Group = cb.Group
            local groups = cb.groups
            local styles = cb.styles

            Color.new("white", "#ffffff")
            Color.new("black", "#000000")
            Group.new("Normal", colors.base1, colors.NONE, styles.NONE)
            Group.new("CursorLine", colors.none, colors.base03, styles.NONE,
                colors.base1)
            Group.new("CursorLineNr", colors.yellow, colors.black, styles.NONE,
                colors.base1)
            Group.new("Visual", colors.none, colors.base03, styles.reverse)
            Group.new("CopilotSuggestion", colors.yellow, colors.NONE,
                styles.NONE)

            local cError = groups.Error.fg
            local cInfo = groups.Information.fg
            local cWarn = groups.Warning.fg
            local cHint = groups.Hint.fg

            Group.new("DiagnosticVirtualTextError", cError,
                cError:dark():dark():dark():dark(), styles.NONE)
            Group.new("DiagnosticVirtualTextInfo", cInfo,
                cInfo:dark():dark():dark(), styles.NONE)
            Group.new("DiagnosticVirtualTextWarn", cWarn,
                cWarn:dark():dark():dark(), styles.NONE)
            Group.new("DiagnosticVirtualTextHint", cHint,
                cHint:dark():dark():dark(), styles.NONE)
            Group.new("DiagnosticUnderlineError", colors.none, colors.none,
                styles.undercurl, cError)
            Group.new("DiagnosticUnderlineWarn", colors.none, colors.none,
                styles.undercurl, cWarn)
            Group.new("DiagnosticUnderlineInfo", colors.none, colors.none,
                styles.undercurl, cInfo)
            Group.new("DiagnosticUnderlineHint", colors.none, colors.none,
                styles.undercurl, cHint)

            Group.new("HoverBorder", colors.yellow, colors.none, styles.NONE)
        end
    }, -- rosepine
    {
        "rose-pine/neovim",
        lazy = false,
        name = "rose-pine",
        opts = { disable_background = true }
    }, -- tokyonight
    { "folke/tokyonight.nvim",       lazy = false, opts = { style = "moon" } },

    -- catppuccin
    { "catppuccin/nvim",             lazy = false, name = "catppuccin" }, {
    "no-clown-fiesta/no-clown-fiesta.nvim",
    lazy = false,
    opts = { transparent = false }
}, { "Mofiqul/vscode.nvim",    lazy = false, name = "vscode" },
    { "olimorris/onedarkpro.nvim", lazy = false, name = "onedarkpro" }
}
