-- Leader Keys ---
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt
local g = vim.g

-- --- General ---
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.hidden = true
opt.mouse = "a"
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
opt.history = 1000
opt.confirm = true
g.have_nerd_font = true
g.snacks_animate = true

-- --- File Handling ---
opt.autoread = true
opt.undofile = true
opt.undodir = vim.fn.stdpath("config") .. "/undo"
opt.undolevels = 10000
opt.swapfile = false

-- --- UI Enhancements ---
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorcolumn = false
opt.laststatus = 3
opt.showcmd = true
opt.showmode = false
opt.signcolumn = "yes"
opt.scrolloff = 10
opt.sidescrolloff = 5
opt.ttyfast = true
opt.termguicolors = true
opt.linebreak = true
opt.breakindent = true
opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
opt.wrap = false
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.cmdheight = 0
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

-- --- Searching ---
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.showmatch = true
opt.inccommand = "nosplit"

-- --- Indentation ---
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true
opt.shiftround = true

-- --- Behavior ---
opt.updatetime = 300
opt.timeoutlen = vim.g.vscode and 1000 or 9999
opt.shortmess:append({ c = true, W = true, I = true, C = true })
opt.formatoptions = "jcroqlnt"
opt.completeopt = "menuone,noinsert,noselect"
opt.splitbelow = true
opt.splitright = true
opt.backspace = "indent,eol,start"
opt.jumpoptions = "view"
opt.virtualedit = "block"
opt.pumblend = 10
opt.pumheight = 10
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- --- Syntax & Filetype ---
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")
g.markdown_recommended_style = 0

-- --- Folding ---
opt.foldmethod = "indent"
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldcolumn = "1"
opt.foldnestmax = 3

-- --- Grep ---
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
