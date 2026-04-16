#
# Change letter from CD-ROM.
#
# From:
#  - Patrick Becker <mail@my.domain>
#
[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String]
    $letter
)

if($Ansible.Verbosity -ge 3) {
    # https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_powershell_module.html#notes
    $VerbosePreference = "Continue"
}
$Ansible.Changed = $false

$cdrom = Get-CimInstance -ClassName Win32_Volume -Filter 'DriveType=5'
$count = ($cdrom | Measure-Object).Count

if ($count -eq 0) {
    Write-Error "No CDROM drive was found."
}
if ($count -ne 1) {
    Write-Error "More then one CDROM drive was found."
}

Write-Verbose "CDROM drive with letter $($cdrom.drive) found."

if ($cdrom.drive -ne $letter) {
    if ($Ansible.CheckMode -eq $false) {
        $cdrom | Set-CimInstance -Property @{DriveLetter=$letter}
    }

    Write-Output "CDROM drive letter changed to $letter."
    $Ansible.Changed = $true
}
