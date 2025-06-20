return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {},
		keys = {
			{ "<leader>zc", ":CopilotChat<CR>", mode = "n", desc = "Copilot Chat" },
			{ "<leader>ze", ":CopilotChatExplain<CR>", mode = "v", desc = "Explain Code" },
			{ "<Leader>zr", ":CopilotChatReview<CR>", mode = "v", desc = "Review Code" },
			{ "<Leader>zf", ":CopilotChatFix<CR>", mode = "v", desc = "Fix Code Issues" },
			{ "<leader>zo", ":CopilotChatOptimize<CR>", mode = "v", desc = "Optimize Code" },
			{ "<Leader>zd", ":CopilotChatDocs<CR>", mode = "v", desc = "Generate Docs" },
			{ "<Leader>zt", ":CopilotChatTests<CR>", mode = "v", desc = "Generate Tests" },
			{ "<Leader>zm", ":CopilotChatCommit<CR>", mode = "n", desc = "Generate Commit Message" },
			{ "<Leader>zs", ":CopilotChatCommit<CR>", mode = "v", desc = "Generate Commit for Selection" },
		},
	},
}
