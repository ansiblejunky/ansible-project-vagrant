# Vagrant against Linux and Windows

POC to use Vagrant for spinning up both a Linux and Windows server to test various Ansible and Powershell provisioning scripts.  

It requires the following products:

- vagrant
- ansible
- virtualbox
- pywinrm (required python module for Ansible to access Windows machines)

I always recommend creating a Python virtual environment for Ansible and its various required modules. This makes it easier to create, test and play with without harming or affecting your system Python installation.

`vagrant up` will get you started. Just be aware that Windows vagrant boxes are large and also take a lot more time to spin up than Linux boxes. However, if you are writing Ansible roles/playbooks that need to support both windows and linux then this would work well for you.

## Ansible - Windows Remote Management

For more information on using Ansible to manage Windows machines see this site [here](https://docs.ansible.com/ansible/latest/user_guide/windows_winrm.html). You should understand the authentication options - Basic, NTLM, Kerberos and CredSSP.

The [following PowerShell script](https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1) can be used to prepare a Windows image so it can be easily targeted using Ansible.

You will find a lot of great resources from [this repository](https://github.com/jborean93/ansible-windows/tree/master/vagrant).

For older Windows systems, you might consider upgrading the PowerShell version that is installed, since Ansible requires a minimal version. This instructions can be found [here](https://docs.ansible.com/ansible/latest/user_guide/windows_setup.html#upgrading-powershell-and-net-framework).

## Mac OSX

When running this on a Mac, you will notice there is an environment variable set inside the Vagrantfile which helps avoid a [known problem](https://github.com/ansible/ansible/issues/32499#issuecomment-342389957) that causes Python to crash when you try to run the Ansible provisioner. 

If you additionally attempt to run Ansible against a running vagrant box, you will need to set the environment variable somewhere outside the Vagrantfile (since it's not used in this case). For example, simply set it on the shell before running Ansible commands:

```bash
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
```
