return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
      },
      -- formatters = {
      --   prettier = {
      --     command = function()
      --       local local_prettier = vim.fn.getcwd() .. "/node_modules/.bin/prettier"
      --       if vim.fn.executable(local_prettier) == 1 then
      --         return local_prettier
      --       end
      --       return "prettier"
      --     end,
      --   },
      -- },
    },
  },
}
