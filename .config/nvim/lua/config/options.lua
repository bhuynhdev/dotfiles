-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.opt.autochdir = true
vim.opt.matchpairs:append("<:>")
vim.opt.directory = "/tmp/vimswaps/" -- Shorter swap file dir to fix error https://github.com/neovim/neovim/issues/3898#issuecomment-372810680

-- Restoring indent after typing hash: https://vim.fandom.com/wiki/Restoring_indent_after_typing_hash
vim.opt.smartindent = false
vim.opt.cindent = true
vim.opt.cinkeys:remove("0#")
vim.opt.cinkeys:remove("0#")
vim.opt.indentkeys:remove("0#")
