return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },
  opts = {
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown(),
      },
    },
  },
  keys = {
    { "<leader><leader>", require("telescope.builtin").buffers, desc = "[f]ind existing [b]uffers" },
    {
      "<leader>/",
      function()
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end,
      desc = "[/] fuzzily search in current buffer",
    },
    {
      "<leader>fb",
      function()
        require("telescope.builtin").find_files({
          cwd = vim.fn.expand("%:p:h"),
          hidden = true,
          prompt_title = "files in " .. vim.fn.expand("%:h"),
        })
      end,
      desc = "[f]ind files in active [b]uffer location",
    },
    { "<leader>ff", require("telescope.builtin").find_files, desc = "[f]ind [f]iles in cwd" },
    { "<leader>fh", require("telescope.builtin").help_tags, desc = "[f]ind [f]elp" },
    { "<leader>rf", require("telescope.builtin").oldfiles, desc = "find [r]ecent [f]iles" },
    {
      "<leader>ec",
      function()
        require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "open [e]ditor [c]onfig",
    },
    {
      "<leader>ep",
      function()
        require("telescope.builtin").find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
      end,
      desc = "open [e]ditor [p]ackages",
    },
    {
      "<leader>tb",
      function()
        require("telescope.builtin").builtin()
      end,
      desc = "view [t]elescope [b]uiltins",
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
  end,
}
