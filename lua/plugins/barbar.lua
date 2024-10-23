return {
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
            "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
        },
        init = function()
            vim.g.barbar_auto_setup = false
            local map = vim.api.nvim_set_keymap
            local opts = { noremap = true, silent = true }

            -- Move to previous/next
            map("n", "H", "<Cmd>BufferPrevious<CR>", opts)
            map("n", "L", "<Cmd>BufferNext<CR>", opts)
            -- Re-order to previous/next
            map("n", "<leader>wa", "<Cmd>BufferMovePrevious<CR>", opts)
            map("n", "<leader>wd", "<Cmd>BufferMoveNext<CR>", opts)
            -- Goto buffer in position...
            map("n", "<leader>1", "<Cmd>BufferGoto 1<CR>", opts)
            map("n", "<leader>2", "<Cmd>BufferGoto 2<CR>", opts)
            map("n", "<leader>3", "<Cmd>BufferGoto 3<CR>", opts)
            map("n", "<leader>4", "<Cmd>BufferGoto 4<CR>", opts)
            map("n", "<leader>5", "<Cmd>BufferGoto 5<CR>", opts)
            map("n", "<leader>6", "<Cmd>BufferGoto 6<CR>", opts)
            map("n", "<leader>7", "<Cmd>BufferGoto 7<CR>", opts)
            map("n", "<leader>8", "<Cmd>BufferGoto 8<CR>", opts)
            map("n", "<leader>9", "<Cmd>BufferGoto 9<CR>", opts)
            map("n", "<leader>0", "<Cmd>BufferLast<CR>", opts)
            map("n", "<C-1>", "<Cmd>BufferGoto 1<CR>", opts)
            map("n", "<C-2>", "<Cmd>BufferGoto 2<CR>", opts)
            map("n", "<C-3>", "<Cmd>BufferGoto 3<CR>", opts)
            map("n", "<C-4>", "<Cmd>BufferGoto 4<CR>", opts)
            map("n", "<C-5>", "<Cmd>BufferGoto 5<CR>", opts)
            map("n", "<C-6>", "<Cmd>BufferGoto 6<CR>", opts)
            map("n", "<C-7>", "<Cmd>BufferGoto 7<CR>", opts)
            map("n", "<C-8>", "<Cmd>BufferGoto 8<CR>", opts)
            map("n", "<C-9>", "<Cmd>BufferGoto 9<CR>", opts)
            map("n", "<C-0>", "<Cmd>BufferLast<CR>", opts)
            -- Pin/unpin buffer
            map("n", "<leader>ww", "<Cmd>BufferPin<CR>", opts)
            -- Goto pinned/unpinned buffer
            --                 :BufferGotoPinned
            --                 :BufferGotoUnpinned
            -- Close buffer
            --
            --

            local function close_buffer_and_window()
                if vim.fn.winnr("$") > 1 and vim.fn.winnr() > 1 then
                    vim.cmd("BufferClose")
                    vim.cmd("q")
                else
                    vim.cmd("BufferClose")
                end
            end

            vim.keymap.set("n", "<leader>x", close_buffer_and_window)

            -- Function to move the current buffer to a vertical split on the right
            local function move_buffer_to_vsplit_right()
                -- Check if there are more than one buffer
                if vim.fn.len(vim.fn.getbufinfo({ bufloaded = 1 })) > 1 then
                    vim.cmd("vsplit")
                    vim.cmd("wincmd h")
                    vim.cmd("BufferPrevious")
                    vim.cmd("wincmd l")
                else
                    print("Cannot do that")
                end
            end

            local function move_buffer_to_vsplit_left()
                -- Check if there's more than 1 window and the current window is not the leftmost
                if vim.fn.winnr("$") > 1 and vim.fn.winnr() > 1 then
                    -- Get the current buffer number and store it
                    local current_buffer = vim.api.nvim_get_current_buf()
                    -- Close the current window
                    vim.cmd("close")
                    -- Reopen the remembered buffer in the active window
                    vim.cmd("buffer " .. current_buffer)
                else
                    print("Cannot do that")
                end
            end

            vim.keymap.set("n", "<leader>L", move_buffer_to_vsplit_right)
            vim.keymap.set("n", "<leader>H", move_buffer_to_vsplit_left)

            -- Wipeout buffer
            --                 :BufferWipeout
            -- Close commands
            --                 :BufferCloseAllButCurrent
            --                 :BufferCloseAllButPinned
            --                 :BufferCloseAllButCurrentOrPinned
            --                 :BufferCloseBuffersLeft
            --                 :BufferCloseBuffersRight
            -- Magic buffer-picking mode
            -- map("n", "<C-p>", "<Cmd>BufferPick<CR>", opts)
            -- Sort automatically by...
            -- map("n", "<leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
            -- map("n", "<leader>bn", "<Cmd>BufferOrderByName<CR>", opts)
            -- map("n", "<leader>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
            -- map("n", "<leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

            -- Other:
            -- :BarbarEnable - enables barbar (enabled by default)
            -- :BarbarDisable - very bad command, should never be used
        end,
        opts = {
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            animation = false,
            -- insert_at_start = true,
            -- …etc.
            icons = {
                -- Disable showing icon for pinned buffers
                pinned = { button = "📌", filename = true },
            },
            -- Option to keep the buffer name visible
            visibility = {
                -- Show buffer name even when pinned
                pinned = "always",
            },
            -- Sets the maximum padding width with which to surround each tab
            maximum_padding = 0,

            -- Sets the minimum padding width with which to surround each tab
            minimum_padding = 0,
        },
        version = "^1.0.0", -- optional: only update when a new 1.x version is released
    },
}
