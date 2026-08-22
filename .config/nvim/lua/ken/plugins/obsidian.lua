return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  
  -- Define your keymaps here! Lazy will automatically load them.
  keys = {
    -- Core Navigation
    { "<leader>on", ":ObsidianNew ", desc = "New Zettelkasten Note" },
    { "<leader>ot", ":ObsidianToday<CR>", desc = "Open/Create Daily Note" },
    { "<leader>of", ":ObsidianSearch<CR>", desc = "Search Obsidian Vault" },
    { "<leader>or", ":ObsidianRename ", desc = "Search Obsidian Vault" },
    
    -- Template Injections
    { "<leader>od", ":ObsidianTemplate daily-template<CR>", desc = "Insert Daily Template" },
    { "<leader>oc", ":ObsidianTemplate concept-template<CR>", desc = "Insert Concept Template" },
    { "<leader>os", ":ObsidianTemplate source-template<CR>", desc = "Insert Source Template" },
    { "<leader>op", ":ObsidianTemplate project-template<CR>", desc = "Insert Project Template" },
    { "<leader>oa", ":ObsidianTemplate area-template<CR>", desc = "Insert Area Template" },
  },

  -- Loads obsidian.nvim only for markdown files in your vault
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/vault/**.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/vault/**.md",
  },

  cmd = {
    "ObsidianNew",
    "ObsidianQuickSwitch",
    "ObsidianSearch",
    "ObsidianTemplate",
    "ObsidianToday",
  },
  
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/vault",
      },
    },

    -- 1. Force new notes into your permanent Zettelkasten folder
    notes_subdir = "research/6-notes",
    
    -- 2. Tell the plugin to STOP auto-generating frontmatter so your template works
    disable_frontmatter = true,
    
    -- 3. Configure where your daily "fleeting/scratchpad" notes go
    daily_notes = {
      folder = "research/1-inbox",
      date_format = "%Y-%m-%d",
    },
    
    -- 4. Tell it where your templates live
    templates = {
      folder = "research/5-templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    -- Customize how note IDs are generated
    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name (lowercase, hyphenated).
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If no title is given, fallback to a random 4-letter string
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      -- Return JUST the title, without the os.time() timestamp
      return suffix
    end,

    -- Custom UI highlights to prioritize cool tones
    ui = {
      enable = true,
      update_debounce = 200,
      
      hl_groups = {
        -- Crisp white for standard elements
        ObsidianTodo = { bold = true, fg = "#FFFFFF" },
        ObsidianRightArrow = { bold = true, fg = "#FFFFFF" },
        
        -- Cool blues for completions and bullets
        ObsidianDone = { bold = true, fg = "#82AAFF" },
        ObsidianBullet = { bold = true, fg = "#89DDFF" },
        ObsidianTag = { italic = true, fg = "#82AAFF" },
        
        -- Minimal pink for critical highlights and cross-references
        ObsidianImportant = { bold = true, fg = "#FF9CE6" },
        ObsidianRefText = { underline = true, fg = "#FF9CE6" },
        ObsidianExtLinkIcon = { fg = "#FF9CE6" },
        ObsidianTilde = { bold = true, fg = "#FF9CE6" },
      },
    },
    
    -- Set to true to force '.md' extension on new files
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
  },

    config = function(_, opts)
    require("obsidian").setup(opts)
    -- Enable conceal so the plugin can render your custom UI colors
    vim.opt.conceallevel = 1
  end,
}
