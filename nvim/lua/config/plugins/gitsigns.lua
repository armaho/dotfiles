return {
	"lewis6991/gitsigns.nvim",
	opts = {
		attach_to_untracked = true,
		watch_gitdir = {
			follow_files = true,
		},
	},
	keys = {
		{
			"<leader>gp",
			require("gitsigns").preview_hunk,
			mode = "n",
			desc = "git diff priview",
		},
		{
			"<leader>gb",
			require("gitsigns").blame,
			mode = "n",
			desc = "git blame",
		},
		{
			"<leader>gd",
			require("gitsigns").diff,
			mode = "n",
			desc = "see the diff for this file",
		},
	},
}
