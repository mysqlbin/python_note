https://blog.csdn.net/sdwang198912/article/details/86738452   Django开发总结-（一）Vagrant虚拟环境搭建



vagrant box add my-box1 vagrant-centos-7.2.box

mkdir centos-new1 && cd centos-new1


vagrant init my-box1


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
	  
	 
[root@localhost zst_mysql_1110]# pipenv --python 3.6
Creating a virtualenv for this project...
Pipfile: /home/vagrant/src/python_note/2020-09-05-Python-ZST-4200-new/zst_mysql_1110/Pipfile
Using /usr/local/bin/python3.6m (3.6.4) to create virtualenv...
⠧ Creating virtual environment...created virtual environment CPython3.6.4.final.0-64 in 926ms
  creator CPython3Posix(dest=/root/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO, clear=False, no_vcs_ignore=False, global=False)
  seeder FromAppData(download=False, pip=bundle, setuptools=bundle, wheel=bundle, via=copy, app_data_dir=/root/.local/share/virtualenv)
    added seed packages: pip==20.3.1, setuptools==51.0.0, wheel==0.36.1
  activators BashActivator,CShellActivator,FishActivator,PowerShellActivator,PythonActivator,XonshActivator
✔ Successfully created virtual environment! 
Virtualenv location: /root/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO



pipenv shell

	[root@localhost zst_mysql_1110]# pipenv shell
	Launching subshell in virtual environment...
	[root@localhost zst_mysql_1110]#  . /root/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/bin/activate


pipenv  install -i https://pypi.tuna.tsinghua.edu.cn/simple django==3.1.3 
pipenv  install -i https://pypi.douban.com/simple django==3.1.3 


pipenv  install django==3.1.3 



pipenv install mysqlclient

	(zst_mysql_1110) [root@localhost zst_mysql_1110]# pipenv install mysqlclient
	Installing mysqlclient...
	Error:  An error occurred while installing mysqlclient!
	Error text: Looking in indexes: https://pypi.douban.com/simple
	Collecting mysqlclient
	  Using cached https://pypi.doubanio.com/packages/a5/e1/e5f2b231c05dc51d9d87fa5066f90d1405345c54b14b0b11a1c859020f21/mysqlclient-2.0.1.tar.gz (87 kB)

		ERROR: Command errored out with exit status 1:
		 command: /root/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/bin/python -c import sys, setuptools, tokenize; sys.argv[0] = '"'"'/tmp/pip-install-0jek6be_/mysqlclient_daa3e2400a8448d5b08a4dc72ace013b/setup.py'"'"'; __file__='"'"'/tmp/pip-install-0jek6be_/mysqlclient_daa3e2400a8448d5b08a4dc72ace013b/setup.py'"'"';f=getattr(tokenize, '"'"'open'"'"', open)(__file__);code=f.read().replace('"'"'\r\n'"'"', '"'"'\n'"'"');f.close();exec(compile(code, __file__, '"'"'exec'"'"')) egg_info --egg-base /tmp/pip-pip-egg-info-dt2tl8ao
			 cwd: /tmp/pip-install-0jek6be_/mysqlclient_daa3e2400a8448d5b08a4dc72ace013b/
		Complete output (12 lines):
		/bin/sh: mysql_config: command not found
		/bin/sh: mariadb_config: command not found
		/bin/sh: mysql_config: command not found
		Traceback (most recent call last):
		  File "<string>", line 1, in <module>
		  File "/tmp/pip-install-0jek6be_/mysqlclient_daa3e2400a8448d5b08a4dc72ace013b/setup.py", line 15, in <module>
			metadata, options = get_config()
		  File "/tmp/pip-install-0jek6be_/mysqlclient_daa3e2400a8448d5b08a4dc72ace013b/setup_posix.py", line 65, in get_config
			libs = mysql_config("libs")
		  File "/tmp/pip-install-0jek6be_/mysqlclient_daa3e2400a8448d5b08a4dc72ace013b/setup_posix.py", line 31, in mysql_config
			raise OSError("{} not found".format(_mysql_config_path))
		OSError: mysql_config not found
		----------------------------------------
	ERROR: Command errored out with exit status 1: python setup.py egg_info Check the logs for full command output.

	✘ Installation Failed 

	yum install mysql-devel gcc gcc-devel python-devel
	
	https://blog.csdn.net/weixin_30416871/article/details/98711474  OSError: mysql_config not found


python manage.py runserver 192.168.0.51:8001



pipenv install celery
		
	(zst_mysql_1110) [vagrant@localhost zst_mysql_1110]$ pipenv install celery
	Installing celery...
	✔ Installation Succeeded 
	Pipfile.lock (517f7c) out of date, updating to (e439d0)...
	Locking [dev-packages] dependencies...
	Locking [packages] dependencies...
	✔ Success! 
	Updated Pipfile.lock (e439d0)!
	Installing dependencies from Pipfile.lock (e439d0)...
	  🐍   ▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉ 7/7 — 00:0

(zst_mysql_1110) [vagrant@localhost zst_mysql_1110]$ celery --version
5.0.3 (singularity)

pipenv install redis

pipenv install celery-with-redis



进入项目的taskproj目录启动worker：

-- celery worker -A zst_mysql_1110 -l debug
celery -A zst_mysql_1110 worker -l INFO


127.0.0.1:6379[8]> get celery-task-meta-431b0db6-b1cf-4e2f-a3ae-7f6441300d65
"{\"status\": \"SUCCESS\", \"result\": 4, \"traceback\": null, \"children\": [], \"date_done\": \"2020-12-08T10:21:54.037642\", \"task_id\": \"431b0db6-b1cf-4e2f-a3ae-7f6441300d65\"}"


https://www.cnblogs.com/wdliu/p/9530219.html    Django中使用Celery

https://docs.celeryproject.org/en/latest/django/first-steps-with-django.html



启动错误1
	vagrant up

	default: /home/vagrant/src => E:/centos7/centos-new5/data/src
	Vagrant was unable to mount VirtualBox shared folders. This is usually
	because the filesystem "vboxsf" is not available. This filesystem is
	made available via the VirtualBox Guest Additions and kernel module.
	Please verify that these guest additions are properly installed in the
	guest. This is not a bug in Vagrant and is usually caused by a faulty
	Vagrant box. For context, the command attempted was:

	mount -t vboxsf -o uid=1000,gid=1000 home_vagrant_src /home/vagrant/src

	The error output from the command was:

	mount: unknown filesystem type 'vboxsf'


		-- vagrant plugin install vagrant-vbguest


启动错误2

	E:\centos7\centos-new6
	λ vagrant up
	Bringing machine 'default' up with 'virtualbox' provider...
	==> default: Importing base box 'my-box6'...
	==> default: Matching MAC address for NAT networking...
	==> default: Setting the name of the VM: centos-new6_default_1607439205280_89955
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
		default: Removing insecure key from the guest if it's present...
		default: Key inserted! Disconnecting and reconnecting using new SSH key...
	==> default: Machine booted and ready!
	[default] No Virtualbox Guest Additions installation found.
	Loaded plugins: fastestmirror
	Loading mirror speeds from cached hostfile
	 * base: mirrors.ustc.edu.cn
	 * extras: mirrors.aliyun.com
	 * updates: mirrors.aliyun.com
	Resolving Dependencies
	--> Running transaction check
	---> Package centos-release.x86_64 0:7-4.1708.el7.centos will be updated
	---> Package centos-release.x86_64 0:7-9.2009.1.el7.centos will be an update
	--> Finished Dependency Resolution

	Dependencies Resolved

	================================================================================
	 Package             Arch        Version                     Repository    Size
	================================================================================
	Updating:
	 centos-release      x86_64      7-9.2009.1.el7.centos       updates       27 k

	Transaction Summary
	================================================================================
	Upgrade  1 Package

	Total download size: 27 k
	Downloading packages:
	No Presto metadata available for updates
	Public key for centos-release-7-9.2009.1.el7.centos.x86_64.rpm is not installed
	warning: /var/cache/yum/x86_64/7/updates/packages/centos-release-7-9.2009.1.el7.centos.x86_64.rpm: Header V3 RSA/SHA256
	Signature, key ID f4a80eb5: NOKEY
	Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
	Importing GPG key 0xF4A80EB5:
	 Userid     : "CentOS-7 Key (CentOS 7 Official Signing Key) <security@centos.org>"
	 Fingerprint: 6341 ab27 53d7 8a78 a7c2 7bb1 24c6 a8a7 f4a8 0eb5
	 Package    : centos-release-7-4.1708.el7.centos.x86_64 (@anaconda)
	 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
	Running transaction check
	Running transaction test
	Transaction test succeeded
	Running transaction
	  Updating   : centos-release-7-9.2009.1.el7.centos.x86_64                  1/2
	  Cleanup    : centos-release-7-4.1708.el7.centos.x86_64                    2/2
	  Verifying  : centos-release-7-9.2009.1.el7.centos.x86_64                  1/2
	  Verifying  : centos-release-7-4.1708.el7.centos.x86_64                    2/2

	Updated:
	  centos-release.x86_64 0:7-9.2009.1.el7.centos

	Complete!
	Loaded plugins: fastestmirror
	Loading mirror speeds from cached hostfile
	 * base: mirrors.ustc.edu.cn
	 * extras: mirrors.aliyun.com
	 * updates: mirrors.aliyun.com
	No package kernel-devel-3.10.0-693.5.2.el7.x86_64 available.
	Error: Nothing to do
	Unmounting Virtualbox Guest Additions ISO from: /mnt
	umount: /mnt: not mounted
	==> default: Checking for guest additions in VM...
		default: No guest additions were detected on the base box for this VM! Guest
		default: additions are required for forwarded ports, shared folders, host only
		default: networking, and more. If SSH fails on this machine, please install
		default: the guest additions and repackage the box to continue.
		default:
		default: This is not an error message; everything may continue to work properly,
		default: in which case you may ignore this message.
	The following SSH command responded with a non-zero exit status.
	Vagrant assumes that this means the command failed!

	umount /mnt

	Stdout from the command:



	Stderr from the command:

	umount: /mnt: not mounted


	
mkdir /home/redis/6379/data -pv
cd /home/redis/6379
mkdir conf 
cp  /usr/local/redis-4.0.9/redis.conf /home/redis/6379/conf


	
