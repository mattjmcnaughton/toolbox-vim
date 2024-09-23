FROM docker.io/ubuntu:24.04

ARG USERNAME=mattjmcnaughton
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN userdel -r ubuntu

RUN groupadd --gid $USER_GID $USERNAME && \
   useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

ENV DEBIAN_FRONTEND=noninteractive

# TODO: Remove once we don't need to add packages.
RUN apt update && \
  apt install -y sudo && \
  echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
  chmod 0440 /etc/sudoers.d/$USERNAME

RUN apt install -y neovim

RUN apt install -y git

# For `telescope-nvim`
RUN apt install -y cmake fzf ripgrep fd-find

USER $USERNAME
WORKDIR /home/$USERNAME

RUN mkdir .config && chown $USERNAME:$USERNAME .config
RUN mkdir .config/nvim && chown $USERNAME:$USERNAME .config/nvim

# Install the Packer plug-in manager
# From https://github.com/wbthomason/packer.nvim?tab=readme-ov-file#quickstart
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

COPY --chown=$USERNAME:$USERNAME .config/nvim/init.lua /home/$USERNAME/.config/nvim/init.lua
COPY --chown=$USERNAME:$USERNAME .config/nvim/lua /home/$USERNAME/.config/nvim/lua

RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# Need to wait to copy after until the plugins are installed.
COPY --chown=$USERNAME:$USERNAME .config/nvim/after /home/$USERNAME/.config/nvim/after

# Install the tree-sitter languages (https://github.com/nvim-treesitter/nvim-treesitter/issues/2533)
# TODO: Determine how to keep this list synced w/ `treesitter.lua`.
RUN nvim --headless -c 'TSInstallSync bash c comment css csv dockerfile gitcommit gitignore go haskell helm java javascript json just lua nix python r rust scss sql terraform typescript yaml vim vimdoc query markdown markdown_inline' -cq
