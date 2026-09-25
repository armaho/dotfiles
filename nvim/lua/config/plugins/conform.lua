return {
	"stevearc/conform.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
	},
	config = function()
		local conform = require("conform")

		local function find_uncrustify_config()
			local cfg_dir = vim.fs.find(
				{ "uncrustify.cfg", ".uncrustify.cfg" },
				{ path = vim.env.PWD, upward = true }
			)

			if #cfg_dir ~= 0 then
				return cfg_dir[1]
			end

			if vim.env.UNCRUSTIFY_CONFIG then
				return vim.env.UNCRUSTIFY_CONFIG
			end

			return nil
		end

		local function in_git_dir()
			local git_dir = vim.fs.find(".git", { path = vim.env.PWD, upward = true })
			return #git_dir ~= 0
		end

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				c = { "uncrustify" },
				cpp = { "uncrustify" },
			},
			formatters = {
				uncrustify = {
					command = "uncrustify",
					args = function()
						return {
							"-q",
							"-c",
							find_uncrustify_config(),
							"--replace",
							"--no-backup",
							"$FILENAME",
						}
					end,
					condition = function()
						return find_uncrustify_config() ~= nil
					end,
					stdin = false,
				},
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				if not in_git_dir() then
					conform.format({
						bufnr = args.buf,
					})
					return
				end

				local hunks = require("gitsigns").get_hunks(args.buf)
				if hunks == nil then
					return
				end

				-- start from the last hunk so we don't affect the next hunks
				for i = #hunks, 1, -1 do
					local hunk = hunks[i]
					if hunk.type ~= "delete" then
						local start = hunk.added.start
						local last = start + hunk.added.count

						local range = {
							start = { start, 0 },
							["end"] = { last, 0 },
						}

						conform.format({
							bufnr = args.buf,
							range = range,
						})
					end
				end
			end,
		})
	end,
}
