return {
    "folke/noice.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                -- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false,
        },
        views = {
            split = {
                enter = true,
            }
        },
        routes = {
            {
                filter = { event = "msg_show", kind = "shell_out" },
                view = "notify",
                opts = { level = "info", title = "stdout" },
            },
            {
                filter = { event = "msg_show", kind = "shell_err" },
                view = "notify",
                opts = { level = "error", title = "stderr" },
            },
            {
                filter = { event = "msg_show", min_height = 10 },
                view = "split"
            },
            {
                filter = { event = "msg_show", kind = "search_count" },
                opts = { skip = true },
            },
            filter = {
                event = "msg_show",
                any = {
                    { find = "%d+L, %d+B" },
                    { find = "; after #%d+" },
                    { find = "; before #%d+" },
                },
            },
            view = "mini",
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        { "rcarriga/nvim-notify", opts = { background_colour = "#000000"  } }
    }
}

