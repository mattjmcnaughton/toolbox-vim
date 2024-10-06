# TODO

- done: Initial plugins
- done: Obsidian (initial)
- done: Test airgapped
- done: Obsidian "all-in"
    - done: Install obsidian.nvim and set-up `Justfile` in second-brain.
    - done: Setup markdown language server.
    - done: Essential obsidian config.
        - Silencing the warning message.
        - Ensuring the Today file is opened correctly.
        - Shortcuts to opening the today file (maybe even on start).
            - Set the `CMD`.
- Install remaining language servers (see [language-strategy.md](./docs/language-strategy.md))
- Launch "in production"
    - Split obsidian and non-Obsidian into two separate images
    - I.e. public image and start w/ the tooling to launch.
- Key mappings
    - Set up short-cut for opening neovim config...
    - Set up shortcut for copying/pasting to/from system clipboard (in :paste)
      mode.
- LLMs
    - Default to local LLMs via Olama and _likely_ `gen.nvim`.
    - Support opt-in interface w/ ChatGPT
        - https://github.com/Robitx/gp.nvim
    - Support opt-in interface w/ CoPilot (or Claude Dev)
- Tags (i.e. go-to definition) / Test runners / debuggers
- Plugin deep-dive
    - Better usage of snippets.
        - Options in
          https://github.com/rafamadriz/friendly-snippets/blob/main/snippets/
        - Better use the plugin.
- Obisidian / Google Drive integration (or someway to draft in Obsidian and
selectively push to Google Drive)
- TBD: Install tmux
- TBD: Split up Obsidian into a separate container.
