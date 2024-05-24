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
-- Dumbs a table for debugging
local function dump(o)
    if type(o) == "table" then
        local s = "{ "
        for k, v in pairs(o) do
            if type(k) ~= "number" then
                k = '"' .. k .. '"'
            end
            s = s .. "[" .. k .. "] = " .. dump(v) .. ","
        end
        return s .. "} "
    else
        return tostring(o)
    end
end

local function get_color(highlight, layer)
    return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(highlight)), layer or "fg", "gui")
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
vim.opt.showmode = false
vim.opt.ruler = false
vim.opt.cmdheight = 1

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true
vim.opt.syntax = "ON"

-- Save undo history
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.writebackup = false

-- Set term gui colors (most terminals support this)
vim.opt.termguicolors = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = true

-- Display lines as one long line
vim.opt.wrap = false

-- Pop up menu height
vim.opt.pumheight = 5

-- Decrease update time
vim.opt.updatetime = 500

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
vim.opt.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Removed semicolon
vim.opt.cinkeys = "0{,0},0),0],0#,!^F,o,O,e"

-- GUI settings
--vim.opt.guifont = "NotoSansM Nerd Font:h12"
--vim.opt.foldcolumn = "2"
-- NOTE: This will be updated dynamically
vim.opt.signcolumn = "yes:1"

vim.cmd "set linespace=3"
vim.g.neovide_refresh_rate = 165
vim.g.neovide_refresh_rate_idle = 165
vim.g.neovide_no_idle = true
vim.g.neovide_confirm_quit = true
vim.g.neovide_fullscreen = false
vim.g.neovide_frame = false

-- vim.g.neovide_vsync = false
vim.g.neovide_transparency = 1.0
vim.g.neovide_floating_opacity = 0.4
vim.g.neovide_floating_blur = true
vim.g.neovide_remember_window_size = true
vim.g.neovide_scale_factor = 1.20

vim.g.neovide_cursor_animation_length = 0.045
vim.g.neovide_scroll_animation_length = 0.25
vim.g.neovide_cursor_animate_command_line = true
-- vim.cmd [[ set guicursor=i:ver25-blinkwait10-blinkon500-blinkoff500 ]]
-- vim.g.neovide_cursor_smooth_blink = false
vim.cmd [[set mousescroll=ver:5,hor:5]]
vim.g.neovide_hide_mouse_when_typing = true
-- vim.g.neovide_scroll_animation_far_lines = 9999

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- vim.cmd [[
-- inoremap <C-h> <Left>
-- inoremap <C-j> <Down>
-- inoremap <C-k> <Up>
-- inoremap <C-l> <Right>
-- cnoremap <C-h> <Left>
-- cnoremap <C-j> <Down>
-- cnoremap <C-k> <Up>
-- cnoremap <C-l> <Right>
-- ]]

local which_key_mappins = {
    ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
    ["<leader>l"] = { name = "[L]SP", _ = "which_key_ignore" },
    ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
    -- ["<leader>t"] = { name = "[T]erminal", _ = "which_key_ignore" },
    ["<leader>T"] = { name = "[T]heme", _ = "which_key_ignore" },
}

-- Change font size in neovide
local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    vim.api.nvim_input "<C-l>"
end

vim.keymap.set("n", "<c-+>", function()
    change_scale_factor(1.10)
end)
vim.keymap.set("n", "<c-->", function()
    change_scale_factor(1 / 1.10)
end)
vim.keymap.set("n", "<C-ScrollWheelUp>", function()
    change_scale_factor(1.10)
end)
vim.keymap.set("n", "<C-ScrollWheelDown>", function()
    change_scale_factor(1 / 1.10)
end)

-- Navigation in insert mode
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-h>", "<Left>")

-- Scrolling
vim.cmd [[
     nnoremap n nzzzv
     nnoremap N Nzzzv
 ]]

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center cursor after moving down half-page" })

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
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "No Highlight" })

-- Comments
vim.keymap.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise()<CR>", { desc = "Comment line" })
vim.keymap.set("v", "<leader>/", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Comment lines" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>lk", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "<leader>lj", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostic error messages" })
vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })

--  See `:help wincmd` for a list of all window commands
-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize -2<CR>")

vim.keymap.set("n", "<S-l>", "<cmd>silent!bnext<CR>")
vim.keymap.set("n", "<S-h>", "<cmd>silent!bprev<CR>")

-- vim.keymap.set("n", "<A-l>", "<cmd>silent!BufferLineMoveNext<CR>")
-- vim.keymap.set("n", "<A-h>", "<cmd>silent!BufferLineMovePrev<CR>")

-- Window spilt (vsplit)
vim.keymap.set("n", "<leader>v", "<cmd>silent!vsplit<CR>", { desc = "Vertical Split" })
-- vim.keymap.set("n", "<leader>", "<cmd>silent!split<CR>", { desc = "Horizontal Split" })

-- Easymotion
-- vim.keymap.set("n", "<leader>a", "<Plug>(easymotion-overwin-f2)", { desc = "Easymotion" })

-- Package control
vim.keymap.set("n", "<leader>L", "<cmd>silent!Lazy show<CR>", { desc = "Packages" })

-- Nvim tree
vim.keymap.set("n", "<leader>e", "<cmd>silent!NvimTreeToggle<CR>", { desc = "Explorer" })

-- TODO: Linux
-- Open system explorer
if vim.fn.has "win32" == 1 then
    vim.keymap.set("n", "<leader>E", "<cmd>silent!!explorer .<CR>", { desc = "System explorer" })
end

local function keymaps_nvim_tree(api, opts)
    vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
    vim.keymap.set("n", "o", api.node.open.edit, opts "Open")
    vim.keymap.set("n", "<CR>", api.node.open.edit, opts "Open")
    vim.keymap.set("n", "v", api.node.open.vertical, opts "Open: Vertical Split")
    vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close Directory")
    vim.keymap.set("n", "C", api.tree.change_root_to_node, opts "CD")
end

-- Toggle treesitter
vim.keymap.set(
    "n",
    "<leader>t",
    "<cmd>silent!TSBufToggle indent | TSBufToggle incremental_selection | TSBufToggle highlight<CR>",
    { desc = "Treesitter toggle" }
)

-- Buffers
vim.keymap.set("n", "<leader>w", "<cmd>w!<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>c", "<cmd>silent!bd!<CR>", { desc = "Close Buffer" })

-- Telescope
vim.keymap.set("n", "<C-f>", "<cmd>silent!Telescope current_buffer_fuzzy_find<CR>", { desc = "Treesitter symbols" })
vim.keymap.set("n", "<C-p>", "<cmd>silent!Telescope git_files<CR>", { desc = "Files" })
vim.keymap.set("n", "<leader>f", "<cmd>silent!Telescope find_files<CR>", { desc = "Files" })
vim.keymap.set("n", "<leader>r", "<cmd>silent!Telescope resume<CR>", { desc = "Resume" })
vim.keymap.set("n", "<leader>R", "<cmd>silent!Telescope oldfiles<CR>", { desc = "Recent files" })

vim.keymap.set("n", "<leader>st", "<cmd>silent!Telescope live_grep<CR>", { desc = "Search text" })

vim.keymap.set("n", "<leader>sw", "<cmd>silent!Telescope grep_string<CR>", { desc = "Search string" })

vim.keymap.set("n", "<leader>P", "<cmd>silent!Telescope projects<CR>", { desc = "Projects" })
vim.keymap.set("n", "<leader><leader>", "<cmd>silent!Telescope buffers<CR>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>S", "<cmd>silent!Telescope spell_suggest<CR>", { desc = "Spell suggestions" })
vim.keymap.set("n", "<leader>j", "<cmd>silent!Telescope jumplist<CR>", { desc = "Jumplist" })
vim.keymap.set("n", "<leader>k", "<cmd>silent!Telescope keymaps<CR>", { desc = "Keymaps" })
vim.keymap.set("n", "<leader>C", "<cmd>silent!Telescope command_history<CR>", { desc = "Command history" })

vim.keymap.set("n", "<leader>Tc", "<cmd>silent!Telescope colorscheme<CR>", { desc = "Colorschemes" })
vim.keymap.set("n", "<leader>Th", "<cmd>silent!Telescope highlights<CR>", { desc = "Highlights" })

-- Git
vim.keymap.set("n", "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<CR>", { desc = "Next hunk" })
vim.keymap.set("n", "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<CR>", { desc = "Prev hunk" })
vim.keymap.set("n", "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<CR>", { desc = "Blame" })
vim.keymap.set("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", { desc = "Reset Buffer" })
vim.keymap.set("n", "<leader>gS", "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", { desc = "Stage Hunk" })
vim.keymap.set("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>", { desc = "Undo stage Hunk" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<CR>", { desc = "Diff" })

vim.keymap.set("n", "<leader>gf", "<cmd>silent!Telescope git_files<CR>", { desc = "Files" })
vim.keymap.set("n", "<leader>gb", "<cmd>silent!Telescope git_branches<CR>", { desc = "Branches" })
vim.keymap.set("n", "<leader>gc", "<cmd>silent!Telescope git_commits<CR>", { desc = "Commits" })
vim.keymap.set("n", "<leader>gs", "<cmd>silent!Telescope git_status<CR>", { desc = "Status" })
vim.keymap.set("n", "<leader>gC", "<cmd>silent!Telescope git_bcommits<CR>", { desc = "Checkout commit(for current file)" })

vim.keymap.set("n", "<leader>_", function()
    require("telescope.builtin").find_files { cwd = vim.fn.stdpath "config" }
end, { desc = "Config Files" })

-- C/C++ Project specific keybinding for building

-- TODO: DRY
vim.keymap.set("n", "<c-s-b>", function()
    local cmd = ".\\build.bat vs2022 debug run raddbg"
    _MS_BUILD_TOGGLE(cmd)
end)

vim.keymap.set("n", "<c-s-d>", function()
    if vim.fn.has "win32" == 0 then
        error "Only Win32 supported"
        return
    end

    local root_patterns = { ".git", ".clang-format", "build.bat", "build.sh" }
    local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])

    -- Build file not found
    if root_dir == nil then
        error "Build file not found"
        return
    end

    local paths = vim.split(vim.fn.glob(root_dir .. "\\*.sln"), "\n")

    -- NOTE: This is only working with one sln file
    for _, path in pairs(paths) do
        -- Just start the first sln
        vim.cmd("silent!!start " .. path)
    end
end)

-- LSP
local function keymaps_lsp(event)
    local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
    end
    map("gd", require("telescope.builtin").lsp_definitions, "Goto definition")
    map("gr", require("telescope.builtin").lsp_references, "Goto references")
    map("gI", require("telescope.builtin").lsp_implementations, "Goto implementation")
    map("<leader>ld", require("telescope.builtin").lsp_type_definitions, "Type definition")
    map("<leader>ls", require("telescope.builtin").lsp_document_symbols, "Document symbols")
    map("<leader>lS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace symbols")
    map("<leader>la", vim.lsp.buf.code_action, "Action")

    map("K", vim.lsp.buf.hover, "Hover hocumentation")
    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map("gD", vim.lsp.buf.declaration, "Goto declaration")
    map("<C-i>", vim.lsp.buf.signature_help, "Signatre help")

    -- vim.keymap.set("n", "<leader>lr", function()
    --     return ":IncRename " -- .. vim.fn.expand "<cword>"
    -- end, { expr = true, desc = { "Rename" } })
end

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- autocmd BufWinEnter,FocusGained,BufWritePost * :lua CheckGitFileStatus()
vim.cmd [[
      augroup _general_settings
          autocmd!
          autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
          autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({timeout = 200})
          autocmd BufWinEnter * :set formatoptions-=cro
          autocmd FileType qf set nobuflisted
          autocmd BufEnter,WinResized,TermOpen,TermClose,TermLeave,TermEnter * lua AdjustSignColumns()
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

      augroup _glsl
         autocmd!
         autocmd BufNewFile,BufReadPost,BufWinEnter,BufNewFile *.vert,*.frag,*.geom,*.comp :set ft=glsl
         autocmd BufWinEnter,BufEnter,TextChanged,InsertLeavePre * lua if vim.bo.filetype == 'glsl' then DiagnosticsGlslWatch() end
         autocmd BufWinEnter,BufEnter * lua if vim.bo.filetype ~= 'glsl' then DiagnosticsGlslClear() end
      augroup end

      augroup _colorizer
         autocmd!
         " PERF: The excluded files are defined on two separate place
         autocmd TextChanged,TextChangedI *[^.cpp,.c,.glsl] ReloadColorizer
      augroup end

      function! ReloadColorizer()
         call ColorizerToggle()
         call ColorizerToggle()
      endfunction
  ]]

function AdjustSignColumns()
    local maybe_sign_column = true
    local window_width = vim.api.nvim_win_get_width(vim.api.nvim_get_current_win())

    -- Dont use signcolumn if the main window is small enough
    if window_width < 100 then
        maybe_sign_column = false
    end

    local non_floating_wins = vim.fn.filter(vim.api.nvim_list_wins(), function(k, v)
        -- Dont use signcolumn if nvim-tree is open
        local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(v))
        if bufname:match "NvimTree_" ~= nil then
            maybe_sign_column = false
        end

        return vim.api.nvim_win_get_config(v).relative == ""
    end)

    for _, window in ipairs(non_floating_wins) do
        local x_pos = vim.api.nvim_win_get_position(window)[2]
        if maybe_sign_column and x_pos == 0 then
            vim.api.nvim_set_option_value("signcolumn", "yes:5", { scope = "local", win = window })
        else
            vim.api.nvim_set_option_value("signcolumn", "yes:1", { scope = "local", win = window })
        end
    end
end

local glslang_namespace = vim.api.nvim_create_namespace "glslangValidator"
local channel_id = nil

function DiagnosticsGlslClear()
    vim.diagnostic.reset(glslang_namespace, 0)
end

function DiagnosticsGlslWatch()
    local glslangValidator_path = "glslangValidator.exe"
    local shader_stage = vim.fn.expand "%:e" -- NOTE: File format must be the same as the shader stage
    local buffer_content = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    local cmd = string.format("%s --stdin -S %s ", glslangValidator_path, shader_stage)

    if channel_id then
        vim.fn.jobstop(channel_id)
    end

    local parse_diagnostic_successful = false
    local opts = {}

    channel_id = vim.fn.jobstart(cmd, {
        stdin = "pipe",
        on_stdout = function(_, data)
            if #data[1] > 0 and #data[2] > 0 then
                local delimiter = ":"
                local parts = {}

                -- Iterate over each part of the string separated by the delimiter
                for part in string.gmatch(data[2], "[^" .. delimiter .. "]+") do
                    table.insert(parts, part)
                end

                --  Try parse the string
                parse_diagnostic_successful, _ = pcall(function()
                    -- Since glslangValidator always outputs column 0 just mark the whole line as an error
                    local valdidator_severity = parts[1]
                    local line_number = tonumber(parts[3]) - 1
                    local line_content = vim.api.nvim_buf_get_lines(0, line_number, line_number + 1, false)[1]

                    local start_col = (line_content:find "%S" - 1 or #line_content + 1)
                    local end_col = #line_content - ((line_content:reverse():find "%S" or #line_content) - 1)

                    local msg = parts[5]:sub(1, -2) -- Remove wierd newline character
                    msg = msg:gsub("^%s*(.-)%s*$", "%1") -- Trim whitespaces
                    msg = string.format(" glslangValidator: %s ", msg) -- Add surrounding spaces

                    local severity_conversion_table = {
                        ERROR = vim.diagnostic.severity.ERROR,
                        WARNING = vim.diagnostic.severity.WARN,
                        INFO = vim.diagnostic.severity.INFO,
                        NOTE = vim.diagnostic.severity.HINT,
                    }

                    opts = {
                        lnum = line_number,
                        col = start_col,
                        message = msg,
                        severity = severity_conversion_table[valdidator_severity] or vim.diagnostic.severity.ERROR,
                        end_lnum = line_number,
                        end_col = end_col,
                    }
                end)
            end
        end,
        on_exit = function(_, exit_code)
            if exit_code == 0 or exit_code == 1 then
                vim.diagnostic.reset(glslang_namespace, 0)
            end

            if parse_diagnostic_successful and vim.bo.filetype == "glsl" then
                vim.diagnostic.set(glslang_namespace, 0, { opts })
            end
        end,
    })

    vim.fn.chansend(channel_id, buffer_content)
    vim.fn.chanclose(channel_id, "stdin")
end

-- Auto close nvim-tree when its the last buffer
vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
        local tree_wins = {}
        local floating_wins = {}
        local wins = vim.api.nvim_list_wins()
        for _, w in ipairs(wins) do
            local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
            if bufname:match "NvimTree_" ~= nil then
                table.insert(tree_wins, w)
            end
            if vim.api.nvim_win_get_config(w).relative ~= "" then
                table.insert(floating_wins, w)
            end
        end
        if 1 == #wins - #floating_wins - #tree_wins then
            -- Should quit, so we close all invalid windows.
            for _, w in ipairs(tree_wins) do
                vim.api.nvim_win_close(w, true)
            end
        end
    end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
end
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
                interval = 2000,
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
                popup_appings = {
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
            -- existing key chains
            which_key.register(which_key_mappins)
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
        },
        {
            "nvim-tree/nvim-web-devicons",
            enabled = vim.g.have_nerd_font,
            lazy = true,
            opts = {
                override_by_filename = {
                    [".clang-format"] = {
                        icon = "󰉶",
                        color = "#f04187",
                        name = "nf-fa-dragon",
                    },
                },
                override_by_extension = {
                    ["exe"] = {
                        icon = "",
                        color = "#71c404",
                        name = "nf-dev-terminal",
                    },
                    ["bash"] = {
                        icon = "",
                        color = "#71c404",
                        name = "nf-dev-terminal",
                    },
                    ["sh"] = {
                        icon = "",
                        color = "#71c404",
                        name = "nf-dev-terminal",
                    },
                    ["bat"] = {
                        icon = "",
                        color = "#71c404",
                        name = "nf-dev-terminal",
                    },
                    ["sln"] = {
                        icon = "󰘐",
                        color = "#B75FF4",
                        name = "nf-md-microsoft_visual_studio",
                    },
                    ["vcxproj"] = {
                        icon = "󰘐",
                        color = "#B75FF4",
                        name = "nf-md-microsoft_visual_studio",
                    },
                    ["user"] = {
                        icon = "󰘐",
                        color = "#B75FF4",
                        name = "nf-md-microsoft_visual_studio",
                    },
                    ["pdb"] = {
                        icon = "󰘐",
                        color = "#B75FF4",
                        name = "nf-md-microsoft_visual_studio",
                    },
                    ["vert"] = {
                        icon = "󰘷",
                        color = "#3fd994",
                        name = "nf-md-drawing_box",
                    },
                    ["frag"] = {
                        icon = "󰘷",
                        color = "#3fd994",
                        name = "nf-md-drawing_box",
                    },
                    ["comp"] = {
                        icon = "󰘷",
                        color = "#3fd994",
                        name = "nf-md-drawing_box",
                    },
                    ["geom"] = {
                        icon = "󰘷",
                        color = "#3fd994",
                        name = "nf-md-drawing_box",
                    },
                },
            },
            -- HACK: Latest release give errors on windows
            -- commit = "5efb8bd",
        },
        -- FIXME: Add personal config
        config = function()
            -- [[ Configure Telescope ]]
            -- See `:help telescope` and `:help telescope.setup()`

            local actions = require "telescope.actions"
            -- Import the necessary modules

            local pickers = require "telescope.pickers"

            require("telescope").setup {
                -- You can put your default mappings / updates / etc. in here
                --  All the info you're looking for is in `:help telescope.setup()`

                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                    prompt_prefix = "  ",
                    selection_caret = "  ",
                    -- selection_caret = "",
                    -- selection_strategy = "reset",
                    -- sorting_strategy = "ascending",
                    -- layout_strategy = "horizontal",
                    -- use_less = true,
                    -- Customize layout of the picker window
                    -- layout_config = {
                    --     preview_title = false,
                    --     results_title = false,
                    --     border = false, -- You may also want to disable the border for a cleaner look
                    -- },
                    dynamic_preview_title = false,
                    results_title = false,
                    prompt_title = false,
                    preview_title = false,
                    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                    mappings = {
                        i = {
                            ["<C-n>"] = actions.cycle_history_next,
                            ["<C-p>"] = actions.cycle_history_prev,

                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,

                            ["<C-c>"] = actions.close,

                            ["<Tab>"] = actions.move_selection_next,
                            ["<S-Tab>"] = actions.move_selection_previous,

                            ["<CR>"] = actions.select_default,
                            ["<C-x>"] = actions.select_horizontal,
                            ["<C-v>"] = actions.select_vertical,
                            ["<C-t>"] = actions.select_tab,

                            ["<C-u>"] = actions.preview_scrolling_up,
                            ["<C-d>"] = actions.preview_scrolling_down,

                            ["<PageUp>"] = actions.results_scrolling_up,
                            ["<PageDown>"] = actions.results_scrolling_down,

                            --["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                            --["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<C-l>"] = actions.complete_tag,
                            ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
                        },

                        n = {
                            ["<esc>"] = actions.close,
                            ["<CR>"] = actions.select_default,
                            ["<C-x>"] = actions.select_horizontal,
                            ["<C-v>"] = actions.select_vertical,
                            ["<C-t>"] = actions.select_tab,

                            --["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                            --["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                            ["j"] = actions.move_selection_next,
                            ["k"] = actions.move_selection_previous,
                            ["H"] = actions.move_to_top,
                            ["M"] = actions.move_to_middle,
                            ["L"] = actions.move_to_bottom,

                            ["<Down>"] = actions.move_selection_next,
                            ["<Up>"] = actions.move_selection_previous,
                            ["gg"] = actions.move_to_top,
                            ["G"] = actions.move_to_bottom,

                            ["<C-u>"] = actions.preview_scrolling_up,
                            ["<C-d>"] = actions.preview_scrolling_down,

                            ["<PageUp>"] = actions.results_scrolling_up,
                            ["<PageDown>"] = actions.results_scrolling_down,

                            ["?"] = actions.which_key,
                        },
                    },
                },
                pickers = {
                    colorscheme = {
                        enable_preview = true,
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
            }

            -- Enable Telescope extensions if they are installed
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")
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
                    -- Map lsp keybindings
                    keymaps_lsp(event)

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

                    -- Turn of sematic tokens
                    -- if vim.g.using_base46 then
                    --     client.server_capabilities.semanticTokensProvider = nil
                    -- end
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
        enabled = true,
        lazy = false,
        -- TODO: Move this out to other mappings
        keys = {
            {
                "<leader>lf",
                function()
                    require("conform").format { async = true, lsp_fallback = true }
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        opts = {
            notify_on_error = false,
            format_on_save = false,
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
                completion = {
                    completeopt = "menu,menuone,noinsert,noselect",
                },
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
                    -- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ["<C-e>"] = cmp.mapping {
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    },
                    -- Accept currently selected item. If none selected, `select` first item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ["<CR>"] = cmp.mapping.confirm { select = true },
                    ["<C-Space>"] = cmp.mapping(function(fallback)
                        if luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            vim.fn.feedkeys(" ", "i")
                        end
                    end, {
                        "i",
                        "s",
                    }),
                    -- ["<S-Space>"] = cmp.mapping(function(fallback)
                    --     if luasnip.jumpable(-1) then
                    --         luasnip.jump(-1)
                    --     else
                    --         vim.fn.feedkeys(" ", "i")
                    --     end
                    -- end, {
                    --     "i",
                    --     "s",
                    -- }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif check_backspace then
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

                        local function clamp(str, min_length, max_length)
                            if str == nil then
                                return
                            end

                            local current_length = #str

                            if current_length > max_length then
                                -- Trim the string if it's longer than the desired max_length and add "..."
                                return string.sub(str, 1, max_length - 3) .. "..."
                            elseif current_length < min_length then
                                -- Add whitespaces to the end if it's shorter than the desired min_length
                                return str .. string.rep(" ", min_length - current_length)
                            else
                                -- String length is within the desired range
                                return str
                            end
                        end

                        -- This concatonates the icons with the name of the item kind
                        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

                        vim_item.abbr = clamp(vim_item.abbr, 35, 35)
                        -- vim_item.abbr = vim_item.abbr .. "      " -- Add some padding
                        -- vim_item.menu = clamp(entry:get_completion_item().detail, 8, 12)
                        vim_item.menu = nil

                        return vim_item
                    end,
                },
                sources = {
                    { name = "path", keyword_length = 1 },
                    { name = "nvim_lsp", keyword_length = 1 },
                    { name = "luasnip", keyword_length = 2 },
                    { name = "buffer", max_item_count = 3, keyword_length = 1 },
                    { name = "nvim_lsp_signature_help", keyword_length = 1 },
                },
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                -- matching = {
                --     disallow_fuzzy_matching = true,
                --     disallow_fullfuzzy_matching = true,
                --     disallow_partial_fuzzy_matching = true,
                --     disallow_partial_matching = true,
                --     disallow_prefix_unmatching = false,
                --     disallow_symbol_nonprefix_matching = false,
                -- },
                experimental = {
                    ghost_text = {
                        -- hl_group = "LineNr",
                        hl_group = "Comment",
                    },
                },
            }
        end,
    },
    {
        "folke/trouble.nvim",
        -- branch = "dev",
        enabled = true,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        --     keys = {
        --         -- {
        --         --     "<leader>xx",
        --         --     "<cmd>Trouble diagnostics toggle<cr>",
        --         --     desc = "Diagnostics (Trouble)",
        --         -- },
        --         -- {
        --         --     "<leader>xX",
        --         --     "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        --         --     desc = "Buffer Diagnostics (Trouble)",
        --         -- },
        --         {
        --             "<leader>lt",
        --             "<cmd>Trouble symbols toggle<cr>",
        --             desc = "Symbols (Trouble)",
        --         },
        --         {
        --             "<leader>lD",
        --             "<cmd>Trouble lsp toggle focus=false<cr>",
        --             desc = "LSP Definitions / references / ... (Trouble)",
        --         },
        --         -- {
        --         --     "<leader>xL",
        --         --     "<cmd>Trouble loclist toggle<cr>",
        --         --     desc = "Location List (Trouble)",
        --         -- },
        --         -- {
        --         --     "<leader>xQ",
        --         --     "<cmd>Trouble qflist toggle<cr>",
        --         --     desc = "Quickfix List (Trouble)",
        --         -- },
        --     },
        --     opts = {
        --         modes = {
        --             symbols = {
        --                 desc = "document symbols",
        --                 mode = "lsp_document_symbols",
        --                 focus = false,
        --                 win = { position = "left", size = 30 },
        --             },
        --         },
        --         icons = {
        --             indent = {
        --                 top = " ",
        --                 middle = " ",
        --                 last = " ",
        --                 -- last          = "-╴",
        --                 -- last       = "╰╴", -- rounded
        --                 fold_open = "",
        --                 fold_closed = "",
        --                 ws = "  ",
        --             },
        --             default = "",
        --             open = "",
        --             kinds = {
        --                 Array = "",
        --                 Boolean = "",
        --                 Class = "",
        --                 Constant = "",
        --                 Constructor = "",
        --                 Enum = "",
        --                 EnumMember = "",
        --                 Event = "",
        --                 Field = "",
        --                 File = "",
        --                 Function = "",
        --                 Interface = "",
        --                 Key = "",
        --                 Method = "",
        --                 Module = "",
        --                 Namespace = "",
        --                 Null = "",
        --                 Number = "󰎠",
        --                 Object = "",
        --                 Operator = "",
        --                 Package = "",
        --                 Property = "",
        --                 String = "",
        --                 Struct = "",
        --                 TypeParameter = "",
        --                 Variable = "",
        --             },
        --         },
        --     },
    },
    {
        "LunarVim/Colorschemes",
        priority = 1000, -- Make sure to load this before all the other start plugins.
        enabled = true,
        -- init = function()
        --     vim.cmd.colorscheme "onedark"
        --
        --     local buffer_bg_color = get_color("BufferCurrent", "bg")
        --     local comment_color = get_color "Comment"
        --     local onedark_palette = require "onedark.palette"
        --
        --     vim.api.nvim_set_hl(0, "WinSeparator", { fg = buffer_bg_color, bg = buffer_bg_color })
        --
        --     vim.api.nvim_set_hl(0, "Type", { fg = onedark_palette.cyan, italic = false, bold = false })
        --     vim.api.nvim_set_hl(0, "@storageclass", { fg = onedark_palette.cyan, italic = false, bold = false })
        --     vim.api.nvim_set_hl(0, "Structure", { fg = onedark_palette.cyan, italic = false, bold = false })
        --     vim.api.nvim_set_hl(0, "Function", { fg = onedark_palette.blue, italic = false, bold = false })
        --     vim.api.nvim_set_hl(0, "@function.builtin", { fg = onedark_palette.cyan, italic = false, bold = false })
        --     vim.api.nvim_set_hl(0, "@method", { link = "Function" })
        --     vim.api.nvim_set_hl(0, "Keyword", { fg = onedark_palette.purple, italic = false, bold = false })
        --     vim.api.nvim_set_hl(0, "Conditional", { fg = onedark_palette.purple, italic = false, bold = false })
        --     vim.api.nvim_set_hl(0, "Constant", { fg = onedark_palette.orange, italic = false, bold = false })
        --     vim.api.nvim_set_hl(0, "Boolean", { fg = onedark_palette.orange, italic = false, bold = false })
        --
        --     vim.api.nvim_set_hl(0, "String", { fg = onedark_palette.green, italic = false, bold = false })
        --     vim.api.nvim_set_hl(0, "@string.escape", { fg = onedark_palette.cyan, italic = false, bold = false })
        --     vim.api.nvim_set_hl(0, "@string.special", { fg = onedark_palette.cyan, italic = false, bold = false })
        --
        --     vim.api.nvim_set_hl(0, "@field", { fg = onedark_palette.red, italic = false, bold = false })
        --     vim.api.nvim_set_hl(0, "@property", { fg = onedark_palette.red, italic = false, bold = false })
        --     vim.api.nvim_set_hl(0, "@lsp.type.property", { fg = onedark_palette.red, italic = false, bold = false })
        --
        --
        --     vim.api.nvim_set_hl(0, "@operator", { fg = onedark_palette.purple, italic = false, bold = false })
        --
        --     -- vim.api.nvim_set_hl(0, "@parameter", { fg = onedark_palette.orange, italic = true, bold = false })
        --     -- vim.api.nvim_set_hl(0, "@lsp.type.parameter", { fg = onedark_palette.orange, italic = true, bold = false })
        --
        --     vim.api.nvim_set_hl(0, "CmpItemKind", { bold = true })
        --     vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = onedark_palette.alt_fg, italic = false, bold = false })
        --     vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = onedark_palette.alt_fg, italic = false, bold = false })
        --     vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = onedark_palette.fg, italic = false, bold = false })
        --     vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = onedark_palette.fg, italic = false, bold = false })
        -- end,
    },
    {
        "AxelGard/oneokai.nvim",
        enabled = false,
        config = function()
            require("oneokai").load()
        end,
    },
    {
        -- https://github.com/septag/vscode-vax-dark-theme/blob/master/themes/Visual%20Assist%20Dark-color-theme.json
        priority = 1000,
        enabled = false,
        "bartekprtc/gruv-vsassist.nvim",
        init = function()
            vim.cmd.colorscheme "gruv-vsassist"

            local buffer_bg_color = get_color("BufferCurrent", "bg")
            vim.api.nvim_set_hl(0, "WinSeparator", { fg = buffer_bg_color, bg = buffer_bg_color })

            vim.api.nvim_set_hl(0, "CmpItemKind", { bold = true })
            vim.api.nvim_set_hl(0, "CmpItemAbbr", { link = "NvimTreeGitIgnored", italic = false })
            vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { link = "LineNr", italic = false, bold = false })
            vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecatedDefault", { link = "LineNr", italic = false, bold = false })
            -- vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "number", italic = false })
            vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { link = "NvimTreeNormal", italic = false, bold = true })
            vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "NvimTreeNormal", italic = false, bold = true })
        end,
    },
    {
        "NvChad/base46",
        commit = "b48abea",
        priority = 1000,
        enabled = true,
        init = function()
            vim.g.using_base46 = true
            vim.g.base46_cache = vim.fn.stdpath "config" .. "/nvcache/"

            -- vim.highlight.priorities.semantic_tokens = 95
            require("base46").load_all_highlights()

            local buffer_bg_color = get_color("Normal", "bg")
            vim.api.nvim_set_hl(0, "WinSeparator", { fg = buffer_bg_color, bg = buffer_bg_color })

            vim.api.nvim_set_hl(0, "Statusline", { link = "NvimTreeWinSeparator" })
            vim.api.nvim_set_hl(0, "StatusLineNC", { link = "NvimTreeWinSeparator" })
            vim.api.nvim_set_hl(0, "NvimTreeStatusLineNC", { link = "NvimTreeWinSeparator" })

            vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { link = "TelescopeBorder" })
            vim.api.nvim_set_hl(0, "TelescopePromptTitle", { link = "CursorLine" })

            vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "Visual" })
            vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "Visual" })
            vim.api.nvim_set_hl(0, "LspReferenceText", { link = "Visual" })

            local cyan = { link = "@string.escape" }

            vim.api.nvim_set_hl(0, "Variable", { link = "@text" })
            vim.api.nvim_set_hl(0, "@variable", { link = "@text" })
            vim.api.nvim_set_hl(0, "@variable.builtin", { link = "@keyword" })
            vim.api.nvim_set_hl(0, "@lsp.type.variable", { link = "@text" })
            vim.api.nvim_set_hl(0, "@variable.parameter", { fg = get_color "@constant.builtin", italic = true })
            vim.api.nvim_set_hl(0, "@lsp.type.parameter", { link = "@text" })
            vim.api.nvim_set_hl(0, "@lsp.typemod.parameter.declaration", { link = "@constant.builtin" })

            vim.api.nvim_set_hl(0, "Type", cyan)
            vim.api.nvim_set_hl(0, "StorageClass", cyan)
            vim.api.nvim_set_hl(0, "@type.builtin", cyan)
            vim.api.nvim_set_hl(0, "@lsp.type.class", cyan)
            vim.api.nvim_set_hl(0, "@lsp.type", cyan)
            vim.api.nvim_set_hl(0, "@lsp.typemod.variable.readonly", { link = "@variable" })
            vim.api.nvim_set_hl(0, "@lsp.type.type", cyan)

            vim.api.nvim_set_hl(0, "@keyword.operator", { link = "@keyword.conditional" })
            vim.api.nvim_set_hl(0, "@lsp.type.operator", { link = "@keyword.operator" })
            vim.api.nvim_set_hl(0, "@operator", { link = "@keyword.operator" })
            vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "@punctuation.delimiter" })

            vim.api.nvim_set_hl(0, "Constant", { link = "@lsp.type.macro" })
            vim.api.nvim_set_hl(0, "@constant", { link = "@lsp.type.macro" })

            vim.api.nvim_set_hl(0, "@lsp.type.macro", { link = "@number" })
            vim.api.nvim_set_hl(0, "@function.macro", { link = "@number" })
            vim.api.nvim_set_hl(0, "@constant.macro", { link = "@number" })

            vim.api.nvim_set_hl(0, "@keyword.directive", { link = "@keyword.operator" })
            vim.api.nvim_set_hl(0, "@keyword.import", { link = "@keyword.directive" })
            vim.api.nvim_set_hl(0, "@keyword.exception", { link = "@keyword" })

            vim.api.nvim_set_hl(0, "@keyword.repeat", { link = "@keyword.operator" })
            vim.api.nvim_set_hl(0, "@keyword.operator", { link = "@keyword.conditional" })

            vim.api.nvim_set_hl(0, "@namespace", { link = "@keyword.conditional" })
            vim.api.nvim_set_hl(0, "@module", { link = "@namespace" })
            vim.api.nvim_set_hl(0, "@lsp.type.namespace", { link = "@namespace" })

            vim.api.nvim_set_hl(0, "Search", { link = "IncSearch" })
            vim.api.nvim_set_hl(0, "CurSearch", { link = "IncSearch" })

            -- vim.api.nvim_set_hl(0, "Function", cyan)
            -- vim.api.nvim_set_hl(0, "@function", cyan)
            -- vim.api.nvim_set_hl(0, "@lsp.type.function", cyan)
            -- vim.api.nvim_set_hl(0, "@lsp.type.method", cyan)
            -- vim.api.nvim_set_hl(0, "@function", cyan)
            -- vim.api.nvim_set_hl(0, "@function.builtin", cyan)
            -- vim.api.nvim_set_hl(0, "@function.call", cyan)
            -- vim.api.nvim_set_hl(0, "@function.macro", { link = "@keyword"} )
            -- vim.api.nvim_set_hl(0, "@function.method", cyan)
            -- vim.api.nvim_set_hl(0, "@function.method.call", cyan)
            -- vim.api.nvim_set_hl(0, "@lsp.type.function", cyan)
            -- vim.api.nvim_set_hl(0, "@lsp.type.function", cyan)
            -- vim.api.nvim_set_hl(0 ,"CmpItemKindFunction", cyan)
            vim.cmd.highlight("DiagnosticUnderlineError guisp=" .. get_color("DiagnosticError", "fg") .. " gui=undercurl")
            vim.cmd.highlight("DiagnosticUnderlineWarn guisp=" .. get_color("DiagnosticWarn", "fg") .. " gui=undercurl")
            vim.cmd.highlight("DiagnosticUnderlineOk guisp=" .. get_color("DiagnosticOk", "fg") .. " gui=undercurl")
            vim.cmd.highlight("DiagnosticUnderlineHint guisp=" .. get_color("DiagnosticHint", "fg") .. " gui=undercurl")
            vim.cmd.highlight("DiagnosticUnderlineInfo guisp=" .. get_color("DiagnosticInfo", "fg") .. " gui=undercurl")

            -- dofile(vim.g.base46_cache .. "defaults")
            --
            -- local integrations = require("nvconfig").base46.integrations
            --
            -- for _, name in ipairs(integrations) do
            --     dofile(vim.g.base46_cache .. name)
            -- end
        end,
    },
    {
        "wuelnerdotexe/vim-enfocado",
        priority = 1000,
        enabled = false,
        init = function()
            vim.g.enfocado_style = "nature"
            vim.cmd.colorscheme "enfocado"
        end,
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        enabled = false,
        config = function()
            require("rainbow-delimiters.setup").setup {}
        end,
    },
    -- {
    --     "folke/tokyonight.nvim",
    --     priority = 1000, -- Make sure to load this before all the other start plugins.
    --     enabled = false,
    --     init = function()
    --         -- You can configure highlights by doing something like:
    --         vim.cmd.colorscheme "tokyonight"
    --
    --         vim.cmd.hi "Comment gui=none"
    --         vim.api.nvim_set_hl(0, "CmpItemKind", { bold = true })
    --         vim.api.nvim_set_hl(0, "CmpItemAbbr", { link = "CursorLineNr" })
    --         vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CursorLineNr" })
    --         vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { link = "CursorLineNr" })
    --         vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CursorLineNr" })
    --     end,
    --     opts = {
    --         terminal_colors = true,
    --         styles = {
    --             -- Style to be applied to different syntax groups
    --             -- Value is any valid attr-list value for `:help nvim_set_hl`
    --             comments = { italic = false },
    --             keywords = { italic = false },
    --             functions = {},
    --             variables = {},
    --             -- Background styles. Can be "dark", "transparent" or "normal"
    --             sidebars = "dark", -- style for sidebars, see below
    --             floats = "dark", -- style for floating windows
    --         },
    --     },
    -- },

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
            ensure_installed = { "bash", "c", "html", "lua", "luadoc", "python", "markdown", "vim", "vimdoc" },
            compilers = { "C:\\Program Files\\LLVM\\bin\\clang.exe" },
            -- Autoinstall languages that are not installed
            auto_install = true,
            highlight = {
                enable = true,
                -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                --  If you are experiencing weird indenting issues, add the language to
                --  the list of additional_vim_regex_highlighting and disabled languages for indent.
                additional_vim_regex_highlighting = { "ruby" },
            },
            -- Disable for large files
            disable = function(lang, buf)
                local max_filesize = 800 * 1024 -- 800 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            indent = { enable = true, disable = { "lua", "python", "cpp", "c", "ruby" } },
        },
        config = function(_, opts)
            -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
            require("nvim-treesitter.install").prefer_git = true
            require("nvim-treesitter.install").compilers = { "clang", "gcc" }

            -- Insert mode keybindings
            opts.textobjects = {
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        -- ["]]"] = { query = "@class.outer", desc = "Next class start" },
                        -- --
                        -- -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
                        -- ["]o"] = "@loop.*",
                        -- -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
                        -- --
                        -- -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                        -- -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                        -- ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                        -- ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                    },
                    --     goto_next_end = {
                    --         ["]M"] = "@function.outer",
                    --         ["]["] = "@class.outer",
                    --     },
                    --     goto_previous_start = {
                    --         ["[m"] = "@function.outer",
                    --         ["[["] = "@class.outer",
                    --     },
                    --     goto_previous_end = {
                    --         ["[M"] = "@function.outer",
                    --         ["[]"] = "@class.outer",
                    --     },
                    --     -- Below will go to either the start or the end, whichever is closer.
                    --     -- Use if you want more granular movements
                    --     -- Make it even more gradual by adding multiple queries and regex.
                    --     goto_next = {
                    --         ["]d"] = "@conditional.outer",
                    --     },
                    --     goto_previous = {
                    --         ["[d"] = "@conditional.outer",
                    --     },
                },
            }
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
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
            "nvim-treesitter",
        },
    },
    {
        "tikhomirov/vim-glsl",
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
                size = 120,
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
            vim.cmd "autocmd! TermOpen term://* setlocal signcolumn=no "

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

            local found_error = false
            local msbuild = Terminal:new {
                hidden = true,
                display_name = "Build",
                close_on_exit = true,
                -- stderr does not work with neovim i guess
                -- parse stdout instead
                on_stdout = function(t, job, data, name)
                    if found_error == true then
                        return
                    end

                    local stream = ""
                    for _, line in pairs(data) do
                        stream = stream .. line
                        -- look for: error C12345
                        local start_idx, _ = string.find(stream, "%serror%s[A-Z0-9]+:%s")
                        if start_idx then
                            local text = ""
                            local error = nil
                            -- loop backwards and find the first "("
                            for i = start_idx - 1, 1, -1 do
                                local char = stream:sub(i, i)

                                if error == nil then
                                    if char == "(" then
                                        error = text
                                        text = ""
                                    end
                                end
                                text = char .. text
                            end

                            -- Remove last (
                            text = string.sub(text, 1, -2)

                            -- Define a pattern to match Windows paths
                            local pattern = "([A-Za-z]:\\[^%c%s]+)"

                            local filepath = text:match(pattern)
                            if vim.fn.filereadable(filepath) == 1 then
                                found_error = true
                                local function get_pos(str)
                                    local l, c = str:match "(%d+),(%d+)"
                                    return { tonumber(l), tonumber(c) }
                                end
                                -- Handle string conversion errors
                                local valid_pos, pos = pcall(get_pos, error)
                                if not valid_pos then
                                    return
                                end
                                -- Change focus to the previous window
                                -- vim.cmd "wincmd p"
                                -- Open the file
                                vim.cmd("edit " .. filepath)
                                -- Move cursor to errror
                                vim.cmd("normal " .. pos[1] .. "G") -- Move to the specified line
                                vim.cmd("normal " .. pos[2] .. "|") -- Move to the specified column
                            end
                        end
                    end
                end,
            }

            function _MS_BUILD_TOGGLE(cmd)
                if vim.fn.has "win32" == 0 then
                    error "Only Win32 supported"
                    return
                end

                local root_patterns = { "build.bat", "build.sh" }
                local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])

                -- Build file not found
                if root_dir == nil then
                    error "Build file not found"
                    return
                end

                if not msbuild:is_open() then
                    msbuild:open()
                end
                msbuild:send(cmd, true)
                found_error = false
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
    -- {
    --     "easymotion/vim-easymotion",
    --     init = function()
    --         -- Unmap easymotion from leader-key
    --         vim.g.EasyMotion_do_mapping = 0
    --         -- Case insensitive
    --         vim.g.EasyMotion_smartcase = 0
    --     end,
    -- },
    {
        "kyazdani42/nvim-tree.lua",
        config = function()
            local nvim_tree = require "nvim-tree"

            local opts = {
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
                select_prompts = false,
                view = {
                    adaptive_size = false,
                    centralize_selection = false,
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
                            width = 28,
                            height = 28,
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
                    timeout = 400,
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

                on_attach = function(bufnr)
                    local api = require "nvim-tree.api"

                    local function opts(desc)
                        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                    end

                    -- default mappings
                    api.config.mappings.default_on_attach(bufnr)

                    -- custom mappings
                    keymaps_nvim_tree(api, opts)
                end,
            }
            -- Implicitly update nvim-tree when project module is active
            if require("project_nvim").active then
                opts.respect_buf_cwd = true
                opts.update_cwd = true
                opts.update_focused_file.enable = true
                opts.update_focused_file.update_cwd = true
            end

            -- Set keymaps with on_attch hook

            nvim_tree.setup(opts)
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        enabled = true,
        config = function()
            local lualine = require "lualine"
            local icons = require "nvim-web-devicons"

            local conditions = {
                hide_in_width = function()
                    return vim.fn.winwidth(0) > 80
                end,
            }

            -- Fetch colors
            local tree_fg = get_color("NvimTreeNormal", "fg")
            local tree_bg = get_color("NvimTreeEndOfBuffer", "bg")
            local default_color = get_color "Normal"

            -- Config
            local config = {
                options = {
                    -- Disable sections and component separators
                    icons_enabled = false,
                    component_separators = "",
                    section_separators = "",
                    disabled_filetypes = { "packer", "NvimTree", "alpha", "toggleterm" },
                    unhide = true,
                    theme = {
                        -- We are going to use lualine_c an lualine_x as left and
                        -- right section. Both are highlighted by c theme .  So we
                        -- are just setting default looks o statusline
                        normal = { c = { fg = tree_fg, bg = tree_bg } },
                        inactive = { c = { fg = tree_fg, bg = tree_bg } },
                    },
                },
                sections = {
                    -- these are to remove the defaults
                    lualine_a = {},
                    lualine_b = {},
                    lualine_y = {},
                    lualine_z = {},
                    -- These will be filled later
                    lualine_c = {},
                    lualine_x = {},
                },
                inactive_sections = {
                    -- these are to remove the defaults
                    lualine_a = {},
                    lualine_b = {},
                    lualine_y = {},
                    lualine_z = {},
                    lualine_c = {},
                    lualine_x = {},
                },
            }

            -- Inserts a component in lualine_c at left section
            local function ins_left(component)
                table.insert(config.sections.lualine_c, component)
            end

            -- Inserts a component in lualine_x ot right section
            local function ins_right(component)
                table.insert(config.sections.lualine_x, component)
            end

            -- Format python env string
            local function env_cleanup(venv)
                if string.find(venv, "/") then
                    local final_venv = venv
                    for w in venv:gmatch "([^/]+)" do
                        final_venv = w
                    end
                    venv = final_venv
                end
                return venv
            end

            -- ins_left {
            --   -- filesize component
            --   'filesize',
            --   cond = conditions.buffer_not_empty,
            -- }

            ins_left {
                "mode",
                color = function()
                    -- auto change color according to neovims mode

                    -- TODO: Move these out to theme highlights
                    local mode_color = {
                        n = default_color, -- Normal mode
                        i = get_color "DevIconCsv", -- Insert mode
                        v = get_color "DevIconJavaScriptReactSpec", -- Visual mode
                        [""] = get_color "DevIconJavaScriptReactSpec", -- Visual Block mode
                        V = get_color "DevIconJavaScriptReactSpec", -- Line Visual mode
                        c = get_color "TodoFgTODO", -- Command-line mode
                        no = get_color "DevIconJavaScriptReactSpec", -- Operator-pending mode
                        s = get_color "DevIconClojureC", -- Select mode
                        S = get_color "DevIconClojureC", -- Line Select mode
                        [""] = get_color "DevIconJavaScriptReactSpec", -- Select Block mode
                        ic = get_color "TodoFgTODO", -- Insert mode completion
                        R = get_color "DevIconClojureC", -- Replace mode
                        Rv = get_color "DevIconClojureC", -- Virtual Replace mode
                        cv = get_color "TodoFgTODO", -- Command-line window mode
                        ce = get_color "TodoFgTODO", -- Normal Ex mode
                        r = get_color "DevIconJavaScriptReactSpec", -- Hit-enter prompt
                        rm = get_color "DevIconJavaScriptReactSpec", -- More-prompt
                        ["r?"] = get_color "DevIconJavaScriptReactSpec", -- Confirm-prompt
                        ["!"] = get_color "TodoFgTODO", -- Shell mode
                        t = get_color "TodoFgTODO", -- Terminal mode
                    }

                    return {
                        fg = mode_color[vim.fn.mode()] or default_color,
                        gui = "bold",
                    }
                end,
            }

            ins_left {
                function()
                    local current_file = vim.fn.expand "%:t"
                    local extension = vim.fn.expand "%:e"
                    local icon, _ = icons.get_icon(current_file, extension)

                    if icon == nil then
                        return ""
                    else
                        return icon
                    end
                end,
                color = function()
                    local current_file = vim.fn.expand "%:t"
                    local extension = vim.fn.expand "%:e"
                    local _, color = icons.get_icon_color(current_file, extension)
                    return { fg = color }
                end,
            }
            ins_left {
                function()
                    return vim.fn.expand "%:t"
                end,
                color = function()
                    local sign_status = vim.b[vim.api.nvim_get_current_buf()].gitsigns_status
                    if sign_status ~= nil and #sign_status > 0 then
                        return { fg = get_color "NvimTreeGitDirty" }
                    else
                        return { fg = default_color }
                    end
                end,
                padding = { left = -1, right = 1 },
            }

            ins_left {
                "branch",
                -- icon = "",
                -- color = { fg = colors.light_violet, gui = "NONE" },
                -- padding = { left = 0 },
            }
            -- ins_left {
            --     "diff",
            --     diff_color = {
            --         added = { fg = get_color "NvimTreeGitNew" },
            --         modified = { fg = get_color "NvimTreeGitDirty" },
            --         removed = { fg = get_color "NvimTreeGitDeleted" },
            --     },
            --     symbols = { added = "", modified = "", removed = "" },
            -- }

            --
            -- Insert mid section. You can make any number of sections in neovim :)
            -- for lualine it's any number greater then 2
            ins_left {
                function()
                    return "%="
                end,
            }

            ins_right {
                function()
                    local r, c = unpack(vim.api.nvim_win_get_cursor(0))

                    return string.format("Ln %s, Col %s", r, c + 1)
                end,
            }

            ins_right {
                function()
                    return "Spaces:" .. vim.api.nvim_get_option_value("shiftwidth", { buf = 0 })
                end,
            }

            ins_right {
                function()
                    if vim.bo.filetype == "python" then
                        local venv = os.getenv "CONDA_DEFAULT_ENV"
                        if venv then
                            return string.format(" (%s)", env_cleanup(venv))
                        end
                        venv = os.getenv "VIRTUAL_ENV"
                        if venv then
                            return string.format(" (%s)", env_cleanup(venv))
                        end
                        return ""
                    end
                    return ""
                end,
                cond = conditions.hide_in_width,
            }

            -- Add components to right sections
            ins_right {
                "o:encoding", -- option component same as &encoding in viml
                fmt = string.upper, -- I'm not sure why it's upper case either ;)
                cond = conditions.hide_in_width,
                color = { fg = default_color, gui = "bold" },
            }

            ins_right {
                "fileformat",
                fmt = string.upper,
                icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
                color = { fg = default_color, gui = "bold" },
            }

            -- Now don't forget to initialize lualine
            lualine.setup(config)
        end,
    },
    {
        "smjonas/inc-rename.nvim",
        opts = {},
    },
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
