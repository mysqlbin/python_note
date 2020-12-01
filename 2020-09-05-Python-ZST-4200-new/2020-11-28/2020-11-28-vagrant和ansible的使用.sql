

https://www.cnblogs.com/shenjianping/p/12232176.html  基于VirtualBox和Vagrant搭建虚拟机

https://blog.csdn.net/u013866352/article/details/105413717  Vagrant-新增-root-用户


主控机：192.168.0.44
被控机：192.168.0.45


C:\Users\Administrator\Desktop
λ vagrant -v
Vagrant 2.2.6



vagrant box add my-box vagrant-centos-7.box
vagrant box add my-box vagrant-centos-7.2.box

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




[root@localhost pip-8.0.2]# pip3 install ansible
	
	出现的错误1：

		distutils.errors.DistutilsError: Setup script exited with error: command 'gcc' failed with exit status 1
		
		----------------------------------------
		Command "python setup.py egg_info" failed with error code 1 in /tmp/pip-build-sm694z3n/cryptography
		You are using pip version 8.0.2, however version 20.2.4 is available.
		You should consider upgrading via the 'pip install --upgrade pip' command.

		-- pip3 install --upgrade pip
		
		
	出现的错误2：
	
		File "/usr/local/lib/python3.6/site-packages/pip/_vendor/requests/packages/urllib3/response.py", line 237, in _error_catcher
		raise ReadTimeoutError(self._pool, None, 'Read timed out.')
		pip._vendor.requests.packages.urllib3.exceptions.ReadTimeoutError: HTTPSConnectionPool(host='files.pythonhosted.org', port=443): Read timed out.


	pip3 --default-timeout=1800 install -i https://pypi.tuna.tsinghua.edu.cn/simple ansible

	自己的电脑
		[root@localhost Python-3.6.4]#  ansible --version
		ansible 2.10.3
		config file = None
		configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
		ansible python module location = /usr/local/lib/python3.6/site-packages/ansible
		executable location = /usr/local/bin/ansible
		python version = 3.6.4 (default, Nov 29 2020, 15:51:31) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]

	公司的电脑
		[root@localhost vagrant]# ansible --version
		ansible 2.10.3
		  config file = None
		  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
		  ansible python module location = /usr/local/lib/python3.6/site-packages/ansible
		  executable location = /usr/local/bin/ansible
		  python version = 3.6.4 (default, Nov 30 2020, 08:52:21) [GCC 4.8.5 20150623 (Red Hat 4.8.5-4)]
	
  
需要配置SSH进行通信	
	
	[root@localhost ansible]# vim hosts

	[test]
	192.168.1.27
		
	[root@localhost ansible]# ansible test -m ping
	The authenticity of host '192.168.1.27 (192.168.1.27)' can t be established.
	ECDSA key fingerprint is SHA256:8oX7cJnno8AFyt6PSm4aqPmK5IVSGn07igAWkamaNlg.
	ECDSA key fingerprint is MD5:1b:ad:b4:b1:33:e7:b5:c6:81:0f:3a:82:bf:36:59:e3.
	Are you sure you want to continue connecting (yes/no)? yes
	192.168.1.27 | UNREACHABLE! => {
		"changed": false,
		"msg": "Failed to connect to the host via ssh: Warning: Permanently added '192.168.1.27' (ECDSA) to the list of known hosts.\r\nPermission denied (publickey,gssapi-keyex,gssapi-with-mic,password).",
		"unreachable": true
	}



建立ssh信任机制

	需要切换到vagrant用户
	
	在 192.168.0.44 使用 ssh-keygen 生成 key:
		shell> ssh-keygen # 之后一路回车就行了。最后会在~/.ssh 下面产生： id_rsa id_rsa.pub 两个文件。
	生成信任文件：
		shell> cd ~/.ssh/
		shell> cat id_rsa.pub >authorized_keys
		shell> chmod 600 *
	
	
		[vagrant@localhost .ssh]$ ll
		total 16
		-rw------- 1 vagrant vagrant  389 Nov 30 08:28 authorized_keys
		-rw------- 1 vagrant vagrant 1679 Dec  1 03:50 id_rsa
		-rw------- 1 vagrant vagrant  411 Dec  1 03:50 id_rsa.pub
		-rw-r--r-- 1 vagrant vagrant  174 Dec  1 03:51 known_hosts
		[vagrant@localhost .ssh]$ chmod 600 *
		[vagrant@localhost .ssh]$ ll
		total 16
		-rw------- 1 vagrant vagrant  389 Nov 30 08:28 authorized_keys
		-rw------- 1 vagrant vagrant 1679 Dec  1 03:50 id_rsa
		-rw------- 1 vagrant vagrant  411 Dec  1 03:50 id_rsa.pub
		-rw------- 1 vagrant vagrant  174 Dec  1 03:51 known_hosts
	
	操作 192.168.0.45 的步骤
		1. 把 id_rsa.pub 上传到 /home/vagrant/.ssh 目录下
		2. 不小心把 authorized_keys 文件 也删除了
		3. chmod 600 *
		4. 接着，执行 cat id_rsa.pub >> authorized_keys 命令	
		5. chmod 600 *
		
	接着在 44 执行	
		[vagrant@localhost .ssh]$ ssh vagrant@192.168.0.45
		
		[vagrant@localhost ~]$ exit
		logout
		Connection to 192.168.0.45 closed.
		[vagrant@localhost .ssh]$ ip addr show
		1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN 
			link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
			inet 127.0.0.1/8 scope host lo
			   valid_lft forever preferred_lft forever
			inet6 ::1/128 scope host 
			   valid_lft forever preferred_lft forever
		2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
			link/ether 08:00:27:6c:3e:95 brd ff:ff:ff:ff:ff:ff
			inet 192.168.0.44/24 brd 192.168.0.255 scope global dynamic enp0s3
			   valid_lft 609387sec preferred_lft 609387sec
			inet6 fe80::a00:27ff:fe6c:3e95/64 scope link 
			   valid_lft forever preferred_lft forever
		[vagrant@localhost .ssh]$ 


		
	https://www.linuxprobe.com/linux-ssh-keygen.html   Linux下配置SSH免密通信 – "ssh-keygen"的基本用法



看看主控机是否可以远程操作被控机
	
	[vagrant@localhost ansible]$ ansible test -m ping
	192.168.0.45 | SUCCESS => {
		"ansible_facts": {
			"discovered_interpreter_python": "/usr/bin/python"
		},
		"changed": false,
		"ping": "pong"
	}



ansible-playbook test.yml
	
	[root@localhost ansible]# cat test.yml 
	# 这个是你选择的主机，对应 hosts 文件中的 [test]
	- hosts: test  
	  # 这个是变量
	  vars: 
		mysql_port: 80
	  # 这是要执行的操作
	  tasks:
	  - name: who am i
		command: touch /tmp/mysql_{{mysql_port}}.tmp

	[vagrant@localhost ansible]$ ansible-playbook test.yml

	PLAY [test] ************************************************************************************************************************************************************************************************************************************

	TASK [Gathering Facts] *************************************************************************************************************************************************************************************************************************
	ok: [192.168.0.45]

	TASK [who am i] ********************************************************************************************************************************************************************************************************************************
	[WARNING]: Consider using the file module with state=touch rather than running 'touch'.  If you need to use command because file is insufficient you can add 'warn: false' to this command task or set 'command_warnings=False' in ansible.cfg
	to get rid of this message.
	changed: [192.168.0.45]

	PLAY RECAP *************************************************************************************************************************************************************************************************************************************
	192.168.0.45               : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  





编辑文件用 root 账号，执行 ansible 命令用 vagrant 账号。 


https://zhuanlan.zhihu.com/p/33945958   Ansible使用及YAML语法介绍
https://zhuanlan.zhihu.com/p/162698360  Ansible原理架构及常用模块详解


https://fungleo.blog.csdn.net/article/details/50914519    centos7 yum 更新出现 [Errno 14] HTTP Error 404 - Not Found 的解决方法

		
https://www.cnblogs.com/shenjianping/p/11283597.html   vue生命周期

						  
						  
						  
						  