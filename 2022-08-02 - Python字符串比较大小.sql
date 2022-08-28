

import time 
strs = "00:00:00,06:00:00"

lists = strs.split(";")
for time_limit_ddl in lists:
    
    times = time.strftime("%H:%M:%S", time.localtime())
    print(times)
    if times > time_limit_ddl.split(',')[0]:
        print(3333)
		
02:20:10
3333