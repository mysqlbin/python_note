import MySQLdb
import logging

host = "192.168.1.27"
user = "root"
passwd = "123456abc"
db_name = "zst"
charset = "utf8mb4"

if __name__ == '__main__':

    db = MySQLdb.connect(
        host=host,      # 主机名
        user=user,      # 用户名
        passwd=passwd,  # 密码
        db=db_name,     # 数据库名称
        charset=charset
    )

    cur = db.cursor()

    try:
        cur.execute("""CREATE TABLE IF NOT EXISTS `t_activity`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `activity_name` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `hold_time` datetime NOT NULL,
  `form` varchar(128) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;""")

        print("Create table success")

        # cur.executemany("INSERT INTO t_activity VALUES (null, %s, Now(), %s)", salt_list)
        cur.execute("INSERT INTO t_activity VALUES (null, %s, Now(), %s)", ("a2333", "b"))

        db.commit()  # 一定需要commit()

    except Exception as e:

        logging.exception(e)
        db.rollback()

    finally:

        cur.close()
        db.close()