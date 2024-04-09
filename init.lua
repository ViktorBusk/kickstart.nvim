-- Windows specific stuff like (lang, shell, clipboard)
if vim.fn.has "win32" == 1 then
    vim.cmd [[language en_US]]
    vim.opt.shell = "pwsh.exe"
    vim.opt.shellcmdflag =
        "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
    vim.cmd [[
        let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        set shellquote= shellxquote=
        ]]

    -- Set a compatible clipboard manager
    vim.g.clipboard = {
        copy = {
            ["+"] = "win32yank.exe -i --crlf",
            ["*"] = "win32yank.exe -i --crlf",
        },
        paste = {
            ["+"] = "win32yank.exe -o --lf",
            ["*"] = "win32yank.exe -o --lf",
        },
    }
end

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- Make line numbers default
vim.opt.number = true
-- vim.opt.relativenumber = true

-- NOTE: GuessIndent is used but this is just for the default behavior
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- insert 2 spaces for a tab

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = true
vim.opt.ruler = false
vim.opt.cmdheight = 1

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.writebackup = false

-- Set term gui colors (most terminals support this)
vim.opt.termguicolors = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Display lines as one long line
vim.opt.wrap = false

-- Pop up menu height
vim.opt.pumheight = 5

-- Decrease update time
vim.opt.updatetime = 100

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 500

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Removed semicolon
vim.opt.cinkeys = "0{,0},0),0],0#,!^F,o,O,e"

-- GUI settings
vim.opt.guifont = "JetBrainsMono Nerd Font:10"
--vim.opt.foldcolumn = "2"
vim.opt.signcolumn = "yes:5"
vim.cmd "set linespace=2"
vim.g.neovide_refresh_rate = 165

vim.g.neovide_cursor_animation_length = 0.035
vim.g.neovide_transparency = 1.0
-- vim.g.neovide_floating_opacity=0.4
vim.g.neovide_floating_blur = "v:false"
vim.g.neovide_remember_window_size = "v:true"

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

-- Better terminal navigation
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l")
--
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "No Highlight" })

-- Comments
vim.keymap.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise()<CR>", { desc = "Comment line" })
vim.keymap.set("v", "<leader>/", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Comment lines" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

--  See `:help wincmd` for a list of all window commands
-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- vsplit
vim.keymap.set("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "[V]ertical Split" })

-- Easymotion
vim.keymap.set("n", "<leader>a", "<Plug>(easymotion-overwin-f2)", { desc = "Easymotion" })

-- Package control
vim.keymap.set("n", "<leader>L", "<cmd>Lazy show<CR>", { desc = "Package Control ([L]azy)" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
vim.cmd [[
    augroup _general_settings
        autocmd!
        autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
        autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({timeout = 200})
        autocmd BufWinEnter * :set formatoptions-=cro
        autocmd FileType qf set nobuflisted
    augroup end

    augroup _git
        autocmd!
        autocmd FileType gitcommit setlocal wrap
        autocmd FileType gitcommit setlocal spell
    augroup end

    augroup _markdown
        autocmd!
        autocmd FileType markdown setlocal wrap
        autocmd FileType markdown setlocal spell
    augroup end

    augroup _auto_resize
        autocmd!
        autocmd VimResized * tabdo wincmd =
    augroup end

    augroup _guess_indent
        autocmd!
        autocmd BufWinEnter * silent!GuessIndent
    augroup end
]]

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require("lazy").setup({
    -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
    {
        "nmac427/guess-indent.nvim",
        opts = {
            auto_cmd = false, -- Set to false to disable automatic execution
            override_editorconfig = false, -- Set to true to override settings set by .editorconfig
            filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
                "netrw",
                "tutor",
            },
            buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
                "help",
                "nofile",
                "terminal",
                "prompt",
            },
        },
    },
    {
        "numToStr/Comment.nvim",
        lazy = false,
        opts = {
            pre_hook = function(ctx)
                -- Only calculate commentstring for tsx filetypes
                if vim.bo.filetype == "typescriptreact" then
                    local U = require "Comment.utils"

                    -- Determine whether to use linewise or blockwise commentstring
                    local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

                    -- Determine the location where to calculate commentstring from
                    local location = nil
                    if ctx.ctype == U.ctype.blockwise then
                        location = require("ts_context_commentstring.utils").get_cursor_location()
                    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                        location = require("ts_context_commentstring.utils").get_visual_start_location()
                    end

                    return require("ts_context_commentstring.internal").calculate_commentstring {
                        key = type,
                        location = location,
                    }
                end
            end,
        },
        config = function(_, opts)
            require("Comment").setup(opts)
        end,
    },
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
                delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
            },
            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                interval = 1000,
                follow_files = true,
            },
            attach_to_untracked = true,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            current_line_blame_formatter_opts = {
                relative_time = false,
            },
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000,
            preview_config = {
                -- Options passed to nvim_open_win
                border = "single",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1,
            },
            yadm = {
                enable = false,
            },
        },
        config = function(_, opts)
            require("gitsigns").setup(opts)
        end,
    },
    { -- Useful plugin to show you pending keybinds.
        "folke/which-key.nvim",
        event = "VimEnter", -- Sets the loading event to 'VimEnter'
        config = function() -- This is the function that runs, AFTER loading
            local which_key = require "which-key"

            which_key.setup {
                plugins = {
                    marks = true, -- shows a list of your marks on ' and `
                    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                    spelling = {
                        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                        suggestions = 20, -- how many suggestions should be shown in the list?
                    },
                    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                    -- No actual key bindings are created
                    presets = {
                        operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
                        motions = true, -- adds help for motions
                        text_objects = true, -- help for text objects triggered after entering an operator
                        windows = true, -- default bindings on <c-w>
                        nav = true, -- misc bindings to work with windows
                        z = false, -- bindings for folds, spelling and others prefixed with z
                        g = false, -- bindings for prefixed with g
                    },
                },
                -- add operators that will trigger motion and text object completion
                -- to enable all native operators, set the preset / operators plugin above
                -- operators = { gc = "Comments" },
                key_labels = {
                    -- override the label used to display some keys. It doesn't effect WK in any other way.
                    -- For example:
                    -- ["<space>"] = "SPC",
                    -- ["<cr>"] = "RET",
                    -- ["<tab>"] = "TAB",
                },
                icons = {
                    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                    separator = "➜", -- symbol used between a key and it's label
                    group = "+", -- symbol prepended to a group
                },
                popup_mappings = {
                    scroll_down = "<c-d>", -- binding to scroll down inside the popup
                    scroll_up = "<c-u>", -- binding to scroll up inside the popup
                },
                window = {
                    border = "none", -- none, single, double, shadow
                    position = "bottom", -- bottom, top
                    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
                    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
                    winblend = 0,
                },
                layout = {
                    height = { min = 4, max = 25 }, -- min and max height of the columns
                    width = { min = 20, max = 50 }, -- min and max width of the columns
                    spacing = 3, -- spacing between columns
                    align = "left", -- align columns left, center or right
                },
                ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
                hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
                show_help = true, -- show help message on the command line when the popup is visible
                triggers = "auto", -- automatically setup triggers
                -- triggers = {"<leader>"} -- or specify a list manually
                triggers_blacklist = {
                    -- list of mode / prefixes that should never be hooked by WhichKey
                    -- this is mostly relevant for key maps that start with a native binding
                    -- most people should not need to change this
                    i = { "j", "k" },
                    v = { "j", "k" },
                },
            }
            -- Document e
            -- xisting key chains
            which_key.register {
                -- ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
                -- ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
                -- ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
                -- ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
                -- ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
                ["<leader>l"] = { name = "[L]SP", _ = "which_key_ignore" },
            }
        end,
    },
    { -- Fuzzy Finder (files, lsp, etc)
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { -- If encountering errors, see telescope-fzf-native README for installation instructions
                "nvim-telescope/telescope-fzf-native.nvim",

                -- `build` is used to run some command when the plugin is installed/updated.
                -- This is only run then, not every time Neovim starts up.
                build = "make",

                -- `cond` is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                    return vim.fn.executable "make" == 1
                end,
            },
            { "nvim-telescope/telescope-ui-select.nvim" },

            -- Useful for getting pretty icons, but requires a Nerd Font.
            {
                "nvim-tree/nvim-web-devicons",
                enabled = vim.g.have_nerd_font,
                lazy = true,
                -- HACK: Latest release give errors on windows
                commit = "5efb8bd",
            },
        },
        -- FIXME: Add personal config
        config = function()
            -- [[ Configure Telescope ]]
            -- See `:help telescope` and `:help telescope.setup()`
            require("telescope").setup {
                -- You can put your default mappings / updates / etc. in here
                --  All the info you're looking for is in `:help telescope.setup()`
                --
                -- defaults = {
                --   mappings = {
                --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
                --   },
                -- },
                -- pickers = {}
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
            }

            -- Enable Telescope extensions if they are installed
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")

            -- See `:help telescope.builtin`
            local builtin = require "telescope.builtin"
            vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
            vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
            vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
            vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
            vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
            vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
            vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
            vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
            vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

            -- FIXME:
            -- Slightly advanced example of overriding default behavior and theme
            -- vim.keymap.set('n', '<leader>/', function()
            --   -- You can pass additional configuration to Telescope to change the theme, layout, etc.
            --   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            --     winblend = 10,
            --     previewer = false,
            --   })
            -- end, { desc = '[/] Fuzzily search in current buffer' })

            -- It's also possible to pass additional configuration options.
            --  See `:help telescope.builtin.live_grep()` for information about particular keys
            -- vim.keymap.set('n', '<leader>s/', function()
            --   builtin.live_grep {
            --     grep_open_files = true,
            --     prompt_title = 'Live Grep in Open Files',
            --   }
            -- end, { desc = '[S]earch [/] in Open Files' })

            -- Shortcut for searching your Neovim configuration files
            vim.keymap.set("n", "<leader>sn", function()
                builtin.find_files { cwd = vim.fn.stdpath "config" }
            end, { desc = "[S]earch [N]eovim files" })
        end,
    },

    { -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Useful status updates for LSP.
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            -- { 'j-hui/fidget.nvim', opts = {} },

            -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
            -- used for completion, annotations and signatures of Neovim apis
            { "folke/neodev.nvim", opts = {} },
        },
        config = function()
            -- Brief aside: **What is LSP?**
            --
            -- LSP is an initialism you've probably heard, but might not understand what it is.
            --
            -- LSP stands for Language Server Protocol. It's a protocol that helps editors
            -- and language tooling communicate in a standardized fashion.
            --
            -- In general, you have a "server" which is some tool built to understand a particular
            -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
            -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
            -- processes that communicate with some "client" - in this case, Neovim!
            --
            -- LSP provides Neovim with features like:
            --  - Go to definition
            --  - Find references
            --  - Autocompletion
            --  - Symbol Search
            --  - and more!
            --
            -- Thus, Language Servers are external tools that must be installed separately from
            -- Neovim. This is where `mason` and related plugins come into play.
            --
            -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
            -- and elegantly composed help section, `:help lsp-vs-treesitter`

            --  This function gets run when an LSP attaches to a particular buffer.
            --    That is to say, every time a new file is opened that is associated with
            --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
            --    function will be executed to configure the current buffer
            --

            local signs = {
                { name = "DiagnosticSignError", text = "" },
                { name = "DiagnosticSignWarn", text = "" },
                { name = "DiagnosticSignHint", text = "" },
                { name = "DiagnosticSignInfo", text = "" },
            }

            for _, sign in ipairs(signs) do
                vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
            end

            local config = {
                -- disable virtual text
                virtual_text = false,
                -- show signs
                signs = {
                    active = false,
                },
                update_in_insert = false,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "none",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            }

            vim.diagnostic.config(config)

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
                callback = function(event)
                    -- NOTE: Remember that Lua is a real programming language, and as such it is possible
                    -- to define small helper and utility functions so you don't have to repeat yourself.
                    --
                    -- In this case, we create a function that lets us more easily define mappings specific
                    -- for LSP related items. It sets the mode, buffer and description for us each time.
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    -- Jump to the definition of the word under your cursor.
                    --  This is where a variable was first declared, or where a function is defined, etc.
                    --  To jump back, press <C-t>.
                    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

                    -- Find references for the word under your cursor.
                    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

                    -- Jump to the implementation of the word under your cursor.
                    --  Useful when your language has ways of declaring types without an actual implementation.
                    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

                    -- Jump to the type of the word under your cursor.
                    --  Useful when you're not sure what type a variable is and you want to see
                    --  the definition of its *type*, not where it was *defined*.
                    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

                    -- Fuzzy find all the symbols in your current document.
                    --  Symbols are things like variables, functions, types, etc.
                    map("<leader>ls", require("telescope.builtin").lsp_document_symbols, "[Document [s]ymbols")

                    -- Fuzzy find all the symbols in your current workspace.
                    --  Similar to document symbols, except searches over your entire project.
                    map("<leader>lS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace [S]ymbols")

                    -- Rename the variable under your cursor.
                    --  Most Language Servers support renaming across files, etc.
                    map("<leader>lr", vim.lsp.buf.rename, "[R]eame")

                    -- Execute a code action, usually your cursor needs to be on top of an error
                    -- or a suggestion from your LSP for this to activate.
                    map("<leader>la", vim.lsp.buf.code_action, "[A]ction")

                    -- Opens a popup that displays documentation about the word under your cursor
                    --  See `:help K` for why this keymap.
                    map("K", vim.lsp.buf.hover, "Hover Documentation")

                    -- WARN: This is not Goto Definition, this is Goto Declaration.
                    --  For example, in C this would take you to the header.
                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                    map("<C-i>", vim.lsp.buf.signature_help, "Signatre Help")

                    -- The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    --    See `:help CursorHold` for information about when this is executed
                    --
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.server_capabilities.documentHighlightProvider then
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end
                end,
            })

            -- LSP servers and clients are able to communicate to each other what features they support.
            --  By default, Neovim doesn't support everything that is in the LSP specification.
            --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
            --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            -- Enable the following language servers
            --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
            --
            --  Add any additional override configuration in the following tables. Available keys are:
            --  - cmd (table): Override the default command used to start the server
            --  - filetypes (table): Override the default list of associated filetypes for the server
            --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
            --  - settings (table): Override the default settings passed when initializing the server.
            --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
            local servers = {
                -- clangd = {},
                -- gopls = {},
                -- pyright = {},
                -- rust_analyzer = {},
                -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
                --
                -- Some languages (like typescript) have entire language plugins that can be useful:
                --    https://github.com/pmizio/typescript-tools.nvim
                --
                -- But for many setups, the LSP (`tsserver`) will work just fine
                -- tsserver = {},
                --

                lua_ls = {
                    -- cmd = {...},
                    -- filetypes = { ...},
                    -- capabilities = {},
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                            -- diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },
            }

            -- Ensure the servers and tools above are installed
            --  To check the current status of installed tools and/or manually install
            --  other tools, you can run
            --    :Mason
            --
            --  You can press `g?` for help in this menu.
            require("mason").setup()

            -- You can add other tools here that you want Mason to install
            -- for you, so that they are available from within Neovim.
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                "stylua", -- Used to format Lua code
            })
            require("mason-tool-installer").setup { ensure_installed = ensure_installed }

            require("mason-lspconfig").setup {
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for tsserver)
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            }
        end,
    },

    { -- Autoformat
        "stevearc/conform.nvim",
        lazy = false,
        keys = {
            {
                "<leader>f",
                function()
                    require("conform").format { async = true, lsp_fallback = true }
                end,
                mode = "",
                desc = "[F]ormat buffer",
            },
        },
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                -- Disable "format_on_save lsp_fallback" for languages that don't
                -- have a well standardized coding style. You can add additional
                -- languages here or re-enable it for the disabled ones.
                local disable_filetypes = { lua = true, c = true, cpp = true }
                return {
                    timeout_ms = 500,
                    lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
                }
            end,
            formatters_by_ft = {
                lua = { "stylua" },
                -- Conform can also run multiple formatters sequentially
                -- python = { "isort", "black" },
                --
                -- You can use a sub-list to tell conform to run *until* a formatter
                -- is found.
                -- javascript = { { "prettierd", "prettier" } },
            },
        },
    },

    { -- Autocompletion
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                "L3MON4D3/LuaSnip",
                build = (function()
                    -- Build Step is needed for regex support in snippets.
                    -- This step is not supported in many windows environments.
                    -- Remove the below condition to re-enable on windows.
                    if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then
                        return
                    end
                    return "make install_jsregexp"
                end)(),
                dependencies = {
                    -- `friendly-snippets` contains a variety of premade snippets.
                    --    See the README about individual language/framework/plugin snippets:
                    --    https://github.com/rafamadriz/friendly-snippets
                    {
                        "rafamadriz/friendly-snippets",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load()
                        end,
                    },
                },
            },
            "saadparwaiz1/cmp_luasnip",

            -- Adds other completion capabilities.
            --  nvim-cmp does not ship with all sources by default. They are split
            --  into multiple repos for maintenance purposes.
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
        config = function()
            -- See `:help cmp`
            local cmp = require "cmp"
            local luasnip = require "luasnip"
            require("luasnip/loaders/from_vscode").lazy_load()

            luasnip.config.setup {}

            local check_backspace = function()
                local col = vim.fn.col "." - 1
                return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
            end

            local kind_icons = {
                Text = "",
                Method = "",
                Function = "",
                Constructor = "",
                Field = "",
                Variable = "",
                Class = "",
                Interface = "",
                Module = "",
                Property = "",
                Unit = "",
                Value = "",
                Enum = "",
                Keyword = "",
                Snippet = "",
                Color = "",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "",
                Struct = "",
                Event = "",
                Operator = "",
                TypeParameter = "",
            }

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = "menu,menuone,noinsert,noselect" },
                window = {
                    documentation = cmp.config.disable,
                    completion = {
                        scrollbar = true,
                        -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        -- col_offset = -3,
                        -- side_padding = 0,
                    },
                },

                -- For an understanding of why these mappings were
                -- chosen, you will need to read `:help ins-completion`
                --
                -- No, but seriously. Please read `:help ins-completion`, it is really good!
                mapping = {
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ["<C-e>"] = cmp.mapping {
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    },
                    -- Accept currently selected item. If none selected, `select` first item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ["<CR>"] = cmp.mapping.confirm { select = true },
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif check_backspace() then
                            fallback()
                        else
                            fallback()
                        end
                    end, {
                        "i",
                        "s",
                    }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {
                        "i",
                        "s",
                    }),
                },
                formatting = {
                    expandable_indicator = false,
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        -- Use this to make the string fields in vim_item constant length
                        local function clamp(str, length)
                            if str == nil then
                                return
                            end

                            local current_length = #str
                            if current_length > length then
                                -- Trim the string if it's longer than the desired length and add "..."
                                return string.sub(str, 1, length - 3) .. "..."
                            elseif current_length < length then
                                -- Add whitespaces to the end if it's shorter than the desired length
                                return str .. string.rep(" ", length - current_length)
                            else
                                -- String is already the desired length
                                return str
                            end
                        end

                        vim_item.abbr = clamp(vim_item.abbr, 30)
                        vim_item.abbr = vim_item.abbr .. "      " -- Add some padding
                        vim_item.menu = clamp(entry:get_completion_item().detail, 20)

                        -- This concatonates the icons with the name of the item kind
                        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

                        return vim_item
                    end,
                },
                sources = {
                    { name = "path" },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "nvim_lsp_signature_help" },
                },
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                experimental = {
                    ghost_text = true,
                },
            }

            -- Colors
            vim.api.nvim_set_hl(0, "CmpItemKind", { bold = true })
            vim.api.nvim_set_hl(0, "CmpItemAbbr", { link = "CursorLineNr" })
            vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CursorLineNr" })

            vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "NONE" })
            vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })

            -- vim.api.nvim_set_hl(0, "Pmenu", { bg = "#252526", fg = "#CFCFCF" })
            -- -- gray
            -- vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
            -- -- blue
            -- vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
            -- vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
            -- -- light blue
            -- vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "#FFFFFF", fg = "#9CDCFE" })
            -- vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
            -- vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
            -- -- pink
            -- vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
            -- vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
            -- -- front
            -- vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
            -- vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
            -- vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })
        end,
    },

    { -- You can easily change to a different colorscheme.
        -- Change the name of the colorscheme plugin below, and then
        -- change the command in the config to whatever the name of that colorscheme is.
        --
        -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
        "folke/tokyonight.nvim",
        priority = 1000, -- Make sure to load this before all the other start plugins.
        init = function()
            -- Load the colorscheme here.
            -- Like many other themes, this one has different styles, and you could load
            -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
            vim.cmd.colorscheme "tokyonight-night"
            -- You can configure highlights by doing something like:
            -- vim.cmd.hi "Comment gui=none"
        end,
        opts = {
            terminal_colors = true,
            styles = {
                -- Style to be applied to different syntax groups
                -- Value is any valid attr-list value for `:help nvim_set_hl`
                comments = { italic = false },
                keywords = { italic = false },
                functions = {},
                variables = {},
                -- Background styles. Can be "dark", "transparent" or "normal"
                sidebars = "dark", -- style for sidebars, see below
                floats = "dark", -- style for floating windows
            },
        },
    },

    -- Highlight todo, notes, etc in comments
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local todo_comments = require "todo-comments"
            todo_comments.setup {
                signs = false,
                highlight = {
                    before = "", -- "fg" or "bg" or empty
                    keyword = "fg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
                    after = "", -- "fg" or "bg" or empty
                    pattern = [[.*<(KEYWORDS)(\([^\)]*\))?:]],
                    comments_only = true, -- uses treesitter to match keywords in comments only
                    max_line_len = 400, -- ignore lines longer than this
                    exclude = {}, -- list of file types to exclude highlighting
                },
                search = {
                    command = "rg",
                    args = {
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                    },
                    pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]],
                },
            }

            -- Manually set highlight color
            --
            -- FIX: FIXING
            vim.cmd.hi "TodoFgFIX gui=bold guifg=#FF8400"
            -- HACK: HACKING
            vim.cmd.hi "TodoFgHACK gui=bold guifg=#FF8400"
            -- NOTE: NOTING
            vim.cmd.hi "TodoFgNOTE gui=bold guifg=#18C8EC"
            -- PERF: PERFING
            vim.cmd.hi "TodoFgPERF gui=bold guifg=#FF8400"
            -- TEST: TESTING
            vim.cmd.hi "TodoFgTEST gui=bold guifg=#FF8400"
            -- TODO: TODO
            vim.cmd.hi "TodoFgTODO gui=bold guifg=#FF8400"
            -- WARN: WARNING
            vim.cmd.hi "TodoFgWARN gui=bold guifg=#FF8400"
        end,
    },
    { -- Collection of various small independent plugins/modules
        "echasnovski/mini.nvim",
        config = function()
            -- Better Around/Inside textobjects
            --
            -- Examples:
            --  - va)  - [V]isually select [A]round [)]paren
            --  - yinq - [Y]ank [I]nside [N]ext [']quote
            --  - ci'  - [C]hange [I]nside [']quote
            require("mini.ai").setup { n_lines = 500 }

            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            --
            -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- - sd'   - [S]urround [D]elete [']quotes
            -- - sr)'  - [S]urround [R]eplace [)] [']
            require("mini.surround").setup()

            -- Simple and easy statusline.
            --  You could remove this setup call if you don't like it,
            --  and try some other statusline plugin
            -- local statusline = require 'mini.statusline'
            -- set use_icons to true if you have a Nerd Font
            -- statusline.setup { use_icons = vim.g.have_nerd_font }

            -- You can configure sections in the statusline by overriding their
            -- default behavior. For example, here we set the section for
            -- cursor location to LINE:COLUMN
            ---@diagnostic disable-next-line: duplicate-set-field
            -- statusline.section_location = function()
            -- return '%2l:%-2v'
            -- end

            -- ... and there is more!
            --  Check out: https://github.com/echasnovski/mini.nvim
        end,
    },
    { -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "bash", "c", "html", "lua", "luadoc", "markdown", "vim", "vimdoc" },
            -- Autoinstall languages that are not installed
            auto_install = true,
            highlight = {
                enable = true,
                -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                --  If you are experiencing weird indenting issues, add the language to
                --  the list of additional_vim_regex_highlighting and disabled languages for indent.
                additional_vim_regex_highlighting = { "ruby" },
            },
            indent = { enable = true, disable = { "lua", "python", "cpp", "c", "ruby" } },
        },
        config = function(_, opts)
            -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup(opts)

            -- There are additional nvim-treesitter modules that you can use to interact
            -- with nvim-treesitter. You should go explore a few and see what interests you:
            --
            --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
            --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
            --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
        end,
    },
    {
        "tikhomirov/vim-glsl",
        config = function()
            vim.api.nvim_create_autocmd({ "BufNewFile, BufRead" }, {
                desc = "Treat shader files using the .glsl extension",
                pattern = {
                    "*.glsl",
                    "*.comp",
                    "*.vert",
                    "*.frag",
                    "*.geom",
                    "*.tese",
                    "*.tesc",
                    "*.mesh",
                    "*.task",
                    "*.rgen",
                    "*.rint",
                    "*.rmiss",
                    "*.rahit",
                    "*.rchit",
                    "*.rcall",
                },
                command = "set ft=glsl",
            })
        end,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            local npairs = require "nvim-autopairs"

            npairs.setup {
                check_ts = true,
                ts_config = {
                    lua = { "string", "source" },
                    javascript = { "string", "template_string" },
                    java = false,
                },
                disable_filetype = { "TelescopePrompt", "spectre_panel" },
                fast_wrap = {
                    map = "<M-e>",
                    chars = { "{", "[", "(", '"', "'" },
                    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
                    offset = 0, -- Offset from pattern match
                    end_key = "$",
                    keys = "qwertyuiopzxcvbnmasdfghjkl",
                    check_comma = true,
                    highlight = "PmenuSel",
                    highlight_grey = "LineNr",
                },
            }

            local cmp_autopairs = require "nvim-autopairs.completion.cmp"
            local cmp = require "cmp"
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            -- #aabbcc
            local colorizer = require "colorizer"
            colorizer.setup({ "*", "!cpp", "!c", "!glsl" }, {
                RGB = true, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                names = false, -- "Name" codes like Blue
                RRGGBBAA = false, -- #RRGGBBAA hex codes
                rgb_fn = false, -- CSS rgb() and rgba() functions
                hsl_fn = false, -- CSS hsl() and hsla() functions
                css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn

                -- Available modes: foreground, background
                mode = "background", -- Set the display mode.
            })
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        config = function()
            local toggle_term = require "toggleterm"

            toggle_term.setup {
                size = 115,
                open_mapping = [[<c-t>]],
                hide_numbers = true,
                shade_filetypes = {},
                shade_terminals = true,
                shading_factor = 2,
                start_in_insert = true,
                insert_mappings = true,
                persist_size = true,
                direction = "vertical",
                close_on_exit = true,
                shell = vim.o.shell,
                float_opts = {
                    border = "single",
                    winblend = 0,
                    highlights = {
                        border = "Normal",
                        background = "Normal",
                    },
                },
            }

            function _G.set_terminal_keymaps()
                local opts = { noremap = true }
                vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
                vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
                vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
                vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
                vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
                vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
            end

            vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"
            vim.cmd "autocmd! TermOpen term://* set signcolumn=no "

            local Terminal = require("toggleterm.terminal").Terminal
            local lazygit = Terminal:new { cmd = "lazygit", hidden = true }

            function _LAZYGIT_TOGGLE()
                lazygit:toggle()
            end

            local node = Terminal:new { cmd = "node", hidden = true }

            function _NODE_TOGGLE()
                node:toggle()
            end

            local ncdu = Terminal:new { cmd = "ncdu", hidden = true }

            function _NCDU_TOGGLE()
                ncdu:toggle()
            end

            local htop = Terminal:new { cmd = "htop", hidden = true }

            function _HTOP_TOGGLE()
                htop:toggle()
            end

            local python = Terminal:new { cmd = "python", hidden = true }

            function _PYTHON_TOGGLE()
                python:toggle()
            end
        end,
    },
    {
        "ahmedkhalf/project.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            local project = require "project_nvim"

            project.setup {
                active = true,
                on_config_done = nil,
                manual_mode = false,
                detection_methods = { "pattern" },
                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
                show_hidden = false,
                silent_chdir = true,
                ignore_lsp = {},
                datapath = vim.fn.stdpath "data",
            }

            require("telescope").load_extension "projects"
        end,
    },
    {
        "easymotion/vim-easymotion",
    },
    {
        "kyazdani42/nvim-tree.lua",
        config = function()
            local nvim_tree = require "nvim-tree"

            nvim_tree.setup {
                auto_reload_on_write = false,
                disable_netrw = false,
                hijack_cursor = false,
                hijack_netrw = true,
                hijack_unnamed_buffer_when_opening = false,
                sort_by = "name",
                root_dirs = {},
                prefer_startup_root = false,
                sync_root_with_cwd = true,
                reload_on_bufenter = false,
                respect_buf_cwd = false,
                on_attach = "default",
                select_prompts = false,
                view = {
                    adaptive_size = false,
                    centralize_selection = true,
                    width = 30,
                    side = "left",
                    preserve_window_proportions = false,
                    number = false,
                    relativenumber = false,
                    signcolumn = "yes",
                    float = {
                        enable = false,
                        quit_on_focus_loss = true,
                        open_win_config = {
                            relative = "editor",
                            border = "rounded",
                            width = 30,
                            height = 30,
                            row = 1,
                            col = 1,
                        },
                    },
                },
                renderer = {
                    add_trailing = false,
                    group_empty = false,
                    highlight_git = true,
                    full_name = false,
                    highlight_opened_files = "none",
                    root_folder_label = ":t",
                    indent_width = 2,
                    indent_markers = {
                        enable = false,
                        inline_arrows = true,
                        icons = {
                            corner = "└",
                            edge = "│",
                            item = "│",
                            none = " ",
                        },
                    },
                    icons = {
                        webdev_colors = true,
                        git_placement = "before",
                        padding = " ",
                        symlink_arrow = " ➛ ",
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                            git = false,
                        },
                        glyphs = {
                            default = "",
                            symlink = "",
                            git = {
                                unstaged = "",
                                staged = "S",
                                unmerged = "",
                                renamed = "➜",
                                deleted = "",
                                untracked = "U",
                                ignored = "◌",
                            },
                            folder = {
                                arrow_closed = "",
                                arrow_open = "",
                                default = "",
                                open = "",
                                empty = "",
                                empty_open = "",
                                symlink = "",
                            },
                        },
                    },
                    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
                    symlink_destination = true,
                },
                hijack_directories = {
                    enable = false,
                    auto_open = true,
                },
                update_focused_file = {
                    enable = true,
                    debounce_delay = 15,
                    update_root = true,
                    ignore_list = {},
                },
                diagnostics = {
                    enable = false,
                    show_on_dirs = false,
                    show_on_open_dirs = true,
                    debounce_delay = 50,
                    severity = {
                        min = vim.diagnostic.severity.HINT,
                        max = vim.diagnostic.severity.ERROR,
                    },
                },
                filters = {
                    dotfiles = false,
                    git_clean = false,
                    no_buffer = false,
                    custom = { "node_modules", "\\.cache" },
                    exclude = {},
                },
                filesystem_watchers = {
                    enable = true,
                    debounce_delay = 50,
                    ignore_dirs = {},
                },
                git = {
                    enable = true,
                    ignore = false,
                    show_on_dirs = true,
                    show_on_open_dirs = true,
                    timeout = 200,
                },
                actions = {
                    use_system_clipboard = true,
                    change_dir = {
                        enable = true,
                        global = false,
                        restrict_above_cwd = false,
                    },
                    expand_all = {
                        max_folder_discovery = 300,
                        exclude = {},
                    },
                    file_popup = {
                        open_win_config = {
                            col = 1,
                            row = 1,
                            relative = "cursor",
                            border = "shadow",
                            style = "minimal",
                        },
                    },
                    open_file = {
                        quit_on_open = false,
                        resize_window = false,
                        window_picker = {
                            enable = true,
                            picker = "default",
                            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                            exclude = {
                                filetype = { "notify", "lazy", "qf", "diff", "fugitive", "fugitiveblame" },
                                buftype = { "nofile", "terminal", "help" },
                            },
                        },
                    },
                    remove_file = {
                        close_window = true,
                    },
                },
                trash = {
                    cmd = "trash",
                    require_confirm = true,
                },
                live_filter = {
                    prefix = "[FILTER]: ",
                    always_show_folders = true,
                },
                tab = {
                    sync = {
                        open = false,
                        close = false,
                        ignore = {},
                    },
                },
                notify = {
                    threshold = vim.log.levels.INFO,
                },
                log = {
                    enable = false,
                    truncate = false,
                    types = {
                        all = false,
                        config = false,
                        copy_paste = false,
                        dev = false,
                        diagnostics = false,
                        git = false,
                        profile = false,
                        watcher = false,
                    },
                },
                system_open = {
                    cmd = nil,
                    args = {},
                },
            }
            -- Implicitly update nvim-tree when project module is active
            -- if lvim.builtin.project.active then
            --     nvim_tree.setup.respect_buf_cwd = true
            --     nvim_tree.setup.update_cwd = true
            --     nvim_tree.setup.update_focused_file.enable = true
            --     nvim_tree.setup.update_focused_file.update_cwd = true
            -- end
        end,
    },
    -- {
    -- },

    -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
    -- init.lua. If you want these files, they are in the repository, so you can just download them and
    -- place them in the correct locations.

    -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
    --
    --  Here are some example plugins that I've included in the Kickstart repository.
    --  Uncomment any of the lines below to enable them (you will need to restart nvim).
    --
    -- require 'kickstart.plugins.debug',
    -- require 'kickstart.plugins.indent_line',
    -- require 'kickstart.plugins.lint',

    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    This is the easiest way to modularize your config.
    --
    --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
    --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
    -- { import = 'custom.plugins' },
}, {
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
