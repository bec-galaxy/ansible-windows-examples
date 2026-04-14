# Disk Role for Ansible

This role can be used to format hard disks on a managed Windows machine.

## Variables

Default variables in this playbook.

| Name                | Description                           | Default Value |
| ------------------- | ------------------------------------- | ------------- |
| `disk_partitions`   | Array with partition configurations.  | ` `           |

## Attributes

Properties in the `disk_partitions` array:

| Name             | Type     |
| ---------------- | -------- |
| `name`           | `string` |
| `sizeGb`         | `int`    |
| `scsiController` | `string` |
| `provisionType`  | `string` |
| `letter`         | `string` |
| `unitNumber`     | `int`    |
| `persistent`     | `bool`   |
| `blockSize`      | `int`    |
| `raid`           | `int`    |

## Example

Example values for a `disks` array:

```
disk_partitions:
  - name: Mein Laufwerk D
    sizeGb: 10
    scsiController: SCSI_Controller_0
    provisionType: thin
    letter: D
    unitNumber: 1
    persistent: false
    blockSize: 4
    raid: 5
  - name: Mein Laufwerk F
    sizeGb: 10
    scsiController: SCSI_Controller_0
    provisionType: thin
    letter: F
    unitNumber: 2
    persistent: false
    blockSize: 4
    raid: 5
  - name: Mein Laufwerk N
    sizeGb: 10
    scsiController: SCSI_Controller_0
    provisionType: thin
    letter: 'N'
    unitNumber: 3
    persistent: false
    blockSize: 4
    raid: 5
```
