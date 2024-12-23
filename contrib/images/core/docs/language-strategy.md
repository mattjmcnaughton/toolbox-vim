# language-strategy

## Overview

For each language, we configure:

- Defaults (i.e. `ftplugin`)
- LSP
- Linter
    - Only necessary if can't rely on LSP
- Formatter
    - Only necessary if can't rely on LSP

## Languages

### Priorities

- Python
    - Defaults: 4 spaces (already the default)
    - LSP: pyright
    - Linter: Ruff LSP
    - Formatter: Ruff LSP
- Rust
    - Defaults: 4 spaces
    - LSP: rust-analyzer
    - Linter: N/A (use LSP)
    - Formatter: N/A (falls back to rustfmt)
- Golang
    - Defaults: 8 tabs
    - LSP: gopls
    - Linter: N/A (use LSP)
    - Formatter: gofmt
- TypeScript
    - Defaults: 2 spaces
    - LSP: typescript_language_server
    - Linter: eslint (functioning as a language server)
    - Formatter: prettier
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
- Erlang/Elixir
- Lisp
- Zig
- Ruby

### No-go

- Markdown
    - I just don't think there's sufficient roi for a markdown language server,
      at this moment.
