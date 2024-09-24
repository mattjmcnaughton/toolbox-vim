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

# For mason
RUN apt install -y curl unzip tar gzip

USER $USERNAME
WORKDIR /home/$USERNAME

RUN mkdir .config && chown $USERNAME:$USERNAME .config
RUN mkdir .config/nvim && chown $USERNAME:$USERNAME .config/nvim

COPY --chown=$USERNAME:$USERNAME .config/nvim /home/$USERNAME/.config/nvim

# Install rust
RUN sudo apt install -y rustup
RUN rustup toolchain install stable-gnu

# Install golang
RUN sudo apt install -y golang-go

# Install python
RUN sudo apt install -y python3 python3-pip python3-venv

# Install node
RUN sudo apt install -y nodejs npm

# Install Lua
RUN sudo apt install -y luarocks

# Install plugins via Lazy
RUN nvim --headless "+Lazy! sync" +qa

# Install lsp, linters, formatters, etc... via Mason
RUN nvim --headless "+MasonInstall lua-language-server gopls prettier ruff ruff-lsp rust-analyzer" +qa
