return {
    "stevearc/conform.nvim",
    opts = function(_, opts)
        local util = require("conform.util")

        opts.formatters = opts.formatters or {}
        opts.formatters_by_ft = opts.formatters_by_ft or {}

        -- Use the repo-pinned tool manifest version:
        --   dotnet tool restore
        -- then Conform will run:
        --   dotnet tool run csharpier

        opts.formatters.csharpier = {
            command = "/opt/homebrew/opt/dotnet@8/bin/dotnet",
            args = { "tool", "run", "dotnet-csharpier", "--write-stdout" },
            stdin = true,
            cwd = util.root_file({
                ".config/dotnet-tools.json",
                ".editorconfig",
                ".git",
            }),
            require_cwd = true,
        }

        opts.formatters.fantomas = {
            command = "dotnet",
            args = { "fantomas" },
            cwd = util.root_file({ ".editorconfig" }),
            require_cwd = true,
            stdin = true,
        }

        opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
            css = { "prettierd" },
            -- filetype is "fsharp" in Neovim
            fsharp = { "fantomas" },
            javascript = { "prettierd" },
            json = { "prettierd" },
            lua = { "stylua" },
            -- markdown = { "prettierd" },
            scss = { "prettierd" },
            sh = { "shfmt" },
            typescript = { "prettierd" },
            vue = { "prettierd", "rustywind" },
            xml = { "prettierd" },
        })
    end,
}
