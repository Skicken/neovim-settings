return
{
	"https://github.com/rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			stages = "fade_in_slide_out",
			timeout = 3000, -- Adjust the timeout as needed
		})
	end,


}
