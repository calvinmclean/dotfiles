# Discotime

Discobox v0.18.0 harness images with fish, [tuicr](https://tuicr.dev/), and
[Task](https://taskfile.dev/) installed. One Dockerfile extends each official
harness image, preserving its agent and harness setup. The `tuicr` and `task`
commands are available system-wide in `/usr/local/bin`.

The images also install fzf, zoxide, tmux, and Vim, and seed each new sandbox
user's home with this repository's fish, tuicr, Vim, tmux, Git, and global Git
ignore configs. SSH commit signing stays enabled, with the laptop's signing-key
path removed. Configure a signing key inside the sandbox before committing;
private keys are not included. Fish uses `$HOME/go/bin` and adds Homebrew's path
only when it exists.

The build uses the repository root as its context, with an allowlist in
`Dockerfile.dockerignore`. After Discobox wires the home and cache volumes, a
`discobox-wire.service` post-start step copies missing files from `/etc/skel`
as the sandbox user. This also works when mountpoint directories already make
the home nonempty, causing Discobox's own skeleton seeding to skip it. Existing
configs are preserved. Rebuild the images and create a new box (or upgrade an
existing box) to install the step; it fills missing files on each boot.

Run these tasks from `discotime/`, with the version matching your Discobox release:

```sh
task build DISCOBOX_VERSION=v0.18.0
task push
```

This builds and pushes `ghcr.io/calvinmclean/discotime:shell`, `:claude-code`, and
`:codex`. To build just one variant:

```sh
task build:codex DISCOBOX_VERSION=v0.18.0
```

Set `IMAGE_REPO=registry.example.com/discotime` on build and push to use another
repository; update the fish function's references to match. The pool's Docker
daemon must be able to pull these images.

Reload your local fish config, then use `discotime` wherever you would use
`discobox`:

```fish
source ~/.config/fish/config.fish
discotime
# Arguments are forwarded unchanged:
discotime admin server
```

The function sets these environment variables for the command and its children:

```sh
DISCOBOX_HARNESS_SHELL_IMAGE=ghcr.io/calvinmclean/discotime:shell
DISCOBOX_HARNESS_CLAUDE_CODE_IMAGE=ghcr.io/calvinmclean/discotime:claude-code
DISCOBOX_HARNESS_CODEX_IMAGE=ghcr.io/calvinmclean/discotime:codex
```

These are server settings. Restart an already-running local server using the
wrapper so it inherits them. For a separately managed or remote server, set them
in that server's environment and restart it there. In v0.18.0, `releaseManifest`
or `DISCOBOX_RELEASE_MANIFEST` overrides individual image settings, including
these. `defaultSandboxImage` does not override a harness's own image.

To prefer fish in interactive shell panes, run this in your local fish shell:

```fish
set -gx DISCOBOX_SHELL fish
```
