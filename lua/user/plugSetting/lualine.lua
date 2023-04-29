local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local custom_moonfly = require"lualine.themes.moonfly"
custom_moonfly.normal.b.bg = "#353e5b"

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = true,
	update_in_insert = true,
	always_visible = true,
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width
}

local filetype = {
	"filetype",
    colored = true,
	icons_enabled = true,
	icon = { align = "left" },
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
	padding = 1,
}

-- cool function for progress
-- local progressBar = function()
-- 	local current_line = vim.fn.line(".")
-- 	local total_lines = vim.fn.line("$")
-- 	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
-- 	local line_ratio = current_line / total_lines
-- 	local index = math.ceil(line_ratio * #chars)
-- 	return chars[index]
-- end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = custom_moonfly,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
		disabled_filetypes = { "dashboard", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { diagnostics },
		lualine_c = { "lsp_progress" },
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { branch, diff, "encoding", filetype },
		lualine_y = { location },
		lualine_z = { "progress" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
