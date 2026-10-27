# Discotime

Discobox v0.18.0’s sandbox-agent image with fish, [tuicr](https://tuicr.dev/), and
[Task](https://taskfile.dev/) installed. The `tuicr` and `task` commands are
available system-wide in `/usr/local/bin`.

The image also installs fzf, zoxide, tmux, and Vim, and seeds each new sandbox
user's home with this repository's fish, tuicr, Vim, tmux, Git, and global Git
ignore configs. The image keeps SSH commit signing enabled and removes the
laptop's SSH signing-key path. Configure a signing key inside the sandbox before
committing; private keys are not included in the image. Fish uses `$HOME/go/bin`
and adds Homebrew's path only when it exists.

The build uses the repository root as its context, with an allowlist in
`Dockerfile.dockerignore`. Existing sandbox homes keep their current configs;
create a new box using the rebuilt image to pick up dotfile changes.

Build with the version matching your Discobox release:

```sh
task build DISCOBOX_VERSION=v0.18.0
```

The image is tagged `discotime:fish`. Set `IMAGE=registry.example.com/discotime:fish` to use another tag.

Point your Discobox server’s `server.yaml` at the image:

```yaml
defaultSandboxImage: ghcr.io/calvinmclean/discotime:latest
```

The image must be available to the pool’s Docker daemon. For a remote pool, push it to a registry the pool can pull from.

To build and push that registry tag:

```sh
task build DISCOBOX_VERSION=v0.18.0 IMAGE=ghcr.io/calvinmclean/discotime:latest
docker push ghcr.io/calvinmclean/discotime:latest
```

In v0.18.0, `defaultSandboxImage` applies to sandboxes without a harness.
Coding harnesses use their own images; this setting does not add these tools
to the built-in Claude Code or Codex images.

To prefer fish in interactive shell panes, run this in your local fish shell:

```fish
set -gx DISCOBOX_SHELL fish
```
