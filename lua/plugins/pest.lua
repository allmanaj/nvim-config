return {
  {
    -- Add neotest-pest plugin for running PHP tests.
    -- A package is also available for PHPUnit if needed.
    "nvim-neotest/neotest",
    dependencies = {
      {
        "jradtilbrook/neotest-pest",
        branch = "ts-fix",
      },
    },
    opts = {
      adapters = {
        require("neotest-pest")({}),
      },
    },
  },
}
