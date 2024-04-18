local M = {}

M.ui = {
    ------------------------------- base46 -------------------------------------
    -- hl = highlights
    hl_add = {},
    hl_override = {},
    changed_themes = {},
    theme_toggle = {},
    -- https://nvchad.com/themes/
    theme = "onedark", -- default theme
    transparency = false,

    cmp = {
        icons = true,
        lspkind_text = true,
        style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    },

    telescope = { style = "borderless" }, -- borderless / bordered

    ------------------------------- nvchad_ui modules -----------------------------
    statusline = {
        theme = "default", -- default/vscode/vscode_colored/minimal
    },

    -- Required tables
    tabufline = {},
    nvdash = {},
    cheatsheet = {}, -- simple/grid
    lsp = {},
    term = {},
}

M.base46 = {
    integrations = {},
}

return M
