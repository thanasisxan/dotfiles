return {
  { "rcarriga/nvim-dap-ui", enabled = false },

  {
    "igorlfs/nvim-dap-view",
    opts = {},
    cmd = { "DapViewOpen", "DapViewToggle" },
    keys = {
      { "<leader>du", "<cmd>DapViewToggle<cr>", desc = "Toggle Clean Debug View" },
      { "<leader>dw", "<cmd>DapViewWatch<cr>", desc = "Add Watch" },
    },
    config = function()
      local dap = require("dap")
      local dapview = require("dap-view")
      dapview.setup()

      -- Open sidebar automatically when you hit a breakpoint
      dap.listeners.after.event_initialized["dap-view"] = function()
        dapview.open()
      end
    end
  }
}
