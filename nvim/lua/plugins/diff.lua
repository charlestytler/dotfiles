local mini_diff = {
  "echasnovski/mini.diff",
  version = false,
  event = "VeryLazy",
  opts = {
    view = {
      style = "sign",
    },
  },
  keys = {
    { "<leader>go", "<cmd>lua MiniDiff.toggle_overlay()<cr>", desc = "Diff Overlay" },
  },
}

local diffview = {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
  opts = {},
  keys = {
    { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
    { "<leader>dq", "<cmd>DiffviewClose<cr>", desc = "Diffview Quit" },
    { "<leader>d\\", "<cmd>DiffviewToggleFiles<cr>", desc = "Diffview Toggle Files" },
    { "<leader>df", "<cmd>DiffviewFocusFiles<cr>", desc = "Diffview Focus Files" },
  },
}

return {
  mini_diff,
  diffview,
}

--[[
Add this later:

 local function diffOpenWithInput()
        local user_input = vim.fn.input("Revision to Open: ")
        vim.cmd("DiffviewOpen " .. user_input)
    end

    local function diffOpenFileHistory()
        local user_input = vim.fn.input("Files to Open: ")
        vim.cmd("DiffviewFileHistory" .. user_input)
    end

    -- Key maps
    require("which-key").add({
        { "<leader>g",  group = "Git" },
        { "<leader>gf", diffOpenFileHistory, desc = "Open DiffView on Files" },
        { "<leader>go", diffOpenWithInput,   desc = "Open DiffView" },
    })

 Here are some soem ways I commonly call it:

    diffOpenFileHistory with . opens commit wise history of entire codebase.

    diffOpenFileHistory with % opens commit wise history of current file.

    diffOpenFileHistory with <any file path> opens commit wise history of that file.

    diffOpenWithInput with HEAD opens diff of latest commit.

    diffOpenWithInput with HEAD~3 opens diff of last 3 commits.

    diffOpenWithInput with master..HEAD opens changes of your feature branch.
--]]
