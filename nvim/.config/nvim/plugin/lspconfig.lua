local present, ufo = pcall(require, "ufo");
local setupWithFallback = function()
	if not present then
		vim.notify("ufo not installed");
		vim.wo.foldcolumn = "0";
		vim.wo.foldmethod = "expr";
		vim.wo.foldexpr = "nvim_treesitter#foldexpr()";
		return;
	end;
	local ftMap = {
		vim = "indent",
		git = ""
	};
	local function customizeSelector(bufnr)
		local function handleFallbackException(err, providerName)
			if type(err) == "string" and err:match("UfoFallbackException") then
				return ufo.getFolds(bufnr, providerName);
			else
				return (require("promise")).reject(err);
			end;
		end;
		return ((ufo.getFolds(bufnr, "lsp")):catch(function(err)
			return handleFallbackException(err, "treesitter");
		end)):catch(function(err)
			return handleFallbackException(err, "indent");
		end);
	end;
	ufo.setup({
		provider_selector = function(_, filetype, _)
			return ftMap[filetype] or customizeSelector;
		end
	});
	vim.keymap.set("n", "zR", ufo.openAllFolds);
	vim.keymap.set("n", "zM", ufo.closeAllFolds);
	vim.o.foldcolumn = "0";
	vim.o.foldlevel = 99;
	vim.o.foldlevelstart = 99;
	vim.o.foldenable = true;
	vim.o.fillchars = "eob: ,fold: ,foldopen:q88,foldsep: ,foldclose:q60";
end;
local status, nvim_lsp = pcall(require, "lspconfig");
if not status then
	return;
end;
local presentLspStatus, lsp_status = pcall(require, "lsp-status");
local presentCmpNvimLsp, cmp_lsp = pcall(require, "cmp_nvim_lsp");
local presentLspSignature, lsp_signature = pcall(require, "lsp_signature");
local protocol = require("vim.lsp.protocol");
local augroup_format = vim.api.nvim_create_augroup("Format", {
	clear = true
});
local enable_format_on_save = function(_, bufnr)
	vim.api.nvim_clear_autocmds({
		group = augroup_format,
		buffer = bufnr
	});
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = augroup_format,
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format({
				bufnr = bufnr
			});
		end
	});
end;
local on_attach = function(client, bufnr)
	if presentLspSignature then
		lsp_signature.on_attach({
			floating_window = false,
			timer_interval = 500
		});
	end;
	if presentLspStatus then
		lsp_status.on_attach(client);
	end;
	if client.name == "tsserver" then
		client.server_capabilities.document_formatting = false;
		client.server_capabilities.documentFormattingProvider = false;
	end;
	opts = {
		noremap = true,
		silent = true
	};
	vim.keymap.set("n", "<leader>nls", "<cmd>NullLsInfo<cr>", opts);
	vim.keymap.set("n", ";d", "<cmd>Telescope diagnostics<cr>", opts);
end;
protocol.CompletionItemKind = {
	"L98",
	"y80",
	"y80",
	"y80",
	"P91",
	"P91",
	"h72",
	"ﰮ",
	"}02",
	"M16",
	"q81",
	"|47",
	"h42",
	"z98",
	"\13068",
	"B99",
	"i87",
	"w20",
	"i17",
	"i89",
	"C00",
	"h42",
	"h71",
	"ﬦ",
	"L94"
};
local capabilities = (require("cmp_nvim_lsp")).default_capabilities();
if presentCmpNvimLsp then
	capabilities = cmp_lsp.default_capabilities();
else
	capabilities = vim.lsp.protocol.make_client_capabilities();
end;
if presentLspStatus then
	lsp_status.register_progress();
	capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities);
end;
if present then
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true
	};
end;
nvim_lsp.jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		allow_incremental_sync = true
	},
	settings = {
		json = {
			schemas = (require("schemastore")).json.schemas({
				select = {
					"package.json",
					".eslintrc",
					"GitHub Action",
					"prettierrc.json"
				}
			})
		}
	}
});
nvim_lsp.eslint.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		allow_incremental_sync = true
	},
	settings = {
		format = {
			enable = true
		}
	}
});
nvim_lsp.flow.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		allow_incremental_sync = true
	}
});
(require("typescript")).setup({
	disable_commands = false,
	debug = false,
	go_to_source_definition = {
		fallback = true
	},
	server = {
		on_attach = function(_, bufnr)
			vim.keymap.set("n", "<leader>cr", "<cmd>TypescriptRemoveUnused<cr>", {
				buffer = bufnr
			});
			vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<cr>", {
				buffer = bufnr
			});
			vim.keymap.set("n", "<leader>ci", "<cmd>TypescriptAddMissingImports<cr>", {
				buffer = bufnr
			});
			vim.keymap.set("n", "<leader>cf", "<cmd>TypescriptFixAll<cr>", {
				buffer = bufnr
			});
		end,
		filetypes = {
			"typescript",
			"typescriptreact",
			"typescript.tsx"
		},
		cmd = {
			"typescript-language-server",
			"--stdio"
		},
		capabilities = capabilities,
		flags = {
			allow_incremental_sync = true
		}
	}
});
nvim_lsp.sourcekit.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		allow_incremental_sync = true
	}
});
nvim_lsp.efm.setup({
	init_options = {
		documentFormatting = true
	},
	settings = {
		rootMarkers = {
			".git/"
		},
		languages = {
			lua = {
				{
					formatCommand = "lua-format -i",
					formatStdin = true
				}
			}
		}
	},
	flags = {
		allow_incremental_sync = true
	}
});
nvim_lsp.lua_ls.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr);
		enable_format_on_save(client, bufnr);
	end,
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					"vim"
				}
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false
			}
		}
	},
	flags = {
		allow_incremental_sync = true
	}
});
nvim_lsp.tailwindcss.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		allow_incremental_sync = true
	}
});
pyright = "pyright-langserver";
nvim_lsp.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		allow_incremental_sync = true
	}
});
nvim_lsp.cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		allow_incremental_sync = true
	}
});
nvim_lsp.astro.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		allow_incremental_sync = true
	}
});
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = false,
	virtual_text = {
		spacing = 4,
		prefix = "●"
	},
	severity_sort = true
});
local signs = {
	Error = "v65 ",
	Warn = "s61 ",
	Hint = "{41 ",
	Info = "q37 "
};
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type;
	vim.fn.sign_define(hl, {
		text = icon,
		texthl = hl,
		numhl = ""
	});
end;
setupWithFallback();
vim.diagnostic.config({
	virtual_text = {
		prefix = "●"
	},
	update_in_insert = true,
	float = {
		source = "always"
	}
});
