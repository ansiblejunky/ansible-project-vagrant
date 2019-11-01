# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Temporary workaround to Python bug in macOS High Sierra which can break Ansible
# https://github.com/ansible/ansible/issues/34056#issuecomment-352862252
# https://github.com/ansible/ansible/issues/32499#issuecomment-401191857
ENV["OBJC_DISABLE_INITIALIZE_FORK_SAFETY"] = "YES"

Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: "echo Hello"

  # LINUX MACHINE
  # ---------------------------------------------------------------------------------

  # To specify a default machine, just mark it primary when defining it. 
  # Only one primary machine may be specified.
  config.vm.define "linux", primary: true do |linux|
    linux.vm.box = "centos/7"
    linux.vm.provision "ansible" do |ansible|
      ansible.compatibility_mode = "auto"
      ansible.verbose = "v"
      ansible.playbook = "test.yml"
      #ansible.galaxy_roles_path = "../../"
      ansible.extra_vars = {
       mytestvar: true
      }
    end
  end

  # WINDOWS MACHINE
  # ---------------------------------------------------------------------------------

  # http://www.hurryupandwait.io/blog/in-search-of-a-light-weight-windows-vagrant-box
  # http://www.hurryupandwait.io/blog/creating-windows-base-images-for-virtualbox-and-hyper-v-using-packer-boxstarter-and-vagrant
 
  config.vm.define "windows" do |windows|

    # More examples https://github.com/jborean93/ansible-windows
    windows.vm.box = "jborean93/WindowsServer2016"
    windows.vm.communicator = :winrm
    windows.vm.guest = :windows
    windows.vm.boot_timeout = 400
    windows.winrm.username = "vagrant"
    windows.winrm.password = "vagrant"

    # RDP uses port 3389
    # MacOS: Install Remote Desktop to handle rdp protocol (https://brewinstall.org/Install-rdesktop-on-Mac-with-Brew/)
    #windows.vm.network :forwarded_port, guest: 3389, host: 3389, id: "msrdp", auto_correct: true
    #windows.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
    #windows.vm.network :forwarded_port, guest: 5986, host: 5986, id: "winrm", auto_correct: true
    windows.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = 2048
      vb.cpus = 2
    end

    # Provision using Powershell
    windows.vm.provision "shell", path: "provision.ps1"
    # Provision using Ansible
    windows.vm.provision "ansible" do |ansible|
      ansible.compatibility_mode = "auto"
      ansible.verbose = "vvv"
      ansible.playbook = "test.yml"
      #ansible.become = "true"
      #ansible.galaxy_roles_path = "../../"
      #ansible.inventory = "inventory"
      ansible.extra_vars = {
        ansible_connection: "winrm",
        ansible_winrm_transport: "ntlm",

        # http - https://docs.ansible.com/ansible/latest/user_guide/windows_winrm.html
        ansible_port: 55985,
        ansible_winrm_scheme: "http"

        # https - https://docs.ansible.com/ansible/latest/user_guide/windows_winrm.html
        #ansible_port: 55986,
        #ansible_winrm_server_cert_validation: "ignore",
        #ansible_winrm_scheme: "https"
      }
    end

  end

end
