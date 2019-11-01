# Vagrant against Linux and Windows

POC to use Vagrant for spinning up both a Linux and Windows server to test various Ansible and Powershell provisioning scripts.  

It requires the following products:

- vagrant
- ansible
- virtualbox
- pywinrm (required python module for Ansible to access Windows machines)

I always recommend creating a Python virtual environment for Ansible and its various required modules. This makes it easier to create, test and play with without harming or affecting your system Python installation.

`vagrant up` will get you started. Just be aware that Windows vagrant boxes are large and also take a lot more time to spin up than Linux boxes. However, if you are writing Ansible roles/playbooks that need to support both windows and linux then this would work well for you.

