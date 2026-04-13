# MYDOMAIN execution environment

Default execution environment for my domain.

## Changes

The following changes were made to the image:

- Added placeholder root certificates
- Added placeholder intermediate certificates
- Added `ansible.cfg` with private automation hub urls
- Added `pip.conf` for placeholder python repository
- Added `ubi.repo` rpm package repository
- Added python packages for infrastructure components eg. _infoblox_, _gitlab_ or _hashicorp_vault_
- Added dnf `jq` package for pipeline jobs.

No collections are pre-installed, these are installed via Automation Platform when a playbook is started. So the container does not contain any outdated collections.

## Build

To build the container local e.g. testing or debugging, these commands can be used:

```shell
# Create
ansible-builder build --tag="automation-hub.my.domain/my-rhel9-debug:latest" --extra-build-cli-args="--pull" --verbosity="3"

# Attach
podman run --user=root -it automation-hub.my.domain/my-rhel9-debug:latest /bin/sh

# Publish
podman push automation-hub.my.domain/my-rhel9-debug:latest
```

See `.gitlab-ci.yml` for more information.
