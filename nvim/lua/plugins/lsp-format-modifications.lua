return {
  "joechrisellis/lsp-format-modifications.nvim",
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf

        if not client.server_capabilities.documentRangeFormattingProvider then
          vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
              local clients = vim.lsp.get_clients({ bufnr = args.buf })
              if #clients > 0 then
                vim.lsp.buf.format({ bufnr = args.buf })
              end
            end,
          })
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
              bufnr
            )
          end,
        })
      end,
    })
  end,
}
