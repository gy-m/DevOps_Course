# DevOps_Proj05
## Table of contents
- [DevOps_Proj05](#devops_proj04)
  - [Table of contents](#table-of-contents)
  - [Project Overview](#project-overview)
  - [Topology](#Topology)
  - [Known issues](#known-issues)
  - [Cleanup (Todos)](#Cleanup-(Todos))
  - [Project's status](#projects-status)


## Project Overview
This project demonstrated the use of Jenkins, by creating 2 Jenkins agents (in addition to the mastr Jenkins), which will create CI (agent_ci) and CD (agent_cd), and controlled by 2 Jenkinsfiles: Jenkinsfile_CI, and Jenkinsfile_CD. Both of them located in the application repository: https://github.com/gy-m/DevOps_WeightTracker


## Topology

<br><kbd>
  <img style="display: block;margin-left: auto;margin-right: auto; width: 50%; height: 50%;" src="https://github.com/gy-m/DevOps/blob/main/CICD/Jenkins/Project_05/Documentation/Topology.svg">
</kbd><br>


## Known Issues
1. ZIP does not unzipes the .env file, which is created by the CI process. There is a need to fix it, and then the creation of the env file in the CD can be deleted

Was not found a way to add "Target" association, in the "Inbound NAT rules" of both of the LoadBalancers. Therefore, this must be done manually:
* LB GW - Navigate to "Inbound NAT rules" and edit the existing rule, so the "Target" Will be "VM-APP-01"
* LB Middle - Navigate to "Inbound NAT rules" and edit the existing rule, so the "Target" Will be "VM-DB-01"


## Cleanup (Todos)
In progress for issue number 1


## Project's status
Beta (Before cleanup)