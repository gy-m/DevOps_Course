# DevOps_Proj06
## Table of contents
- [DevOps_Proj06](#devops_proj04)
  - [Table of contents](#table-of-contents)
  - [Project Overview](#project-overview)
  - [Topology](#Topology)
  - [Environments](#Environments)  
  - [Cleanup (Todos)](#Cleanup-(Todos))
  - [Project's status](#projects-status)


## Project Overview
This project is identical to Project 05, except the usage of Ansible for deploying the app and configurations of VM-APP servers and the VM-DB server.
In addition, this project consist of the topology which is built using terraform (Terraform/Project_06).


## Topology

<br><kbd>
  <img style="display: block;margin-left: auto;margin-right: auto; width: 50%; height: 50%;" src="https://raw.githubusercontent.com/gy-m/DevOps_Course/651cdbbc21d1795358ac830ba1d4f573f4d3474a/DevOps_Tools/Terraform/Project_06/Documentation/Topology.svg">
</kbd><br>

## Environments
The environments will be "Staging" and "Production", thus there are 2 main folders, which both of them using "Modules" folder:
1. Env_Staging
2. Env_Production
For every environment to be build, there is a need to run terraform inside every one of them. The only differenct is the resourse group name ("PRoject_06_Staging" for the staging environment, and "Project_06_Production" for the production environment)

<img style="display: block;margin-left: auto;margin-right: auto; width: 50%; height: 50%;" src="https://raw.githubusercontent.com/gy-m/DevOps_Course/main/DevOps_Tools/Terraform/Project_06/Documentation/Architecture.jpeg">
</kbd><br>


## Cleanup (Todos)
* VM-APPS machines should be linux VMs, but terraform (Project_06) builds windows VMs, so there is a need to replace them manuaaly to linux, or fix the code of Terraform.
* Config and host files are copied to home directory using pipeline due to problem which leads to default config be recognized instead of custome config.
* Using pipeline leads to unrecognition the hosts mentioned in the hosts file.
* Production play book is empty, because it should be the same as Staging playbook and both of the should be in the same general file.


## Project's status
Testing:
* Testing Playbook using manual commands inside the slave (instead of using the pipeline)
* Fixing the issues mentioned under "Cleanup" section