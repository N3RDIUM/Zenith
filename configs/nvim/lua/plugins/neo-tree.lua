return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim"
    },
    config = function()
        require("neo-tree").setup({
            sources = {
                "filesystem",
                "buffers",
                "git_status",
                "document_symbols"
            }
        })
    end
}
