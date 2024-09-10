return {
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require('nvim-ts-autotag').setup({
                opts = {
                    -- Defaults
                    enable_close = true,          -- Auto close tags
                    enable_rename = true,         -- Auto rename pairs of tags
                    enable_close_on_slash = false -- Auto close on trailing
                },
                aliases = {
                    ["astro"] = "html",
                    ["heex"] = "html"
                },
                -- Also override individual filetype configs, these take priority.
                -- Empty by default, useful if one of the "opts" global settings
                -- doesn't work well in a specific filetype
                per_filetype = {
                    ["html"] = {
                        enable_close = false
                    }
                }
            })
        end
    },
    {
        'windwp/nvim-autopairs',
        config = function()
            require("nvim-autopairs").setup(
                {
                    active = true,
                    on_config_done = nil,
                    ---@usage  modifies the function or method delimiter by filetypes
                    map_char = {
                        all = "(",
                        tex = "{",
                    },
                    ---@usage check bracket in same line
                    enable_check_bracket_line = false,
                    ---@usage check treesitter
                    check_ts = true,
                    ts_config = {
                        lua = { "string", "source" },
                        javascript = { "string", "template_string" },
                        java = false,
                    },
                    disable_filetype = { "TelescopePrompt", "spectre_panel" },
                    ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
                    enable_moveright = true,
                    ---@usage disable when recording or executing a macro
                    disable_in_macro = false,
                    ---@usage add bracket pairs after quote
                    enable_afterquote = true,
                    ---@usage map the <BS> key
                    map_bs = true,
                    ---@usage map <c-w> to delete a pair if possible
                    map_c_w = false,
                    ---@usage disable when insert after visual block mode
                    disable_in_visualblock = false,
                    ---@usage  change default fast_wrap
                    fast_wrap = {
                        map = "<M-e>",
                        chars = { "{", "[", "(", '"', "'" },
                        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
                        offset = 0, -- Offset from pattern match
                        end_key = "$",
                        keys = "qwertyuiopzxcvbnmasdfghjkl",
                        check_comma = true,
                        highlight = "Search",
                        highlight_grey = "Comment",
                    }
                });
        end
    }
}
