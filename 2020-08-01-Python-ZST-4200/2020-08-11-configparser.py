import configparser

if __name__ == "__main__":

   config = configparser.ConfigParser()
   print(config)
   config.read('./my.cnf')
   #print(config.sections())

   # for section in config.sections():
   #    #print('Section: {}'.format(section))  # 输出每一段的段头
   #    print(config.items(section))     # 输出每一段的内容，数据类型为列表，列表元素为元组

   # 取common段的home_dir参数值
   # print('home_dir: {}'.format(config['common']['home_dir']))

   # 取mysqld段的port参数值
   mysqld = config['mysqld']
   print(mysqld)
   """ <Section: mysqld> """
   print('Port: {}'.format(mysqld.get('port')))

   # 也可以根据 section+key 的形式获取 value

   print(config.get('mysqld', 'default_storage_engine'))
   print(config.getint('mysqld', 'port'))

   writeConfig = configparser.ConfigParser()
   writeConfig['mysqld'] = {
      'default_storage_engine': 'InnoDB',
      'port': 3306
   }
   with open('mysql.write.cnf', 'w') as wf:
      writeConfig.write(wf)
