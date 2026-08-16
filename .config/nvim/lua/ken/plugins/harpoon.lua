return {
    "theprimeagen/harpoon",
    
    keys = {
        -- Tap Space, Release, Tap A = Add file
        { "<leader>m", function() require("harpoon.mark").add_file() end, desc = "Harpoon Add" },
        { "<C-s>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon Menu" },
        
        -- Tap Space, Release, Tap A/R/S/T = Instantly jump
        { "<leader>a", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon File 1" },
        { "<leader>r", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon File 2" },
        { "<leader>s", function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon File 3" },
        { "<leader>t", function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon File 4" },
    },
}
