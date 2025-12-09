return {

  {
    "nvim-neotest/neotest",
    dependencies = {
      "V13Axel/neotest-pest",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-pest"),
        },
      })
    end,
  },
}
