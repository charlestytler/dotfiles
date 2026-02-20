local treesitter = {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate | TSInstallAll",
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
