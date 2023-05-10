return {
	{
		"huggingface/hfcc.nvim",
		opts = {
			api_token = require("xavier.config.keys").HF_KEY,
			model = "bigcode/starcoder", -- can be a model ID or an http endpoint
		},
	},
}
