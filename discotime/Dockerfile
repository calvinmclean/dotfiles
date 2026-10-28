ARG BASE_IMAGE=ghcr.io/discobox-ai/discobox-harness-shell:v0.18.0
FROM ${BASE_IMAGE}

USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl fish fzf jq tmux vim zoxide \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://tuicr.dev/install.sh -o /tmp/install-tuicr.sh \
    && TUICR_INSTALL_DIR=/usr/local/bin TUICR_INSTALL_YES=1 sh /tmp/install-tuicr.sh \
    && rm /tmp/install-tuicr.sh \
    && tuicr --version

RUN curl -fsSL https://taskfile.dev/install.sh -o /tmp/install-task.sh \
    && sh /tmp/install-task.sh -b /usr/local/bin \
    && rm /tmp/install-task.sh \
    && task --version

# Keep defaults in /etc/skel, then fill missing files after volume wiring.
COPY .config/fish/config.fish /etc/skel/.config/fish/config.fish
COPY .config/tuicr/config.toml /etc/skel/.config/tuicr/config.toml
COPY .vimrc .tmux.conf .gitconfig .gitignore_global /etc/skel/

# Keep signing enabled, but configure access to a signing key at runtime.
RUN git config --file /etc/skel/.gitconfig --unset user.signingkey \
    && git config --file /etc/skel/.gitconfig core.excludesfile '~/.gitignore_global'

COPY --chmod=755 discotime/seed-dotfiles.sh /usr/local/libexec/discotime/seed-dotfiles
COPY discotime/seed-dotfiles.conf /etc/systemd/system/discobox-wire.service.d/seed-dotfiles.conf
