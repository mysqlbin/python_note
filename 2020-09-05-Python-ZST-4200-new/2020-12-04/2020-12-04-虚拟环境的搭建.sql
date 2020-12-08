https://blog.csdn.net/sdwang198912/article/details/86738452   Django开发总结-（一）Vagrant虚拟环境搭建



vagrant box add my-box4 vagrant-centos-7.2.box

mkdir centos-new4 && cd centos-new4


vagrant init my-box4


vagrant up				
	E:\centos\centos-new4
	λ vagrant up
	Bringing machine 'default' up with 'virtualbox' provider...
	==> default: Importing base box 'my-box4'...
	==> default: Matching MAC address for NAT networking...
	==> default: Setting the name of the VM: centos-new4_default_1607396696536_48070
	==> default: Fixed port collision for 22 => 2222. Now on port 2200.
	==> default: Clearing any previously set network interfaces...
	==> default: Preparing network interfaces based on configuration...
		default: Adapter 1: nat
	==> default: Forwarding ports...
		default: 22 (guest) => 2200 (host) (adapter 1)
	==> default: Booting VM...
	==> default: Waiting for machine to boot. This may take a few minutes...
		default: SSH address: 127.0.0.1:2200
		default: SSH username: vagrant
		default: SSH auth method: private key
		default: Warning: Connection reset. Retrying...
		default: Warning: Connection aborted. Retrying...
		default: Warning: Remote connection disconnect. Retrying...
		default:
		default: Vagrant insecure key detected. Vagrant will automatically replace
		default: this with a newly generated keypair for better security.
		default:
		default: Inserting generated public key within guest...
		default: Removing insecure key from the guest if its present...
		default: Key inserted! Disconnecting and reconnecting using new SSH key...
	==> default: Machine booted and ready!
	==> default: Checking for guest additions in VM...
		default: The guest additions on this VM do not match the installed version of
		default: VirtualBox! In most cases this is fine, but in rare cases it can
		default: prevent things such as shared folders from working properly. If you see
		default: shared folder errors, please make sure the guest additions within the
		default: virtual machine match the version of VirtualBox you have installed on
		default: your host and reload your VM.
		default:
		default: Guest Additions Version: 4.3.30
		default: VirtualBox Version: 5.2
	==> default: Mounting shared folders...
		default: /home/vagrant/src => E:/centos/centos-new4/data/src
		default: /home/vagrant/software => E:/centos/centos-new4/data/software

vagrant ssh




sudo passwd root


安装Python3

Linux 安装pipenv

	pip3 install pipenv -i https://pypi.tuna.tsinghua.edu.cn/simple
	
安装ansible
	pip3 --default-timeout=1800 install -i https://pypi.tuna.tsinghua.edu.cn/simple ansible

	[root@localhost Python-3.6.4]# ansible --version
	ansible 2.10.3
	  config file = None
	  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
	  ansible python module location = /usr/local/lib/python3.6/site-packages/ansible
	  executable location = /usr/local/bin/ansible
	  python version = 3.6.4 (default, Dec  8 2020, 03:48:34) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]
	  
	 













