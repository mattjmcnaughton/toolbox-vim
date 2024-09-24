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

COPY --chown=$USERNAME:$USERNAME .config/nvim /home/$USERNAME/.config/nvim

RUN nvim --headless "+Lazy! sync" +qa
