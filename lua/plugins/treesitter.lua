-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  -- Core Treesitter plugin
  "nvim-treesitter/nvim-treesitter",

  -- Build step that synchronously updates all parsers
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,

  -- Extra Treesitter extensions you depend on
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      opts = {
        custom_calculation = function(_, language_tree)
          -- Blade comment style – only when the buffer is Blade and the
          -- language tree is *not* JavaScript nor PHP.
          if vim.bo.filetype == "blade" and language_tree._lang ~= "javascript" and language_tree._lang ~= "php" then
            return "{{-- %s --}}"
          end
        end,
      },
    },
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
}
