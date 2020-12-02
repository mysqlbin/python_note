



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




ansible-playbook mysql_debug.yml
	
	copy=true
	
		主控机
			[vagrant@localhost ansible]$ ansible-playbook mysql_debug.yml

			PLAY [test] ************************************************************************************************************************************************************************************************************************************

			TASK [Gathering Facts] *************************************************************************************************************************************************************************************************************************
			ok: [192.168.0.45]

			TASK [install packages] ************************************************************************************************************************************************************************************************************************
			ok: [192.168.0.45]

			TASK [scp the mysql installer] *****************************************************************************************************************************************************************************************************************
			changed: [192.168.0.45]

			PLAY RECAP *************************************************************************************************************************************************************************************************************************************
			192.168.0.45               : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
				
			[root@localhost opt]# ll
			total 628704
			-rw-r--r-- 1 root root 643790848 Jun 14  2018 mysql-5.7.22-linux-glibc2.12-x86_64.tar.gz
			drwxr-xr-x 7 root root        76 Jan 27  2016 puppetlabs
			drwxr-xr-x 9 root root       137 Jan 27  2016 VBoxGuestAdditions-4.3.30


		被控机
		
			Tasks: 110 total,   2 running, 108 sleeping,   0 stopped,   0 zombie
			%Cpu(s):  2.4 us, 10.8 sy,  0.0 ni, 85.0 id,  0.0 wa,  0.0 hi,  1.8 si,  0.0 st
			KiB Mem :   629984 total,   292604 free,    65684 used,   271696 buff/cache
			KiB Swap:  1023996 total,  1023988 free,        8 used.   458996 avail Mem 

			  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                    
			22940 vagrant   20   0  141920   3824   1444 S  27.2  0.6   0:01.69 sshd 

			[root@localhost opt]# top
			top - 02:53:53 up 1 day, 16 min,  3 users,  load average: 0.91, 0.30, 0.14
			Tasks: 114 total,   4 running, 110 sleeping,   0 stopped,   0 zombie
			%Cpu0  : 12.2 us, 28.0 sy,  0.0 ni, 48.6 id, 10.5 wa,  0.0 hi,  0.7 si,  0.0 st
			%Cpu1  : 17.4 us, 14.4 sy,  0.0 ni, 55.5 id, 12.7 wa,  0.0 hi,  0.0 si,  0.0 st
			KiB Mem :   629984 total,    49556 free,    76616 used,   503812 buff/cache
			KiB Swap:  1023996 total,  1023988 free,        8 used.   446280 avail Mem 

			  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                    
			22499 root      20   0    4704    624    464 R  58.5  0.1   0:06.01 gzip  



			[root@localhost opt]# pwd
			/opt
			[root@localhost opt]# ll
			total 0
			drwxr-xr-x 9 root root 120 Dec  2 02:55 mysql-5.7.22-linux-glibc2.12-x86_64
			
			是在被控机端解压的。同时被控机端不保留 压缩文件 。
			
			
			
	copy=false
		
		TASK [scp the mysql installer] *****************************************************************************************************************************************************************************************************************
		fatal: [192.168.0.45]: FAILED! => {"changed": false, "msg": "Source '/opt/mysql-5.7.22-linux-glibc2.12-x86_64.tar.gz' does not exist"}

		PLAY RECAP *************************************************************************************************************************************************************************************************************************************
		192.168.0.45               : ok=2    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   



添加环境变量：
	echo $PATH
	echo "export PATH=$PATH:/usr/local/mysql/bin">>/etc/profile
	source /etc/profile  //让配置生效
	
	-- 这种方式在自动化中并不友好，因为 重复执行的时候，每次都会追加。
	



安装MySQL
	ansible-playbook mysql.yml
	
	[vagrant@localhost ansible]$ ansible-playbook mysql.yml
	[WARNING]: Invalid characters were found in group names but not replaced, use -vvvv to see details

	PLAY [mysql-master] ****************************************************************************************************************************************************************************************************************************

	TASK [Gathering Facts] *************************************************************************************************************************************************************************************************************************
	ok: [192.168.0.45]

	TASK [install packages] ************************************************************************************************************************************************************************************************************************
	ok: [192.168.0.45]

	TASK [create mysql group] **********************************************************************************************************************************************************************************************************************
	changed: [192.168.0.45]

	TASK [create mysql user] ***********************************************************************************************************************************************************************************************************************
	changed: [192.168.0.45]

	TASK [scp the mysql installer] *****************************************************************************************************************************************************************************************************************
	changed: [192.168.0.45]

	TASK [Move mysql-5.7.22-linux-glibc2.12-x86_64 to mysql] ***************************************************************************************************************************************************************************************
	changed: [192.168.0.45]

	TASK [Add mysql bin dir to $PATH.] *************************************************************************************************************************************************************************************************************
	changed: [192.168.0.45]

	TASK [mkdir root directory] ********************************************************************************************************************************************************************************************************************
	changed: [192.168.0.45]

	TASK [mkdir data directory] ********************************************************************************************************************************************************************************************************************
	changed: [192.168.0.45]

	TASK [mkdir logs directory] ********************************************************************************************************************************************************************************************************************
	changed: [192.168.0.45]

	TASK [mkdir tmp directory] *********************************************************************************************************************************************************************************************************************
	changed: [192.168.0.45]

	TASK [template my.cnf] *************************************************************************************************************************************************************************************************************************
	changed: [192.168.0.45]

	PLAY RECAP *************************************************************************************************************************************************************************************************************************************
	192.168.0.45               : ok=12   changed=10   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   


	[vagrant@localhost ansible]$ ansible-playbook mysql_install.yml 
	[WARNING]: Invalid characters were found in group names but not replaced, use -vvvv to see details

	PLAY [mysql-master] ****************************************************************************************************************************************************************************************************************************

	TASK [Gathering Facts] *************************************************************************************************************************************************************************************************************************
	ok: [192.168.0.45]

	TASK [install packages] ************************************************************************************************************************************************************************************************************************
	ok: [192.168.0.45]

	TASK [create mysql group] **********************************************************************************************************************************************************************************************************************
	ok: [192.168.0.45]

	TASK [create mysql user] ***********************************************************************************************************************************************************************************************************************
	changed: [192.168.0.45]

	TASK [scp the mysql installer] *****************************************************************************************************************************************************************************************************************
	changed: [192.168.0.45]

	TASK [Add mysql bin dir to $PATH.] *************************************************************************************************************************************************************************************************************
	changed: [192.168.0.45]

	TASK [mkdir root directory] ********************************************************************************************************************************************************************************************************************
	changed: [192.168.0.45]

	TASK [mkdir data directory] ********************************************************************************************************************************************************************************************************************
	changed: [192.168.0.45]

	TASK [mkdir logs directory] ********************************************************************************************************************************************************************************************************************
	changed: [192.168.0.45]

	TASK [mkdir tmp directory] *********************************************************************************************************************************************************************************************************************
	changed: [192.168.0.45]

	TASK [template my.cnf] *************************************************************************************************************************************************************************************************************************
	changed: [192.168.0.45]

	PLAY RECAP *************************************************************************************************************************************************************************************************************************************
	192.168.0.45               : ok=11   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

	

未完成和相关问题

	1. 数据库相关的目录创建出来
		配置文件：/etc/my.cnf
		/data  是一个单独挂载的一个分区
		datadir /data/mysql/mysql3306/data
		binlog  /data/mysql/mysql3306/logs
				/data/mysql/mysql3306/tmp
		mkdir /mydata/mysql/3306/{data,logs,tmp} -p
	
	2. templates 文件的优化。
	
	
	3. unarchive模块：owner和group不生效

编辑文件用 root 账号，执行 ansible 命令用 vagrant 账号。 


Ansible模式-Playbook
	playbook，就是一个剧本，定义了如何执行一个完整的配置管理、自动部署任务
	Playbooks：ansible的任务配置文件，将多个任务定义在剧中本，由ansible自动执行
	由多个模块组成，不同的模块有不同的功能
	
ansible常用模块详解	

	ping 模块
		ping模块尝尝用于检测网络是否通畅
		
	group 模块
		group用户在目标机器上创建/删除用户组

	user 模块
		user模块用户在目标主机上创建/删除用户

	copy 模块
		copy模块用户将文件拷贝到目标主机上
		参数解释：
			src=指定本地源文件
			dest=指定要复制到目标路径

	fetch 模块
		fetch模块主要作为为将远程主机文件复制到本地
		
	command 模块
		command模块主要是可以直接执行命令,command本身执行不使用shell来解析命令，所有输出的命令将作为原始命令输出	
		
	shell 模块
		shell模块比command模块功能强大，能完成command模块完成不了的任务，shell模块能够识别shell类型的命令	
		
		
	file 模块
		file模块主要为设定文件属性
		
	cron 模块
		cron模块主要是为目标主机来创建计划任务
		
	yum 模块
		yum模块主要是在目标主机上进行yum软件安装/卸载等操作	
		
	service 模块
		service模块主要用于管理linux主机上的服务	
		
	script 模块
		script模块主要在传输远程节点后运行本地脚本 	
	


	unarchive 模块
		用于解压文件，模块包含如下选项：
		常用参数
			copy：在解压文件之前，是否先将文件复制到远程主机，默认为yes。若为no，则要求目标主机上压缩包必须存在。
			creates：指定一个文件名，当该文件存在时，则解压指令不执行
			dest：远程主机上的一个路径，即文件解压的路径
			grop：解压后的目录或文件的属组
			list_files：如果为yes，则会列出压缩包里的文件，默认为no，2.0版本新增的选项
			mode：解决后文件的权限
			src：如果copy为yes，则需要指定压缩文件的源路径
			owner：解压后文件或目录的属主
			
		TASK [scp the mysql installer] *****************************************************************************************************************************************************************************************************************
		fatal: [192.168.0.45]: FAILED! => {"changed": false, "msg": "Unsupported parameters for (ansible.legacy.unarchive) module: grop Supported parameters include: attributes, creates, dest, exclude, extra_opts, group, keep_newer, list_files, mode, owner, remote_src, selevel, serole, setype, seuser, src, unsafe_writes, validate_certs"}
			
				
https://www.cnblogs.com/shenjianping/p/12232176.html  基于VirtualBox和Vagrant搭建虚拟机

https://blog.csdn.net/u013866352/article/details/105413717  Vagrant-新增-root-用户

https://zhuanlan.zhihu.com/p/162698360  Ansible原理架构及常用模块详解

https://fungleo.blog.csdn.net/article/details/50914519    centos7 yum 更新出现 [Errno 14] HTTP Error 404 - Not Found 的解决方法

https://www.cnblogs.com/shenjianping/p/11283597.html   vue生命周期

https://blog.csdn.net/blueicex2017/article/details/104132739	 Ansible—— 24. unarchive模块
	  
	


E:\centos7\centos-new
λ vagrant ssh-config
Host default
  HostName 127.0.0.1
  User vagrant
  Port 22
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile E:/centos7/centos-new/.vagrant/machines/default/virtualbox/private_key
  IdentitiesOnly yes
  LogLevel FATAL


  
server_id用 IP: 						  
	TASK [initialize-insecure for mysql-5.7.22] ****************************************************************************************************************************************************************************************************
	fatal: [192.168.0.45]: FAILED! => {"changed": true, "cmd": "/usr/local/mysql-5.7.22-linux-glibc2.12-x86_64/bin/mysqld --defaults-file=/etc/my.3306.cnf  --initialize-insecure", "delta": "0:00:00.447044", "end": "2020-12-02 09:33:00.488657", "msg": "non-zero return code", "rc": 1, "start": "2020-12-02 09:33:00.041613", "stderr": "2020-12-02T09:33:00.487598Z 0 [ERROR] Unknown suffix '.' used for variable 'server_id' (value '192.168.0.45')\n2020-12-02T09:33:00.487655Z 0 [ERROR] /usr/local/mysql-5.7.22-linux-glibc2.12-x86_64/bin/mysqld: Error while setting value '192.168.0.45' to 'server_id'\n2020-12-02T09:33:00.487696Z 0 [ERROR] Aborting", "stderr_lines": ["2020-12-02T09:33:00.487598Z 0 [ERROR] Unknown suffix '.' used for variable 'server_id' (value '192.168.0.45')", "2020-12-02T09:33:00.487655Z 0 [ERROR] /usr/local/mysql-5.7.22-linux-glibc2.12-x86_64/bin/mysqld: Error while setting value '192.168.0.45' to 'server_id'", "2020-12-02T09:33:00.487696Z 0 [ERROR] Aborting"], "stdout": "", "stdout_lines": []}
	
	IP地址去除小数点组成一个大整数，就可以是全世界唯一的了。




	
