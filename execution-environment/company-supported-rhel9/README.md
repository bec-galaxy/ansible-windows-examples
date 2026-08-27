# Company execution environment

Supported execution environment for company infrastructure.

## Changes

The following changes were made to the image:

- Added company root certificates
- Added company intermediate certificates
- Added `ansible.cfg` with private automation hub urls
- Added `pip.conf` for artifactory python repository
- Added `krb5.conf` for kerberos support
- Added `artifactory.repo` and other rpm package repositories
- Added python packages for _Kerberos_ support
- Added python packages for infrastructure components eg. _infoblox_, _gitlab_ or _hashicorp_vault_

No collections are pre-installed, these are installed via Automation Platform when a playbook is started. So the container does not contain any outdated collections.

## Documentation

Useful information and notes about the `execution-environment.yml` file.

### Ansible version

The Ansible version is already installed in the Red Hat execution environment. It also includes the python package `awxkit`, which can be used to launch jobs with the terminal on the Ansible Automation Controller. Some pipeline jobs require the latest version of `awxkit`.

[Click here](https://docs.ansible.com/projects/ansible/latest/reference_appendices/release_and_maintenance.html#ansible-core-support-matrix) to see the supported Ansible versions.

### Kerberos

The Kerberos libraries are included in the default execution environment; the packages `gcc`, `krb5-libs`, `krb5-devel`, `krb5-workstation` and `python3.<version>-devel` are required to build the python module `pyspnego[kerberos]`. The attribute `[compile platform:rpm]` means that these packages are not included in the final image. Ansible-builder uses multiple stages for the build; the packages compiled in this temporary stage are then copied into the final image.

### Repositories

Since the environment is air-gapped, custom Artifactory repositories for RPM and python packages have been set up.

The service account to access there repositories, is a public account that can also be used by customers. It uses a long-lived token; this account cannot be used to log in to Artifactory. The repositories are hosted as mirrors in Artifactory, which packages are available is configured there.

### Files

When copying files, make sure that folders are assigned permissions of `755` and files are assigned permissions of `644`. If folder trees containing files are copied using the `COPY` command, the directories will lack the `x/list` permission, and non-root users will not be able to read these configuration files. If a folder does not exist in the image, it must first be explicitly created with permissions set to `755`.

### User

The default user in this container has the UID 1000. This affects other services; Ansible Builder sets this user by default using the `USER` keyword in the Containerfile.

## Build

To build the container local for testing or debugging, these commands can be used:

```shell
# Clean
rm -drf ./context

# Build
ansible-builder build --tag="localhost/company-supported-rhel9:latest" --context="./context" --verbosity="3"

# Run
podman run -it --rm localhost/company-supported-rhel9:latest /bin/bash
```

> The clean step is important: if a package is removed from the `execution-environment.yml` file, the package remains in the context cache and causes inconsistent build results.

See `.gitlab-ci.yml` for more information.
