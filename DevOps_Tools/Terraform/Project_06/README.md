# DevOps_Proj06
## Table of contents
- [DevOps_Proj06](#devops_proj04)
  - [Table of contents](#table-of-contents)
  - [Project Overview](#project-overview)
  - [Topology](#Topology)
  - [Known issues](#known-issues)
  - [Cleanup (Todos)](#Cleanup-(Todos))
  - [Project's status](#projects-status)


## Project Overview
TBD


## Topology
TBD

<!-- <br><kbd>
  <img style="display: block;margin-left: auto;margin-right: auto; width: 50%; height: 50%;" src="https://github.com/gy-m/DevOps/blob/main/Terraform/Project_05/Documentation/Topology.svg">
</kbd><br> -->


## Known Issues
TODO: Should be updated

Was not found a way to add "Target" association, in the "Inbound NAT rules" of both of the LoadBalancers. Therefore, this must be done manually:
1. LB GW - Navigate to "Inbound NAT rules" and edit the existing rule, so the "Target" Will be "VM-APP-01"
1. LB Middle - Navigate to "Inbound NAT rules" and edit the existing rule, so the "Target" Will be "VM-DB-01"


## Cleanup (Todos)
TBD


## Project's status
In progress