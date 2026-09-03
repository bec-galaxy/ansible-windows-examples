# Documentation

Documentation on setting up the environment, as well as commands used in the playbooks.

## Setup environment

Create python environment with a specific ansible version.

```shell
# Login to registry
podman login registry.redhat.io

# https://catalog.redhat.com/en/software/containers/ansible-automation-platform-27/ee-supported-rhel9/69fb1e41580272b336c0edd1

# Get excecution environment and print ansible-core version
podman run --rm registry.redhat.io/ansible-automation-platform-27/ee-supported-rhel9:latest python3 -m pip freeze | grep ansible-core

# Install dnf packages
dnf install python3.12 python3.12-devel

# Create and select a python environment in vscode
# CTL + P and > Python: Create environment and use .venv

# Install python packages
python -m pip install ansible-core==2.x.x ansible-lint

# Install collections
ansible-galaxy collection install ansible.windows
```

## Authentication

Copy your ssh-key to the server.

## Ansible Playbook

Run a playbook with `ansible-playbook`.

```shell
ansible-playbook playbook_print.yml -i inventory/inventory.yml
```

> Inventory: Split Windows and Linux inventories, Windows need the additional attribute `ansible_shell_type=cmd`.

## Ansible Navigator

Run a playbook in a container with `ansible-navigator`.

```shell
ansible-navigator run playbook_print.yml -i inventory/inventory.yml
```

`ansible-navigator.yml`:
```
---
ansible-navigator:
  mode: stdout

  execution-environment:
    enabled: true
    image: my-ee-url:latest
    container-engine: podman
    pull:
      policy: missing

  logging:
    level: critical
    file: /dev/null

  playbook-artifact:
    enable: false
```

## Vault

Set up a shared Vault key and define it as the default.

```shell
# Create vault file in home directory
vim ~/.password_team.vault

# Add variable to .bashrc or .zshrc
export ANSIBLE_VAULT_IDENTITY_LIST="team@~/.password_team.vault"

# Source file
source ~/.bashrc

# Encrypt a string
ansible-vault encrypt_string --vault-id team@~/.password_team.vault

# Use other id´s
ansible-vault encrypt_string --vault-id dev@~/.password_dev.vault
ansible-vault encrypt_string --vault-id prod@~/.password_prod.vault
ansible-vault encrypt_string --vault-id prod@prompt
```
