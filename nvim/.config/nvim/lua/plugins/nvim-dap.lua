return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "jay-babu/mason-nvim-dap.nvim",
    "williamboman/mason.nvim",
  },
  -- Force loading on these filetypes
  ft = { "c", "cpp", "rust" },
  -- Also load when these commands are used
  cmd = { "DapToggleBreakpoint", "DapContinue", "DapStepOver", "DapStepInto", "DapStepOut" },
  -- Load eagerly (remove lazy loading entirely)
  lazy = false,
  keys = {
    {
      "<leader>dt",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "[D]ebug [T]oggle [B]reakpoint",
    },
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "[D]ebug [Continue]",
    },
    {
      "<leader>dso",
      function()
        require("dap").step_over()
      end,
      desc = "[D]ebug [S]tep Over",
    },
    {
      "<leader>dsi",
      function()
        require("dap").step_into()
      end,
      desc = "[D]ebug [S]tep Into",
    },
    {
      "<leader>dsu",
      function()
        require("dap").step_out()
      end,
      desc = "[D]ebug [S]tep Out",
    },
    {
      "<leader>dr",
      function()
        require("dap").repl.open()
      end,
      desc = "[D]ebug Open [R]EPL",
    },
    {
      "<leader>dk",
      function()
        require("dap").terminate()
      end,
      desc = "[D]ebug [T]erminate",
    },
    {
      "<leader>dl",
      function()
        require("dap").run_last()
      end,
      desc = "[D]ebug Run [L]ast",
    },
    {
      "<leader>dh",
      function()
        require("dap.ui.widgets").hover()
      end,
      mode = { "n", "v" },
      desc = "Debug: Hover",
    },
    {
      "<leader>dp",
      function()
        require("dap.ui.widgets").preview()
      end,
      mode = { "n", "v" },
      desc = "Debug: Preview",
    },
    {
      "<leader>df",
      function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.frames)
      end,
      desc = "Debug: Frames",
    },
    {
      "<leader>ds",
      function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
      end,
      desc = "Debug: Scopes",
    },
  },

  config = function()
    local dap = require("dap")
    local dapui_status, dapui = pcall(require, "dapui")
    local vt_status, dap_vt = pcall(require, "nvim-dap-virtual-text")

    -- IMPORTANT: Setup Mason first, then mason-nvim-dap
    require("mason").setup()

    -- Setup mason-nvim-dap BEFORE configuring adapters
    require("mason-nvim-dap").setup({
      automatic_installation = true,
      ensure_installed = { "codelldb" },
      handlers = {
        -- Default handler - will be called for each installed debugger
        function(config)
          require("mason-nvim-dap").default_setup(config)
        end,

        -- Override for codelldb specifically if needed
        codelldb = function(config)
          config.adapters = {
            type = "server",
            port = "${port}",
            executable = {
              command = "codelldb", -- Mason will put this in PATH
              args = { "--port", "${port}" },
            },
          }
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    })

    -- Manual adapter setup (as backup if mason doesn't work)
    -- This will be overridden by mason-nvim-dap if it works correctly
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "codelldb", -- This should be in PATH after Mason install
        args = { "--port", "${port}" },
      },
    }

    -- Setup DAP UI
    if dapui_status then
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        controls = {
          icons = {
            pause = "⏸",
            play = "▶",
            step_into = "⏎",
            step_over = "⏭",
            step_out = "⏮",
            step_back = "b",
            run_last = "▶▶",
            terminate = "⏹",
            disconnect = "⏏",
          },
        },
      })

      -- Auto open/close DAP UI
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })

      -- Additional keymaps to handle disassembly issues
      vim.keymap.set("n", "<leader>da", function()
        -- Force close any disassembly buffers
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          local buf_name = vim.api.nvim_buf_get_name(buf)
          if buf_name:match("disassembly") or buf_name:match("Disassembly") then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
        vim.notify("Closed disassembly buffers", vim.log.levels.INFO)
      end, { desc = "Debug: Close disassembly buffers" })
    end

    -- Setup virtual text
    if vt_status then
      dap_vt.setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        filter_references_pattern = "<module",
        virt_text_pos = "eol",
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
      })
    end

    -- =============================================================================
    -- CONFIGURATIONS
    -- =============================================================================

    -- C/C++ configurations
    dap.configurations.c = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},

        -- Prevent assembly view issues
        sourceLanguages = { "c" },
        initCommands = {
          "settings set target.process.thread.step-avoid-regexp '^(std::)'",
          "settings set target.x86-disassembly-flavor intel",
          "settings set stop-disassembly-display never",
        },
        preRunCommands = {
          "settings set stop-disassembly-display never",
        },
      },
      {
        name = "Attach to process",
        type = "codelldb",
        request = "attach",
        pid = function()
          return tonumber(vim.fn.input("Process ID: "))
        end,
        cwd = "${workspaceFolder}",

        -- Same settings for attach mode
        sourceLanguages = { "c" },
        initCommands = {
          "settings set stop-disassembly-display never",
        },
      },
    }

    -- C++ configurations (separate from C for better language detection)
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},

        -- C++ specific settings
        sourceLanguages = { "cpp", "c++" },
        initCommands = {
          "settings set target.process.thread.step-avoid-regexp '^(std::)'",
          "settings set target.x86-disassembly-flavor intel",
          "settings set stop-disassembly-display never",
        },
        preRunCommands = {
          "settings set stop-disassembly-display never",
        },
      },
      {
        name = "Attach to process",
        type = "codelldb",
        request = "attach",
        pid = function()
          return tonumber(vim.fn.input("Process ID: "))
        end,
        cwd = "${workspaceFolder}",

        sourceLanguages = { "cpp", "c++" },
        initCommands = {
          "settings set stop-disassembly-display never",
        },
      },
    }

    -- Rust configurations
    dap.configurations.rust = {
      {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = function()
          -- Try to find the target executable
          local cwd = vim.fn.getcwd()
          local target_dir = cwd .. "/target/debug/"

          -- Get the package name from Cargo.toml
          local cargo_toml = cwd .. "/Cargo.toml"
          if vim.fn.filereadable(cargo_toml) == 1 then
            local lines = vim.fn.readfile(cargo_toml)
            for _, line in ipairs(lines) do
              local name = line:match('name%s*=%s*"([^"]+)"')
              if name then
                local executable = target_dir .. name
                if vim.fn.filereadable(executable) == 1 then
                  return executable
                end
              end
            end
          end

          -- Fallback to user input
          return vim.fn.input("Path to executable: ", target_dir, "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},

        -- Rust-specific pretty printers
        initCommands = function()
          local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))
          local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
          local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

          local commands = {}
          local file = io.open(commands_file, "r")
          if file then
            for line in file:lines() do
              table.insert(commands, line)
            end
            file:close()
          end
          table.insert(commands, 1, script_import)

          return commands
        end,
      },
      {
        name = "Attach to process",
        type = "codelldb",
        request = "attach",
        pid = function()
          return tonumber(vim.fn.input("Process ID: "))
        end,
        cwd = "${workspaceFolder}",
      },
    }

    -- Helper functions
    local function cpp_debug()
      local file = vim.fn.expand("%:p")
      local filename = vim.fn.expand("%:t")
      local exe = vim.fn.expand("%:p:r")

      -- Check if current file exists and is a source file
      if not vim.fn.filereadable(file) then
        vim.notify("Current file doesn't exist or isn't readable", vim.log.levels.ERROR)
        return
      end

      -- Check if it's a source file (not header)
      local ext = vim.fn.expand("%:e")
      if not vim.tbl_contains({ "c", "cpp", "cc", "cxx", "c++" }, ext) then
        vim.notify("Current file is not a C/C++ source file (.c, .cpp, .cc, .cxx)", vim.log.levels.ERROR)
        return
      end

      -- Use appropriate compiler with better debug flags
      local compiler = ext == "c" and "gcc" or "g++"
      -- Key changes: -O0 (no optimization), -ggdb3 (max debug info), -fno-omit-frame-pointer
      local compile_cmd = string.format("%s -O0 -ggdb3 -fno-omit-frame-pointer -o %s %s", compiler, exe, file)

      vim.notify("Compiling: " .. compile_cmd, vim.log.levels.INFO)
      local result = vim.fn.system(compile_cmd)

      if vim.v.shell_error ~= 0 then
        vim.notify("Compilation failed:\n" .. result, vim.log.levels.ERROR)
        return
      end

      vim.notify("Compilation successful. Starting debugger...", vim.log.levels.INFO)

      -- Create a temporary configuration for this specific executable
      local temp_config = {
        name = "Debug " .. filename,
        type = "codelldb",
        request = "launch",
        program = exe,
        cwd = vim.fn.expand("%:p:h"), -- Directory of the current file
        stopOnEntry = false,
        args = {},

        -- CodeLLDB specific settings to prevent assembly view
        sourceLanguages = { "cpp", "c" },

        -- Initialize with commands to improve source mapping
        initCommands = {
          -- Disable automatic disassembly view
          "settings set target.process.thread.step-avoid-regexp '^(std::)'",
          "settings set target.x86-disassembly-flavor intel",
          -- Force source display preference
          "settings set stop-disassembly-display never",
          'settings set target.source-map "" "' .. vim.fn.expand("%:p:h") .. '"',
        },

        -- Pre-run commands to set up debugging environment
        preRunCommands = {
          -- Ensure we stay in source mode
          "settings set stop-disassembly-display never",
        },
      }

      -- Add temporary config and run it
      table.insert(dap.configurations.c, temp_config)
      dap.run(temp_config)
    end

    local function rust_debug()
      -- Build the project first
      vim.fn.system("cargo build")
      if vim.v.shell_error ~= 0 then
        vim.notify("Build failed", vim.log.levels.ERROR)
        return
      end

      -- Start debugging
      dap.continue()
    end

    -- User commands
    vim.api.nvim_create_user_command("CppDebug", cpp_debug, { desc = "Build and debug current C++ file" })
    vim.api.nvim_create_user_command("CppDebugWithArgs", function()
      local file = vim.fn.expand("%:p")
      local ext = vim.fn.expand("%:e")
      local exe = vim.fn.expand("%:p:r")

      if not vim.tbl_contains({ "c", "cpp", "cc", "cxx", "c++" }, ext) then
        vim.notify("Current file is not a C/C++ source file", vim.log.levels.ERROR)
        return
      end

      -- Get custom compile command
      local compile_cmd =
        vim.fn.input("Compile command: ", (ext == "c" and "gcc" or "g++") .. " -g -o " .. exe .. " " .. file)

      if compile_cmd == "" then
        return
      end

      vim.notify("Compiling: " .. compile_cmd, vim.log.levels.INFO)
      local result = vim.fn.system(compile_cmd)

      if vim.v.shell_error ~= 0 then
        vim.notify("Compilation failed:\n" .. result, vim.log.levels.ERROR)
        return
      end

      -- Get program arguments
      local args_input = vim.fn.input("Program arguments (space separated): ")
      local args = {}
      if args_input ~= "" then
        for arg in args_input:gmatch("%S+") do
          table.insert(args, arg)
        end
      end

      local temp_config = {
        name = "Debug with custom args",
        type = "codelldb",
        request = "launch",
        program = exe,
        cwd = vim.fn.expand("%:p:h"),
        stopOnEntry = false,
        args = args,
      }

      dap.run(temp_config)
    end, { desc = "Build and debug with custom compile command and args" })

    vim.api.nvim_create_user_command("RustDebug", rust_debug, { desc = "Build and debug Rust project" })

    -- Debug commands to check if everything is working
    vim.api.nvim_create_user_command("DapCheckAdapters", function()
      print("Available adapters:")
      for name, adapter in pairs(dap.adapters) do
        print("  " .. name .. ": " .. vim.inspect(adapter))
      end
    end, { desc = "Check DAP adapters" })

    vim.api.nvim_create_user_command("DapCheckConfigs", function()
      local ft = vim.bo.filetype
      if dap.configurations[ft] then
        print("Configurations for " .. ft .. ":")
        for i, config in ipairs(dap.configurations[ft]) do
          print("  " .. i .. ". " .. config.name)
        end
      else
        print("No configurations found for filetype: " .. ft)
      end
    end, { desc = "Check DAP configurations for current filetype" })
  end,
}
