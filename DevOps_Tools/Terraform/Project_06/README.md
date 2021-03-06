# DevOps_Proj06
## Table of contents
- [DevOps_Proj06](#devops_proj06)
  - [Table of contents](#table-of-contents)
  - [Project Overview](#project-overview)
  - [Topology](#topology)
  - [Environments](#environments)
  - [Known Issues](#known-issues)
  - [Cleanup (Todos)](#cleanup-todos)
  - [Project's status](#projects-status)


## Project Overview
This project is identical to Project 05, except the usage of Ansible for deploying the app and configurations of VM-APP servers and the VM-DB server.


## Topology

<br><kbd>
  <img style="display: block;margin-left: auto;margin-right: auto; width: 50%; height: 50%;" src="https://raw.githubusercontent.com/gy-m/DevOps_Course/651cdbbc21d1795358ac830ba1d4f573f4d3474a/DevOps_Tools/Terraform/Project_06/Documentation/Topology.svg">
</kbd><br>


## Environments
The environments will be "Staging" and "Production", thus there are 2 main folders, which both of them using "Modules" folder:
1. Env_Staging
2. Env_Production
For every environment to be build, there is a need to run terraform inside every one of them. The only differenct is the resourse group name ("PRoject_06_Staging" for the staging environment, and "Project_06_Production" for the production environment).

Please note you should create "terraform.tfvars" file which must contain your secrets in the following format (without the bullets):
* admin_username_VM_APP = "<your user name>"
* admin_password_VM_APP = "<your password>"
* admin_username_VM_DB = "<your user name>"
* admin_password_VM_DB = "<your password>"

<img style="display: block;margin-left: auto;margin-right: auto; width: 50%; height: 50%;" src="https://raw.githubusercontent.com/gy-m/DevOps_Course/main/DevOps_Tools/Terraform/Project_06/Documentation/Architecture.jpeg">
</kbd><br>


## Known Issues
Because this is an Ansible project, the issues will be in the Readme file under "Ansible/Project_06" folder


## Cleanup (Todos)
Please refer to the Readme file under "Ansible/Project_06" folder


## Project's status
Please refer to the Readme file under "Ansible/Project_06" folder