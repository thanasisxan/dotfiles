return {
  "mfussenegger/nvim-dap",
  keys = {
    {
      "<leader>dqr",
      function()
        require("dap").repl.execute("from django.db import reset_queries; reset_queries()")
      end,
      desc = "Reset queries",
    },
    {
      "<leader>dqp",
      function()
        require("dap").repl.execute("from django.db import connection; print(f'\\n{len(connection.queries)} queries:'); [print(f\"{i+1}. {q['sql'][:100]}\") for i,q in enumerate(connection.queries)]")
      end,
      desc = "Print queries",
    },
  },
}
