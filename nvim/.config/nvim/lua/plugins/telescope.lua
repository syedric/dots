return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    cmd = 'Telescope',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
        { 'nvim-telescope/telescope-ui-select.nvim' },
        { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    opts = {
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
            ['ui-select'] = {
                require('telescope.themes').get_dropdown()
            },
        },
    },
    keys = {
        { '<leader><leader>', require('telescope.builtin').buffers, desc = '[F]ind existing [B]uffers' },
        { '<leader>/',
            function()
                require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown(
                    {
                        winblend = 10,
                        previewer = false,
                    }
                ))
            end,
            desc = '[/] Fuzzily search in current buffer'
        },
        { '<leader>ff', require('telescope.builtin').find_files, desc = '[F]ind [F]iles in cwd' },
        { '<leader>fh', require('telescope.builtin').help_tags, desc = '[F]ind [F]elp' },
        { '<leader>fr', require('telescope.builtin').oldfiles, desc = '[F]ind [R]ecent files' },
        {
            '<leader>ec',
            function()
                require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })
            end,
            desc = 'Open [E]ditor [C]onfig'
        },
        {
            '<leader>ep',
            function()
                require('telescope.builtin').find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy') })
            end,
            desc = 'Open [E]ditor [P]ackages'
        }
    },
    config = function(_, opts)
        local telescope = require('telescope')
        telescope.setup(opts)
        telescope.load_extension('fzf')
        telescope.load_extension('ui-select')
    end
}
