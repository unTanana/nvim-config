return {
    "nvim-tree/nvim-tree.lua",
    dependecies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local function on_attach(bufnr)
            local api = require("nvim-tree.api")

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- Default mappings. Feel free to modify or remove as you wish.
            --
            -- BEGIN_DEFAULT_ON_ATTACH
            vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
            vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
            vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
            vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
            vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
            vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
            vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
            vim.keymap.set("n", "<BS>", function()
                local node = api.tree.get_node_under_cursor()
                if node.open == false or node.type ~= "directory" then
                    api.node.navigate.parent()
                end
                api.node.open.edit()
            end, opts("Close Directory"))
            vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
            vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
            vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
            vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
            vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
            vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
            vim.keymap.set("n", "a", api.fs.create, opts("Create"))
            vim.keymap.set("n", "bd", api.marks.bulk.delete, opts("Delete Bookmarked"))
            vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
            vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle Filter: No Buffer"))
            vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
            vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Filter: Git Clean"))
            vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
            vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
            vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
            vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
            vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
            vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
            vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
            vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
            vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
            vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
            vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
            vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
            vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Filter: Dotfiles"))
            vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Filter: Git Ignore"))
            vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
            vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
            vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
            vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
            vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
            vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
            vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
            vim.keymap.set("n", "q", api.tree.close, opts("Close"))
            vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
            vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
            vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
            vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
            vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Filter: Hidden"))
            vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
            vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
            vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
            vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
            vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
            vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
            -- END_DEFAULT_ON_ATTACH

            -- Mappings migrated from view.mappings.list
            --
            -- You will need to insert "your code goes here" for any mappings with a custom action_cb
            vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
            vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
            vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
            vim.keymap.set("n", "h", function()
                local node = api.tree.get_node_under_cursor()
                if node.open == false or node.type ~= "directory" then
                    api.node.navigate.parent()
                end
                api.node.open.edit()
            end, opts("Close Directory"))
        end

        require("nvim-web-devicons").setup({
            override = {
                toml = {
                    icon = "",
                },
            },
        })

        require("nvim-tree").setup({
            auto_reload_on_write = false,
            hijack_directories = {
                enable = false,
            },
            update_cwd = true,
            diagnostics = {
                enable = false,
                show_on_dirs = false,
                icons = {
                    -- hint =  "",
                    -- info =  "",
                    -- warning =  "",
                    -- error =  "",
                    hint = "H",
                    info = "I",
                    warning = "W",
                    error = "E",
                },
            },
            update_focused_file = {
                enable = true,
                update_cwd = true,
                ignore_list = {},
            },
            system_open = {
                cmd = nil,
                args = {},
            },
            git = {
                enable = false,
                ignore = false,
                timeout = 200,
            },
            view = {
                width = 30,
                side = "left",
                -- mappings = {
                --     custom_only = false,
                --     list = {
                --     },
                -- },
                number = false,
                relativenumber = false,
                signcolumn = "yes",
                float = {
                    enable = true,
                    quit_on_focus_loss = true,
                    open_win_config = {
                        relative = "editor",
                        border = "rounded",
                        width = math.floor(vim.api.nvim_win_get_width(0) - vim.api.nvim_win_get_width(0) / 4),
                        height = math.floor(vim.api.nvim_win_get_height(0)),
                        col = math.floor(vim.api.nvim_win_get_width(0) - 3.5 * vim.api.nvim_win_get_width(0) / 4),
                    },
                },
            },
            renderer = {
                indent_markers = {
                    enable = false,
                    icons = {
                        corner = "└",
                        edge = "│",
                        item = "│",
                        none = " ",
                    },
                },
                icons = {
                    webdev_colors = true,
                    show = {
                        git = true,
                        folder = true,
                        file = true,
                        folder_arrow = true,
                    },
                    glyphs = {
                        default = "",
                        symlink = "",
                        git = {
                            deleted = "",
                            ignored = "◌",
                            renamed = "",
                            staged = "S",
                            unmerged = "",
                            unstaged = "",
                            untracked = "U",
                        },
                    },
                },
                highlight_git = true,
                group_empty = false,
                root_folder_modifier = ":t",
            },
            filters = {
                dotfiles = false,
                -- custom = { "node_modules", "\\.cache" },
                exclude = {},
            },
            trash = {
                cmd = "trash",
                require_confirm = true,
            },
            log = {
                enable = false,
                truncate = false,
                types = {
                    all = false,
                    config = false,
                    copy_paste = false,
                    diagnostics = false,
                    git = false,
                    profile = false,
                },
            },
            actions = {
                use_system_clipboard = true,
                change_dir = {
                    enable = true,
                    global = false,
                    restrict_above_cwd = false,
                },
                open_file = {
                    quit_on_open = false,
                    resize_window = false,
                    window_picker = {
                        enable = false,
                        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                        exclude = {
                            filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                            buftype = { "nofile", "terminal", "help" },
                        },
                    },
                },
            },
            on_attach = on_attach,
        })

        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
    end,
}
