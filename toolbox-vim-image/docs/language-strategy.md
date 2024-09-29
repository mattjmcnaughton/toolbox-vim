# language-strategy

## Overview

For each language, we configure:

- Defaults (i.e. `ftplugin`)
- LSP
- Linter
- Formatter

## Languages

### Priorities

- Python
- Rust
- Golang
    - Defaults: 8 tabs
    - LSP: gopls
    - Linter: N/A (use LSP)
    - Formatter: gofmt
- TypeScript
- Lua
    - Defaults: 2 spaces
    - LSP: lua_ls
    - Linter: N/A (Use lua_ls)
    - Formatter: N/A (Use lua_ls)

### Secondaries

- Bash
- Docker
- R
- Nix
- Haskell
- Terraform

### Maybe

- HTML
- CSS/SCSS
- JavaScript
- Latex
- Markdown
- Erlang/Elixir
- Lisp
- Zig
- Ruby
