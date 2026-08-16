local function load_cinnamoroll()
    -- 1. Strip all existing themes and highlights
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end
    
    -- Name your masterpiece
    vim.g.colors_name = "cinnamoroll"

    -- 2. The Expanded Luminous Palette
    local c = {
        none          = "NONE",
        white         = "#FFFFFF",
        fg            = "#F0F8FF", -- Bright Alice Blue for standard text
        
        -- Blues
        blue_light    = "#D0E8F9", -- Soft pastel baby blue
        blue_bright   = "#6AC2F0", -- Saturated sky blue for high-visibility elements
        
        -- Pinks
        pink_light    = "#FAD1EA", -- Soft sakura pastel
        pink_bright   = "#F593C4", -- Saturated candy pink for accents
        
        -- Structural Colors
        muted         = "#A9BDE0", -- Bright pastel periwinkle (No more dark grey!)
        visual_bg     = "#BCE4F9", -- Bright baby blue text selection
        visual_fg     = "#1A1B26", -- Dark text inside the selection for perfect contrast
    }

    -- 3. Apply the Colors
    local highlights = {
        -- UI Elements
        Normal       = { bg = c.none, fg = c.fg },
        NormalFloat  = { bg = c.none, fg = c.fg },
        LineNr       = { fg = c.muted },
        CursorLineNr = { fg = c.pink_bright, bold = true },
        Visual       = { bg = c.visual_bg, fg = c.visual_fg }, -- Bright background, dark text
        Cursor       = { bg = c.pink_bright, fg = c.white },
        
        -- Fallback Syntax
        Comment      = { fg = c.muted, italic = true },
        String       = { fg = c.blue_light },
        Number       = { fg = c.pink_bright },
        Boolean      = { fg = c.pink_bright },
        Keyword      = { fg = c.pink_light },
        Operator     = { fg = c.muted },
        Function     = { fg = c.blue_bright, bold = true },
        Identifier   = { fg = c.fg },
        
        -- Treesitter Precision
        ["@variable"]              = { fg = c.fg },
        ["@variable.builtin"]      = { fg = c.pink_bright },
        ["@variable.parameter"]    = { fg = c.blue_light },
        ["@variable.member"]       = { fg = c.blue_light },
        
        ["@function"]              = { fg = c.blue_bright, bold = true },
        ["@function.builtin"]      = { fg = c.blue_bright, bold = true },
        ["@function.call"]         = { fg = c.blue_bright, bold = true },
        
        ["@keyword"]               = { fg = c.pink_light, italic = true },
        ["@keyword.function"]      = { fg = c.pink_light },
        ["@keyword.return"]        = { fg = c.pink_light },
        
        ["@string"]                = { fg = c.blue_light },
        ["@number"]                = { fg = c.pink_bright },
        ["@boolean"]               = { fg = c.pink_bright },
        
        ["@type"]                  = { fg = c.pink_light },
        ["@type.builtin"]          = { fg = c.pink_bright },
        
        ["@operator"]              = { fg = c.muted },
        ["@punctuation.bracket"]   = { fg = c.muted },
        ["@punctuation.delimiter"] = { fg = c.muted },
        
        ["@module"]                = { fg = c.white },
        ["@property"]              = { fg = c.blue_light },
    }

    -- 4. Loop through and force the editor to use them
    for group, hl in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, hl)
    end
end

load_cinnamoroll()

return {}
