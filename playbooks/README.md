# Ansible Playbooks

Connect to Windows servers.

## Preparation

Install the OpenSSH server under Windows with the following commands:

```ps1
$source = "D:\LanguagesAndOptionalFeatures"

#
# Install features
#
Add-WindowsCapability -Online -Name "OpenSSH.Client~~~~0.0.1.0" -Source $source
Add-WindowsCapability -Online -Name "OpenSSH.Server~~~~0.0.1.0" -Source $source

Get-WindowsCapability -Online -Name "OpenSSH.*"

#
# Enable and start the service
#
Set-Service -Name "sshd" -StartupType 'Automatic'
Start-Service "sshd"
```

> Feature on Demand packages are available on offline media or can downloaded from WSUS without the source parameter.

If you have problems with the installation, use the [latest MSI (Preview)](https://github.com/PowerShell/Win32-OpenSSH/releases) package from microsoft.

## Configuration

The system-wide configuration file is located under `%programdata%\ssh\ssh_config`, restart the service after changes.

```ps1
Restart-Service "sshd"
```

Documentation: [OpenSSH Server configuration for Windows Server](https://learn.microsoft.com/en-us/windows-server/administration/OpenSSH/openssh-server-configuration) and [Windows SSH Setup for Ansible](https://docs.ansible.com/ansible/latest/os_guide/windows_setup.html#windows-ssh-setup).
