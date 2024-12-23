# toolbox-vim

A fully configured Vim/Neovim environment you can safely bring wherever you go.


## How it works

`toolbox-vim` contains two components.

First, it is a container image, e.g. `docker.io/mattjmcnaughton/toolbox-vim`, with a fully customized Vim/Neovim experience.

Second, it is a binary responsible for running this container image with all the
necessary configuration and settings for a seamless experience.

## Why is this better than using Vim directly?

- Take your vim config (and install) with you where you go.
- Greater control over the environment in which your text editor executes. Limit
  permissions (i.e. network access, view of the file-system, etc).
- Easier to experiment w/ different Vim configs (with no concern around leaving
  cruft behind).

## Usage

See [usage.md](./docs/usage.md).

### Config

See [config.md](./docs/config.md).

## Core toolbox-vim Image

This repo also contains a core toolbox-vim image.

See [core](./contrib/images/core/README.md) for more info.
