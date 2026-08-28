return {
  "joechrisellis/lsp-format-modifications.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local Job = require "plenary.job"

    local function cmd(spec)
      local exitcode = 0
      local stdout = {}
      local stderr = {}

      Job:new {
        command = spec.command,
        args = spec.args,
        cwd = spec.cwd,

        on_exit = function(_, return_val)
          exitcode = return_val
        end,

        on_stdout = function(_, data)
          table.insert(stdout, data)
        end,

        on_stderr = function(_, data)
          table.insert(stderr, data)
        end,
      }:sync()

      return {
        exitcode = exitcode,
        stdout = stdout,
        stderr = stderr,
      }
    end

    local function enable_default_formatter()
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(bwp_args)
          local clients = vim.lsp.get_clients({ bufnr = bwp_args.buf })
          if #clients > 0 then
            vim.lsp.buf.format({ bufnr = bwp_args.buf })
          end
        end,
      })
    end


    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then
          return
        end

        -- Falls back to default formatting if the server cannot
        -- handle range formatting
        if not client.server_capabilities.documentRangeFormattingProvider then
          vim.notify(
            "LSP does not support range formatting. Using default formatting.",
            vim.log.levels.WARN)
          enable_default_formatter()
          return
        end

        local bufnr = args.buf

        -- Checks whether we're in a git repo. If not, enable default formatter.
        -- This is the same logic that lsp-format-modifications uses.
        local bufname = vim.fn.bufname(bufnr)
        local git_cwd = vim.fn.fnamemodify(bufname, ":h")
        local result = cmd {
          command = "git",
          cwd = git_cwd,
          args = { "rev-parse", "--show-toplevel" }
        }

        if result.exitcode ~= 0 then
          vim.notify(
            "Not inside a git directory. Using default formatting.",
            vim.log.levels.WARN)
          enable_default_formatter()
          return
        end

        local group = vim.api.nvim_create_augroup(
          "LspFormatModifications",
          { clear = false }
        )

        vim.api.nvim_clear_autocmds({
          group = group,
          buffer = bufnr,
        })

        vim.api.nvim_create_autocmd("BufWritePre", {
          group = group,
          buffer = bufnr,
          callback = function()
            require("lsp-format-modifications").format_modifications(
              client,
              bufnr,
              {
                experimental_empty_line_handling = true
              }
            )
          end,
        })
      end,
    })
  end,
}
