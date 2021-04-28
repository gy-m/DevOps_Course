# DevOps_Proj04
## Table of contents
- [DevOps_Proj04](#devops_proj04)
  - [Table of contents](#table-of-contents)
  - [Project Overview](#project-overview)
  - [Topology](#Topology)
  - [Known issues](#known-issues)
  - [Cleanup (Todos)](#Cleanup-(Todos))
  - [Project's status](#projects-status)


## Project Overview
This projects build the infrastructure of the WeightTracker App application (which can be found in WeightApp folder) using Terraform with Azure.
 Note - The configurations of the servers must be done manually


## Topology
* General Topology:

<br><kbd>
  <img style="display: block;margin-left: auto;margin-right: auto; width: 50%; height: 50%;" src="https://github.com/gy-m/DevOps/blob/main/Terraform/Project_04/Documentation/Architecture.jpeg">
</kbd> <br>
* Detailed Topology (Azure):

<br><kbd>
  <img style="display: block;margin-left: auto;margin-right: auto; width: 50%; height: 50%;" src="https://github.com/gy-m/DevOps/blob/main/Terraform/Project_04/Documentation/Topology.svg">
</kbd><br>


## Known Issues
Was not found a way to add "Target" association, in the "Inbound NAT rules" of both of the LoadBalancers. Therefore, this must be done manually:
1. LB GW - Navigate to "Inbound NAT rules" and edit the existing rule, so the "Target" Will be "VM-APP-01"
1. LB Middle - Navigate to "Inbound NAT rules" and edit the existing rule, so the "Target" Will be "VM-DB-01"


## Cleanup (Todos)
No need for additional cleanups


## Project's status
Finished


## Notes
There is a need to find a way for:
* Allowing RDP connection to all the VMs - At the moment only VM_APP_01 is accessible using the RDP, and should find a way to use the LB_GW's IP to connect to other VM-APPs
* Coping Disks from Windows / Linux VMs to other Windows / Linux VMs. For this purpose snapshots and images were created but should be found a way to use it.