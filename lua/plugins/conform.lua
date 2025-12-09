local util = require("conform.util")

return {
  "stevearc/conform.nvim",
  opts = function()
    ---@type conform.setupOpts
    local opts = {
      default_format_opts = {
        timeout_ms = 3000,
        async = false, -- keep the defaults you already use
        quiet = false,
        lsp_format = "fallback",
      },

      ----------------------------------------------------------------------
      -- 1️⃣  Filetype → formatter mapping (unchanged except for php)
      ----------------------------------------------------------------------
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        php = { "pint" }, -- ← still points at pint
        blade = { "blade-formatter", "rustywind" },
        python = { "black" },
        javascript = { "prettierd" },
        -- rust = { "rustfmt" },
      },

      ----------------------------------------------------------------------
      -- 2️⃣  Custom formatter definitions (only pint is touched)
      ----------------------------------------------------------------------
      ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
      formatters = {
        injected = {
          options = { ignore_errors = true },
        },

        -- ────────────────────────────────────────────────────────────────
        -- Pint – run via stdin and point at the shared config file
        -- ────────────────────────────────────────────────────────────────
        pint = {
          meta = {
            url = "https://github.com/laravel/pint",
            description = "Laravel Pint is an opinionated PHP code style fixer for minimalists. Pint is built on top of PHP‑CS‑Fixer and makes it simple to ensure that your code style stays clean and consistent.",
          },

          -- Find the binary exactly as you already did (Mason or vendor)
          command = util.find_executable({
            vim.fn.stdpath("data") .. "/mason/bin/pint",
            "vendor/bin/pint",
          }, "pint"),

          -- • `--stdin` tells Pint to read the buffer from STDIN and write the
          --   formatted result to STDOUT (so Conform can replace the buffer).
          -- • `--config <path>` points Pint at the company‑wide config.
          args = {
            "$FILENAME",
            -- "--config",
            -- "vendor/wondeltd/php-coding-standards/php/tooling/pint.json", -- <-- adjust if needed
          },

          -- We want Conform to pipe the buffer through STDIN/STDOUT
          -- stdin = true,
        },

        -- (keep any other custom formatters you may add later)
      },
    }

    return opts
  end,
}
