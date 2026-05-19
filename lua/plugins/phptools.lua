return {
  "ccaglak/phptools.nvim",
  keys = {
    { "<leader>hh", "<cmd>PhpTools Smart<cr>", desc = "Smart detect (method or class)" },
    { "<leader>hm", "<cmd>PhpTools Method<cr>", desc = "Generate method" },
    { "<leader>hc", "<cmd>PhpTools Class<cr>", desc = "Generate class" },
    { "<leader>hs", "<cmd>PhpTools Scripts<cr>", desc = "Run Composer scripts" },
    { "<leader>hn", "<cmd>PhpTools Namespace<cr>", desc = "Generate namespace" },
    { "<leader>hg", "<cmd>PhpTools GetSet<cr>", desc = "Generate getter/setter" },
    { "<leader>hp", "<cmd>PhpTools PropertyHooks<cr>", desc = "Generate property hooks" },
    { "<leader>hf", "<cmd>PhpTools Create<cr>", desc = "Create PHP entity" },
    { mode = "v", "<leader>lr", "<cmd>PhpTools Refactor<cr>", desc = "Refactor selection" },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("phptools").setup({
      ui = {
        enable = true, -- replace vim.ui.select, vim.ui.input, vim.notify with custom floating windows
        fzf = false, -- use fzf for test filtering if available
      },
      custom_toggles = {
        enable = false, -- enable <C-a>/<C-x> word/operator toggles
        -- Built-in word groups:
        --   { "public", "protected", "private" },
        --   { "self", "static" },
        --   { "true", "false" },
        --   { "require", "require_once", "include" },
        --   { "abstract", "final" },
        --   { "class", "interface", "trait", "enum" },
        --   { "string", "int", "float", "bool", "array" },
        -- Built-in operator pairs:
        --   == <-> ===, != <-> !==, > <-> >=, < <-> <=,
        --   && <-> ||, ++ <-> --, -> <-> =>
        -- Add custom word groups to extend defaults:
        -- custom_toggles = { { "yes", "no" }, { "on", "off" } },
      },
      gf = {
        enable = true, -- smart gf navigation for PHP, Blade, Twig
        max_depth = 5, -- max recursion depth for constant resolution
        project_root_markers = { ".git", "composer.json", ".env" },
        excluded_dirs = { "vendor", "node_modules", ".git" },
        custom_constants = {}, -- user-defined constants, e.g. { MY_CONST = "/path/to/dir" }
        keymaps = { -- set any to false to disable
          gf = "gf", -- context-aware goto file
          browse_components = "<leader>gC", -- list all Blade components
          browse_livewire = "<leader>gw", -- list all Livewire components
          toggle_livewire = "<leader>gW", -- switch between Livewire class and Blade view
          browse_routes = "<leader>gr", -- list Laravel routes and jump to controller
          browse_logs = "<leader>gl", -- list and open log files
          tail_logs = "<leader>gL", -- tail -f laravel.log in a terminal tab
        },
      },
      property_hooks = {
        enable = true, -- PHP 8.4 property hooks generation
      },
    })

    local map = vim.keymap.set
    local ide_helper = require("phptools.ide_helper")
    local tests = require("phptools.tests")

    -- Laravel IDE Helper commands
    map("n", "<leader>lha", ide_helper.generate_all, { desc = "Generate all IDE helpers" })
    map("n", "<leader>lhm", ide_helper.generate_models, { desc = "Generate model helpers" })
    map("n", "<leader>lhf", ide_helper.generate_facades, { desc = "Generate facade helpers" })
    map("n", "<leader>lht", ide_helper.generate_meta, { desc = "Generate meta helper" })
    map("n", "<leader>lhi", ide_helper.install, { desc = "Install IDE Helper package" })

    -- Test runner commands
    map("n", "<Leader>ta", tests.test.all, { desc = "Run all tests" })
    map("n", "<Leader>tf", tests.test.file, { desc = "Run file tests" })
    map("n", "<Leader>tl", tests.test.line, { desc = "Run test at cursor" })
    map("n", "<Leader>ts", tests.test.filter, { desc = "Search and run test" })
    map("n", "<Leader>tp", tests.test.parallel, { desc = "Run tests in parallel" })
    map("n", "<Leader>tr", tests.test.rerun, { desc = "Rerun last test" })
    map("n", "<Leader>ti", tests.test.selected, { desc = "Run selected test file" })
  end,
}
