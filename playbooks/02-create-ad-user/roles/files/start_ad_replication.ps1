#
# Starts a cross-site AD replication.
#
[CmdletBinding(SupportsShouldProcess)]
param (
)

if ($Ansible.Verbosity -ge 3) {
    $VerbosePreference = "Continue"
}

$server = (Get-ADDomainController).HostName
$partition = (Get-ADDomainController).DefaultPartition

Write-Output "Replicate AD objects from server $server with partition $partition to all servers."

if ($Ansible.CheckMode) {
    Write-Output "Running in check mode, get only the replication status."

    # Incorrect permissions result in an error here:
    $output = repadmin /showrepl /errorsonly
    $count = $output | Measure-Object -Line

    # Error codes are not used consistently by the tool.
    if ($LastExitCode -eq 234 -and $count.Lines -eq 7) {
        Write-Output "Replication check successfully."

    } else {
        $Ansible.Failed = $true
        $Ansible.Result = 1

        Write-Output "Replication check failed with errors, see message_data for details."
    }

} else {
    #
    # Parameters
    #
    # /P = Pushes changes outward from the specified domain controller.
    # /e = Synchronizes domain controllers across all sites in the enterprise.
    # /d = Identifies servers by distinguished name in messages.
    #
    $output = repadmin /syncall $server /PeD $partition

    $Ansible.Changed = $true

    # Error codes are not used consistently by the tool.
    if ($LastExitCode -eq 0 -and $output -like "SyncAll terminated with no errors.") {
        Write-Output "Replication successfully."

    } else {
        $Ansible.Failed = $true
        $Ansible.Result = 2

        Write-Output "Replication failed with errors, see message_data for details."

    }
}

Write-Information -MessageData $output -Tags "repadmin"
