



yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel

	# 安装 openssl-devel，否则会忽略pip安装失败，但是没有error
	# yum install openssl-devel
	
	
	# 安装 zlib
	(cd /usr/local/bin; ln -s pyvenv-3.6 pyvenv)
	if test "x" != "x" ; then \
		rm -f /usr/local/bin/python3-32; \
		(cd /usr/local/bin; ln -s python3.6-32 python3-32) \
	fi
	rm -f /usr/local/share/man/man1/python3.1
	(cd /usr/local/share/man/man1; ln -s python3.6.1 python3.1)
	if test "xupgrade" != "xno"  ; then \
		case upgrade in \
			upgrade) ensurepip="--upgrade" ;; \
			install|*) ensurepip="" ;; \
		esac; \
		 ./python -E -m ensurepip \
			$ensurepip --root=/ ; \
	fi
	Traceback (most recent call last):
	  File "/home/vagrant/Python-3.6.4/Lib/runpy.py", line 193, in _run_module_as_main
		"__main__", mod_spec)
	  File "/home/vagrant/Python-3.6.4/Lib/runpy.py", line 85, in _run_code
		exec(code, run_globals)
	  File "/home/vagrant/Python-3.6.4/Lib/ensurepip/__main__.py", line 5, in <module>
		sys.exit(ensurepip._main())
	  File "/home/vagrant/Python-3.6.4/Lib/ensurepip/__init__.py", line 204, in _main
		default_pip=args.default_pip,
	  File "/home/vagrant/Python-3.6.4/Lib/ensurepip/__init__.py", line 117, in _bootstrap
		return _run_pip(args + [p[0] for p in _PROJECTS], additional_paths)
	  File "/home/vagrant/Python-3.6.4/Lib/ensurepip/__init__.py", line 27, in _run_pip
		import pip
	zipimport.ZipImportError: can t decompress data; zlib not available
	make: *** [install] Error 1
	
	yum -y install zlib*

	重新执行 make && make install 命令
		
		changing mode of /usr/local/lib/python3.6/lib-dynload/ to 755
		changing mode of /usr/local/lib/python3.6/lib-dynload/__pycache__ to 755
		running install_scripts
		copying build/scripts-3.6/pydoc3.6 -> /usr/local/bin
		copying build/scripts-3.6/idle3.6 -> /usr/local/bin
		copying build/scripts-3.6/2to3-3.6 -> /usr/local/bin
		copying build/scripts-3.6/pyvenv-3.6 -> /usr/local/bin
		changing mode of /usr/local/bin/pydoc3.6 to 755
		changing mode of /usr/local/bin/idle3.6 to 755
		changing mode of /usr/local/bin/2to3-3.6 to 755
		changing mode of /usr/local/bin/pyvenv-3.6 to 755
		rm /usr/local/lib/python3.6/lib-dynload/_sysconfigdata_m_linux_x86_64-linux-gnu.py
		rm -r /usr/local/lib/python3.6/lib-dynload/__pycache__
		/usr/bin/install -c -m 644 ./Misc/python.man \
			/usr/local/share/man/man1/python3.6.1
		if test ! -d /usr/local/lib/pkgconfig; then \
			echo "Creating directory /usr/local/lib/pkgconfig"; \
			/usr/bin/install -c -d -m 755 /usr/local/lib/pkgconfig; \
		fi
		if test -f /usr/local/bin/python3 -o -h /usr/local/bin/python3; \
		then rm -f /usr/local/bin/python3; \
		else true; \
		fi
		(cd /usr/local/bin; ln -s python3.6 python3)
		if test "3.6" != "3.6m"; then \
			rm -f /usr/local/bin/python3.6-config; \
			(cd /usr/local/bin; ln -s python3.6m-config python3.6-config); \
			rm -f /usr/local/lib/pkgconfig/python-3.6m.pc; \
			(cd /usr/local/lib/pkgconfig; ln -s python-3.6.pc python-3.6m.pc); \
		fi
		rm -f /usr/local/bin/python3-config
		(cd /usr/local/bin; ln -s python3.6-config python3-config)
		rm -f /usr/local/lib/pkgconfig/python3.pc
		(cd /usr/local/lib/pkgconfig; ln -s python-3.6.pc python3.pc)
		rm -f /usr/local/bin/idle3
		(cd /usr/local/bin; ln -s idle3.6 idle3)
		rm -f /usr/local/bin/pydoc3
		(cd /usr/local/bin; ln -s pydoc3.6 pydoc3)
		rm -f /usr/local/bin/2to3
		(cd /usr/local/bin; ln -s 2to3-3.6 2to3)
		rm -f /usr/local/bin/pyvenv
		(cd /usr/local/bin; ln -s pyvenv-3.6 pyvenv)
		if test "x" != "x" ; then \
			rm -f /usr/local/bin/python3-32; \
			(cd /usr/local/bin; ln -s python3.6-32 python3-32) \
		fi
		rm -f /usr/local/share/man/man1/python3.1
		(cd /usr/local/share/man/man1; ln -s python3.6.1 python3.1)
		if test "xupgrade" != "xno"  ; then \
			case upgrade in \
				upgrade) ensurepip="--upgrade" ;; \
				install|*) ensurepip="" ;; \
			esac; \
			 ./python -E -m ensurepip \
				$ensurepip --root=/ ; \
		fi
		Requirement already up-to-date: setuptools in /usr/local/lib/python3.6/site-packages
		Requirement already up-to-date: pip in /usr/local/lib/python3.6/site-packages

		
[root@localhost bin]# pip3 -V
pip 8.0.2 from /usr/local/lib/python3.6/site-packages/pip-8.0.2-py3.6.egg (python 3.6)


	
https://www.jianshu.com/p/a7610194249d  Linux中同时安装python2和python3双版本

https://blog.csdn.net/weixin_42245375/article/details/104265978  centos7中python3缺失pip3
	ln -s /usr/python3.6.1/bin/pip /usr/bin/pip3
	
	
	[root@localhost vagrant]# pip install --upgrade pip
	Collecting pip
	  Downloading https://files.pythonhosted.org/packages/cb/28/91f26bd088ce8e22169032100d4260614fc3da435025ff389ef1d396a433/pip-20.2.4-py2.py3-none-any.whl (1.5MB)
		100% |████████████████████████████████| 1.5MB 35kB/s 
	Installing collected packages: pip
	  Found existing installation: pip 7.1.2
		Uninstalling pip-7.1.2:
		  Successfully uninstalled pip-7.1.2
	Successfully installed pip-20.2.4


https://blog.csdn.net/slwhy/article/details/79930662   centos7 安装 Python3 并配置 pip3



	wget --no-check-certificate https://pypi.python.org/packages/source/p/pip/pip-8.0.2.tar.gz#md5=3a73c4188f8dbad6a1e6f6d44d117eeb 

	tar -zxvf pip-8.0.2.tar.gz 
	cd pip-8.0.2 
	python3 setup.py build 
	python3 setup.py install
	
	


