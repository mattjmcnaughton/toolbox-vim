# config

## Conventions

We specify configuration via (in-order of preference):

- Command line flags (i.e. `--container-runtime`)
- Environment variables (i.e. `TOOLBOX_VIM_CONTAINER_RUNTIME`)
- Config file (`.toolbox-vim.toml`)
- Defaults

We use [spf13/viper](https://github.com/spf13/viper).

Configuration values are _not_ case sensitive.

We look for config files in `$TOOLBOX_VIM_CONFIG_DIR/config.toml`. We search for `$TOOLBOX_VIM_CONFIG_DIR` in
the following locations (in order of preference).
- `$PWD/.toolbox-vim`
- `$GIT_DIR/.toolbox-vim`
- `$XDG_CONFIG_DIR/toolbox-vim`
- `$HOME/.toolbox-vim`

Config values are referenced canonically via _kebab-case_. When specifying as environment variables, we
prefix with `TOOLBOX_VIM` and swap `-` for `_`. However, we use `SetEnvPrefix` and `SetEnvKeyReplacer`
so we can refer to the variables as normal.

TODO: We use lists in toml, and comma-separated strings in environment variables/CLI flags.
We need to confirm Viper can handle the translation.

## Values

See [config/base.toml](../contrib/config/base.toml) during iteration.

Include restrictions (i.e. can only have `network-permissions-custom-*` when `network-permissions=custom`.
