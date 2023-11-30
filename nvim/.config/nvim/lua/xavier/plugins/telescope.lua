-- Fuzzy Finder (files, lsp, etc)
return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    tag = "0.1.4",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "wesleimp/telescope-windowizer.nvim",
        "nvim-telescope/telescope-frecency.nvim",
        "ThePrimeagen/git-worktree.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "keyvchan/telescope-find-pickers.nvim",
    },
    config = function()
        local builtin = require("telescope.builtin")
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local fb_actions = require("telescope").extensions.file_browser.actions

        vim.keymap.set("n", ";;", builtin.pickers, { desc = "Telescope cached picker" })
        vim.keymap.set("n", "\\\\", builtin.buffers, { desc = "Buffers" })
        -- Current buffer fuzzy find
        -- Current Buffer Fuzzy Find
        vim.keymap.set("n", "<leader>pf", builtin.current_buffer_fuzzy_find, { desc = "Current Buffer Fuzzy Find" })
        -- Live Grep
        vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Live Grep" })
        -- Commands
        vim.keymap.set("n", "<leader>po", builtin.oldfiles, { desc = "Commands" })
        -- Find Files
        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find Files" })
        -- Git Files
        vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git Files" })
        -- Help Tags
        vim.keymap.set("n", "<leader>ph", builtin.help_tags, { desc = "Help Tags" })
        -- Marks
        vim.keymap.set("n", "<leader>pm", builtin.marks, { desc = "Marks" })
        -- Colorscheme
        vim.keymap.set("n", "<leader>pc", builtin.colorscheme, { desc = "Colorscheme" })
        -- Tags
        vim.keymap.set("n", "<leader>pt", builtin.tags, { desc = "Tags" })
        -- Registers
        vim.keymap.set("n", "<leader>pr", builtin.registers, { desc = "Registers" })
        -- Jumplists
        vim.keymap.set("n", "<leader>pl", builtin.jumplist, { desc = "Jumplist" })
        vim.keymap.set("n", "<leader><leader>", "<Cmd>Telescope frecency workspace=CWD<CR>", { desc = "Frecency" })
        -- File Browser
        vim.keymap.set("n", "<leader>pf", function()
            local function telescope_buffer_dir()
                return vim.fn.expand("%:p:h")
            end
            require("telescope").extensions.file_browser.file_browser({
                path = "%:p:h",
                cwd = telescope_buffer_dir(),
                respect_gitignore = false,
                hidden = true,
                grouped = true,
                previewer = false,
                initial_mode = "normal",
                layout_config = {
                    height = 40,
                },
            })
        end, { desc = "File Browser" })

        -- Git Worktree
        vim.keymap.set("n", "<leader>pw", "<Cmd>Telescope git_worktree list<CR>", { desc = "Git Worktree" })
        vim.keymap.set("n", "<leader>pn", "<Cmd>Telescope git_worktree create_new<CR>", { desc = "Git Worktree" })

        -- Telescope Settings
        telescope.setup({
            defaults = {
                path_display = { "shorten" },
                sorting_strategy = "ascending",
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--ignore-file",
                    ".gitignore",
                },
            },
            file_ignore_patterns = {
                "node_modules",
                "vendor",
                "dist",
                "build",
                "target",
                "yarn.lock",
                "package-lock.json",
            },
            extensions = {
                frecency = {
                    show_scores = false,
                    show_unindexed = true,
                    ignore_patterns = { "*.git/*", "*/tmp/*", "node_modules", "lazy-lock.json" },
                    disable_devicons = false,
                    workspaces = {
                        ["dev"] = "/Users/xc/Developer",
                    },
                },
                file_browser = {
                    theme = "dropdown",
                    hidden = true,
                    hijack_netrw = true,
                    mappings = {
                        i = {
                            ["<C-w>"] = function()
                                vim.cmd("normal vbd")
                            end,
                        },
                        n = {
                            N = fb_actions.create,
                            h = fb_actions.goto_parent_dir,
                            M = fb_actions.move,
                            ["/"] = function()
                                vim.cmd("startinsert")
                            end,
                        },
                    },
                },
                ["ui-select"] = {
                    (require("telescope.themes")).get_dropdown({}),
                },
            },
            pickers = {
                buffers = {
                    show_all_buffers = true,
                    sort_lastused = true,
                    mappings = {
                        n = {
                            ["<c-d>"] = actions.delete_buffer,
                            -- Re-use open buffer instead of opening a new window
                            -- Thanks: https://github.com/jensenojs/dotfiles/blob/08cef709e68b25b99173e3445291ff15b666226d/.config/nvim/lua/plugins/ide/telescope.lua#L139
                            -- ["<CR>"] = actions.select_tab_drop,
                        },
                    },
                },
            },
        })
        -- Extensions
        telescope.load_extension("windowizer")
        telescope.load_extension("frecency")
        telescope.load_extension("git_worktree")
        telescope.load_extension("find_pickers")
        telescope.load_extension("file_browser")
        telescope.load_extension("ui-select")
    end,
}
