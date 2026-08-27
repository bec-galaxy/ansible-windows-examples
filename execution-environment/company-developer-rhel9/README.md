# Company execution environment

Developer execution environment for company infrastructure.

## Changes

The following changes were made to the image:

- Added podman-in-podman support
- Added system packages for developer eg. _iputils_, _rpmdevtools_, _make_, _jq_
- Added python packages for developer eg. _ansible-dev-tools_ and _ansible-lint_

No collections are pre-installed, these are installed via Automation Platform when a playbook is started. So the container does not contain any outdated collections.

## Documentation

Useful information and notes about the `execution-environment.yml` file.

### Base image

The container uses `company-supported-rhel9` as its base image.

[Click here](https://example.com/execution_environments/company-supported-rhel9) to see more information about the base.

### Support for buildah

This image can be used to build containers in Pipelines. It uses the alternative buildah mode with `BUILDAH_ISOLATION=chroot`.

Further information:
https://www.redhat.com/en/blog/building-buildah

## Build

To build the container local for testing or debugging, these commands can be used:

```shell
# Clean
rm -drf ./context

# Create
ansible-builder build --tag="localhost/localhost/company-developer-rhel9:latest" --context="./context" --verbosity="3"

# Run
podman run -it --rm localhost/company-developer-rhel9:latest /bin/bash
```

> The clean step is important: if a package is removed from the `execution-environment.yml` file, the package remains in the context cache and causes inconsistent build results.

See `.gitlab-ci.yml` for more information.
