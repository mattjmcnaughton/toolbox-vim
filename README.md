# toolbox-vim

A fully configured Vim/Neovim environment you can safely bring wherever you go.


## How it works

`toolbox-vim` contains two components.

First, it is a container image, e.g. `docker.io/mattjmcnaughton/toolbox-vim`, with a fully customized Vim/Neovim experience.

Second, it is a binary responsible for running this container image with all the
necessary configuration and settings for a seamless experience.

## Why is this better than using Vim directly?

- Take your vim config with you where you go.
- Greater control over the environment in which your text editor executes. Limit
  permissions (i.e. network access, view of the file-system, etc).
- Easier to experiment w/ different Vim configs (with no concern around leaving
  cruft behind).

## Usage

- `toolbox-vim $FILE`

We recommend specifying `alias vim="toolbox-vim $DEFAULT-PARAMETERS"`.

### Configuration

The following is a WIP of configuration ideas.

We allow configuration via environment variable, config file, or direct command
line parameters.

- `--container-runtime=(docker|podman)`
- `--network-permissions=(none|limited|logged|full)`
- `--network-permissions-allowlist=<URLS>`
    - Only applicable when `--network-permissions=limited`
- `--filesystem-mount=(cwd|git|home|custom)`
- `--filesystem-mount-custom-path=PATH`
    - Only applicable when `--filesystem-mount=custom`
- `--container-uid-override`
    - By default we use the current user id.
- `--container-gid-override`
    - By default we use the current user id.
- `--enable-copilot`
    - Whether to enable GitHub Copilot.

TODO: This list is a WIP.


## Image

We can consider including the following in the image:

Should we set up from scratch or should we customize LazyVim? TBD...

- NeoVim
- nvim-treesitter / nvim-treesitter-textobjects
- Telescope
- Fzf-lua
- LSP
    - nvim-lspconfig
    - mason
    - mason-lspconfig.nvim
    - nvim-cmp
    - cmp-nvim-lsp
- TBD: Snippets
    - cmp-luasnip
    - luasnip
- TBD: Linters
    - nvim-lint / ALE
- Misc
    - mini.surround
    - mini.pairs
    - todo-comments.nvim
    - neo-tree.nvim
- Git
    - Fugitive
- Copilot/Copilot Chat (requires different image)
