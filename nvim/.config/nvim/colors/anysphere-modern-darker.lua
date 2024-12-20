-- Anysphere Modern Darker Theme for Neovim
-- A modern, darker theme with carefully selected colors

local colors = {
    bg = "#1a1b1c",
    bg_dark = "#141516",
    bg_highlight = "#242526",
    fg = "#c4c6c9",
    fg_dark = "#989a9d",
    fg_gutter = "#3b3d40",
    border = "#303234",

    -- Primary colors
    primary = "#61afef",
    secondary = "#c678dd",
    accent = "#98c379",
    
    -- Syntax colors
    keyword = "#c678dd",
    string = "#98c379",
    variable = "#e5c07b",
    constant = "#d19a66",
    function_name = "#61afef",
    type = "#56b6c2",
    comment = "#5c6370",
    
    -- UI colors
    error = "#e06c75",
    warning = "#e5c07b",
    info = "#61afef",
    hint = "#56b6c2",
    
    -- Git colors
    git_add = "#98c379",
    git_change = "#e5c07b",
    git_delete = "#e06c75"
}

local function highlight(group, color)
    local style = color.style and 'gui=' .. color.style or 'gui=NONE'
    local fg = color.fg and 'guifg=' .. color.fg or 'guifg=NONE'
    local bg = color.bg and 'guibg=' .. color.bg or 'guibg=NONE'
    local sp = color.sp and 'guisp=' .. color.sp or ''
    
    vim.cmd('highlight ' .. group .. ' ' .. style .. ' ' .. fg .. ' ' .. bg .. ' ' .. sp)
end

local function load_syntax()
    local syntax = {
        -- Editor
        Normal = { fg = colors.fg, bg = colors.bg },
        NormalFloat = { fg = colors.fg, bg = colors.bg_dark },
        ColorColumn = { bg = colors.bg_highlight },
        Cursor = { fg = colors.bg, bg = colors.fg },
        CursorLine = { bg = colors.bg_highlight },
        CursorLineNr = { fg = colors.fg },
        LineNr = { fg = colors.fg_gutter },
        SignColumn = { bg = colors.bg },
        VertSplit = { fg = colors.border },
        
        -- Syntax highlighting
        Comment = { fg = colors.comment, style = "italic" },
        Constant = { fg = colors.constant },
        String = { fg = colors.string },
        Character = { fg = colors.string },
        Number = { fg = colors.constant },
        Boolean = { fg = colors.constant },
        Float = { fg = colors.constant },
        Identifier = { fg = colors.variable },
        Function = { fg = colors.function_name },
        Statement = { fg = colors.keyword },
        Keyword = { fg = colors.keyword },
        Type = { fg = colors.type },
        
        -- Messages
        Error = { fg = colors.error },
        ErrorMsg = { fg = colors.error },
        WarningMsg = { fg = colors.warning },
        InfoMsg = { fg = colors.info },
        HintMsg = { fg = colors.hint },
        
        -- Git signs
        GitSignsAdd = { fg = colors.git_add },
        GitSignsChange = { fg = colors.git_change },
        GitSignsDelete = { fg = colors.git_delete },
        
        -- Search
        Search = { fg = colors.bg, bg = colors.primary },
        IncSearch = { fg = colors.bg, bg = colors.secondary },
        
        -- Pmenu
        Pmenu = { fg = colors.fg, bg = colors.bg_dark },
        PmenuSel = { fg = colors.bg, bg = colors.primary },
        PmenuSbar = { bg = colors.bg_highlight },
        PmenuThumb = { bg = colors.fg_gutter },
        
        -- LSP
        DiagnosticError = { fg = colors.error },
        DiagnosticWarn = { fg = colors.warning },
        DiagnosticInfo = { fg = colors.info },
        DiagnosticHint = { fg = colors.hint },
    }
    
    return syntax
end

local function setup()
    vim.cmd('hi clear')
    if vim.fn.exists('syntax_on') then
        vim.cmd('syntax reset')
    end
    
    vim.o.termguicolors = true
    vim.g.colors_name = 'anysphere-modern-darker'
    
    local syntax = load_syntax()
    for group, colors in pairs(syntax) do
        highlight(group, colors)
    end
end

setup()

-- Return the color palette for use in other plugins
return colors