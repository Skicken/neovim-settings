return
{
	"https://github.com/rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			stages = "fade",
			timeout = 3000, -- Adjust the timeout as needed
		})
	end,


}
