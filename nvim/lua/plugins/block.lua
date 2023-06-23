return {
    "HampusHauffman/block.nvim",
  	-- event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("block").setup({
      automatic = false,
      -- percent = 0.5,
      -- colors =  {
      --     "#1e1e2e",
      --     "#1e2030",
      --  },
    })
    end,
}
