-- TODO: Determine the best way to get this installed when the time comes...

local vault_dir = os.getenv("OBSIDIAN_VAULT_DIR")

if vault_dir ~= nil then
  return {
    "epwalsh/obsidian.nvim",

    lazy = true,
    event = {
      -- TODO: Replace w/ actual path...
      "BufReadPre " .. vault_dir .. "/*.md",
      "BufNewFile " .. vault_dir .. "/*.md",
    },

    dependencies = {
      "nvim-lua/plenary.nvim",
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
