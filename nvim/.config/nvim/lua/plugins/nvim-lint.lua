return {
  "mfussenegger/nvim-lint",
  opts = {
    event = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      python = { "ruff" },
    },
  },
  config = function(_, opts)
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
