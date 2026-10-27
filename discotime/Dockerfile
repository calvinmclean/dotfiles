ARG DISCOBOX_VERSION=v0.18.0
FROM ghcr.io/discobox-ai/discobox-sandbox-agent:${DISCOBOX_VERSION}

USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl fish fzf tmux vim zoxide \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://tuicr.dev/install.sh -o /tmp/install-tuicr.sh \
    && TUICR_INSTALL_DIR=/usr/local/bin TUICR_INSTALL_YES=1 sh /tmp/install-tuicr.sh \
    && rm /tmp/install-tuicr.sh \
    && tuicr --version

RUN curl -fsSL https://taskfile.dev/install.sh -o /tmp/install-task.sh \
    && sh /tmp/install-task.sh -b /usr/local/bin \
    && rm /tmp/install-task.sh \
    && task --version

# Discobox seeds each new sandbox user's home from /etc/skel at boot.
COPY .config/fish/config.fish /etc/skel/.config/fish/config.fish
COPY .config/tuicr/config.toml /etc/skel/.config/tuicr/config.toml
COPY .vimrc .tmux.conf .gitconfig .gitignore_global /etc/skel/

# Keep signing enabled, but configure access to a signing key at runtime.
RUN git config --file /etc/skel/.gitconfig --unset user.signingkey \
    && git config --file /etc/skel/.gitconfig core.excludesfile '~/.gitignore_global'
