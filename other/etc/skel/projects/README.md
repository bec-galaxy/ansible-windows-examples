# Projects

Welcome to your project folder. Click `File -> Open Folder` in Visual Studio Code and select this `projects` folder to open a workspace.

## Configure Git
```
git config --global user.name ""
git config --global user.email ""
```

## SSH key

To use ssh git clone or push, create a new ssh key or use your existing key and store it under your profile: https://git.my.domain/-/user_settings/ssh_keys

## Configure Ansible (Virtual python environment)

This step is importend for ansible and other extensions to function properly.
Go to extensions and install the `ansible` plugin, this extension also installs the required python plugins.

Then switch in Visual Studio Code to the command line with `Ctl + P`. Enter the character `>` to display the global commands.
Now enter `Python: Create environments...`, use `venv` and select the latest Python version in the setup. (A workspace folder must be opened as described in the first step)

When you open a new terminal, this Python environment is now loaded automatically.
Use `pip install ansible-dev-tools ansible-lint` to install the required ansible python libs in this environment.

Reload the website once or exit and restart the Visual Studio Code application.
