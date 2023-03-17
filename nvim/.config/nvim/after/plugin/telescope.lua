---@diagnostic disable: undefined-global
local telescope = require("telescope")
local actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions

local function telescope_buffer_dir()
    return vim.fn.expand('%:p:h')
end

telescope.setup {
    defaults = {
        mappings = {
            n = {
                ["q"] = actions.close
            },
        },
    },
    extensions = {
        file_browser = {
            theme = "dropdown",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
                -- your custom insert mode mappings
                ["i"] = {
                    ["<C-w>"] = function() vim.cmd('normal vbd') end,
                },
                ["n"] = {
                    -- your custom normal mode mappings
                    ["N"] = fb_actions.create,
                    ["h"] = fb_actions.goto_parent_dir,
                    ["/"] = function()
                        vim.cmd('startinsert')
                    end
                },
            },
        },
    },
}

local wk = require("which-key")

wk.register({
    p = {
        name = "project",
        f = { "<cmd>Telescope find_files<cr>", "Find File" },
        s = { function() require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") }) end,
            "Grep Search" },
        v = { function()
            telescope.extensions.file_browser.file_browser({
                path = "%:p:h",
                cwd = telescope_buffer_dir(),
                respect_gitignore = false,
                hidden = true,
                grouped = true,
                previewer = false,
                initial_mode = "normal",
                layout_config = { height = 40 }
            })
        end,
            "Explorer" },
        o = { "<cmd>Telescope oldfiles initial_mode=normal<cr>", "Old Files" },
    },
    ["<leader>"] = { function()
        telescope.extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = telescope_buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = { height = 40 }
        })
    end,
        "Explorer" },
}, { prefix = "<leader>" })

wk.register({
    ["<C-p>"] = { "<cmd>Telescope git_files<cr>", "Git File" },
})
