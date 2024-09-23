-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  -- Fuzzy finder
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',

	  -- Lua module for interacting w/ system processes.
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- For improved performance (see https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#suggested-dependencies)
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }

  use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate' })

  use ('tpope/vim-fugitive')
end)
