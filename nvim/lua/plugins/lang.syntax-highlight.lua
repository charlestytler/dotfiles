local treesitter = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "html",
        "javascript",
        "julia",
        "lua",
        "python",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
  },
}

return {
  treesitter,
}
