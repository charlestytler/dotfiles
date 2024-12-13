return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  opts = {},
  keys = {
    { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "DiffviewOpen" },
    { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "DiffviewClose" },
    { "<leader>dt", "<cmd>DiffviewToggleFiles<cr>", desc = "DiffviewToggleFiles" },
    { "<leader>df", "<cmd>DiffviewFocusFiles<cr>", desc = "DiffviewFocusFiles" },
  },
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
