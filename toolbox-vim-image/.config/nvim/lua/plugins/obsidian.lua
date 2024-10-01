-- TODO: Determine the best way to get this installed when the time comes...

local force_install_obsidian = os.getenv("TOOLBOX_VIM_FORCE_INSTALL_OBSIDIAN")
local vault_dir = os.getenv("TOOLBOX_VIM_OBSIDIAN_VAULT_DIR")

if force_install_obsidian and vault_dir == nil then
  return {
    "epwalsh/obsidian.nvim",

    dependencies = {
      "nvim-lua/plenary.nvim",
    }
  }
elseif vault_dir ~= nil then
  return {
    "epwalsh/obsidian.nvim",

    lazy = false,

    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    event = {
      -- TODO: Replace w/ actual path...
      "BufReadPre " .. vault_dir .. "/*.md",
      "BufNewFile " .. vault_dir .. "/*.md",
    },


    opts = {
      workspaces = {
        {
          name = "second-brain",
          path = vault_dir
        }
      }
    }
  }
else
  return {}
end
