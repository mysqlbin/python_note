

https://www.cnblogs.com/shenjianping/p/12232176.html  基于VirtualBox和Vagrant搭建虚拟机

https://blog.csdn.net/u013866352/article/details/105413717  Vagrant-新增-root-用户


C:\Users\Administrator\Desktop
λ vagrant -v
Vagrant 2.2.6



vagrant box add my-box vagrant-centos-7.box

	E:\centos7
	λ vagrant box add my-box vagrant-centos-7.box
	==> vagrant: A new version of Vagrant is available: 2.2.14 (installed version: 2.2.6)!
	==> vagrant: To upgrade visit: https://www.vagrantup.com/downloads.html

	==> box: Box file was not detected as metadata. Adding it directly...
	==> box: Adding box 'my-box' (v0) for provider:
		box: Unpacking necessary files from: file://E:/centos7/vagrant-centos-7.box
		box: Progress: 100% (Rate: 56.2M/s, Estimated time remaining: --:--:--)
	==> box: Successfully added box 'my-box' (v0) for 'virtualbox'!


mkdir centos-new && cd centos-new

	E:\centos7
	λ mkdir centos-new && cd centos-new

vagrant init my-box	
	
	
	E:\centos7\centos-new                                                    
	λ vagrant init my-box                                                    
	A `Vagrantfile` has been placed in this directory. You are now           	
	ready to `vagrant up` your first virtual environment! Please read        
	the comments in the Vagrantfile as well as documentation on              
	`vagrantup.com` for more information on using Vagrant.                   
												  

vagrant upgrade					
	E:\centos7\centos-new
	λ vagrant upgrade
	Usage: vagrant [options] <command> [<args>]

		-v, --version                    Print the version and exit.
		-h, --help                       Print this help.

	Common commands:
		 box             manages boxes: installation, removal, etc.
		 cloud           manages everything related to Vagrant Cloud
		 destroy         stops and deletes all traces of the vagrant machine
		 global-status   outputs status Vagrant environments for this user
		 halt            stops the vagrant machine
		 help            shows the help for a subcommand
		 init            initializes a new Vagrant environment by creating a Vagrantfile
		 login
		 package         packages a running vagrant environment into a box
		 plugin          manages plugins: install, uninstall, update, etc.
		 port            displays information about guest port mappings
		 powershell      connects to machine via powershell remoting
		 provision       provisions the vagrant machine
		 push            deploys code in this environment to a configured destination
		 rdp             connects to machine via RDP
		 reload          restarts vagrant machine, loads new Vagrantfile configuration
		 resume          resume a suspended vagrant machine
		 snapshot        manages snapshots: saving, restoring, etc.
		 ssh             connects to machine via SSH
		 ssh-config      outputs OpenSSH valid configuration to connect to the machine
		 status          outputs status of the vagrant machine
		 suspend         suspends the machine
		 up              starts and provisions the vagrant environment
		 upload          upload to machine via communicator
		 validate        validates the Vagrantfile
		 version         prints current and latest Vagrant version
		 winrm           executes commands on a machine via WinRM
		 winrm-config    outputs WinRM configuration to connect to the machine

	For help on any individual command run `vagrant COMMAND -h`

	Additional subcommands are available, but are either more advanced
	or not commonly used. To see all subcommands, run the command
	`vagrant list-commands`.

vagrant up				

	E:\centos7\centos-new
	λ vagrant up
	Bringing machine 'default' up with 'virtualbox' provider...
	==> default: Importing base box 'my-box'...
	==> default: Matching MAC address for NAT networking...
	==> default: Setting the name of the VM: centos-new_default_1606653299910_20721
	==> default: Vagrant has detected a configuration issue which exposes a
	==> default: vulnerability with the installed version of VirtualBox. The
	==> default: current guest is configured to use an E1000 NIC type for a
	==> default: network adapter which is vulnerable in this version of VirtualBox.
	==> default: Ensure the guest is trusted to use this configuration or update
	==> default: the NIC type using one of the methods below:
	==> default:
	==> default:   https://www.vagrantup.com/docs/virtualbox/configuration.html#default-nic-type
	==> default:   https://www.vagrantup.com/docs/virtualbox/networking.html#virtualbox-nic-type
	==> default: Clearing any previously set network interfaces...
	==> default: Preparing network interfaces based on configuration...
		default: Adapter 1: nat
	==> default: Forwarding ports...
		default: 22 (guest) => 2222 (host) (adapter 1)
	==> default: Booting VM...
	==> default: Waiting for machine to boot. This may take a few minutes...
		default: SSH address: 127.0.0.1:2222
		default: SSH username: vagrant
		default: SSH auth method: private key
		default:
		default: Vagrant insecure key detected. Vagrant will automatically replace
		default: this with a newly generated keypair for better security.
		default:
		default: Inserting generated public key within guest...
		default: Removing insecure key from the guest if it s present...
		default: Key inserted! Disconnecting and reconnecting using new SSH key...
	==> default: Machine booted and ready!
	==> default: Checking for guest additions in VM...
		default: No guest additions were detected on the base box for this VM! Guest
		default: additions are required for forwarded ports, shared folders, host only
		default: networking, and more. If SSH fails on this machine, please install
		default: the guest additions and repackage the box to continue.
		default:
		default: This is not an error message; everything may continue to work properly,
		default: in which case you may ignore this message.
	==> default: Rsyncing folder: /cygdrive/e/centos7/centos-new/ => /vagrant




https://www.cnblogs.com/shenjianping/p/11283597.html   vue生命周期						  