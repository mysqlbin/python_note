#!/usr/local/bin/python3
#coding=utf-8



def a():
    a = 1
    b = 2
    return (a,b)

val = a()
print("type: {}".format(val))
print("val[0]: {}".format(val[0]))


item = [{'Timestamp': 1646098198,
        'QueryTime': 0.480794,
        'SqlText': "select `resource_id`, count(*) as count from `t_purchase` where `app_id` = 'appxtlk5IFu9011' and `product_id` in ('p_6164f142e4b038442e0a8ca5', 'p_61a744abe4b0cc47c3c11bc3') and `is_deleted` = 0 group by `resource_id`",
        'UserHost': '10.105.22.121',
        'UserName': 'code_viewer',
        'Database': 'db_ex_business',
        'LockTime': 5.5e-05,
        'RowsExamined': 636616,
        'RowsSent': 2,
        'SqlTemplate': 'select `resource_id`, count(*) as count from `t_purchase` where `app_id` = ? and `product_id` in(?+) and `is_deleted` = ? group by `resource_id`;',
        'Md5': 'C7A78BDD840CC4B3'
        },
        {'Timestamp': 1646098198,
        'QueryTime': 0.480794,
        'SqlText': "select `resource_id`, count(*) as count from `t_purchase` where `app_id` = 'appxtlk5IFu9011' and `product_id` in ('p_6164f142e4b038442e0a8ca5', 'p_61a744abe4b0cc47c3c11bc3') and `is_deleted` = 0 group by `resource_id`",
        'UserHost': '10.105.22.121',
        'UserName': 'code_viewer',
        'Database': 'db_ex_business',
        'LockTime': 5.5e-05,
        'RowsExamined': 636616,
        'RowsSent': 3,
        'SqlTemplate': 'select `resource_id`, count(*) as count from `t_purchase` where `app_id` = ? and `product_id` in(?+) and `is_deleted` = ? group by `resource_id`;',
        'Md5': 'C7A78BDD840CC4B3'
        }
        ]

for vals in item:
    print(vals['RowsSent'])

# print (item['SqlText'])

a = (1, 2)
print(a[0])

b = 'b1'
c  = 'c1'
if b != 'b1' or c !='c2':
    print(3333)

work_status_list_rule = ['new', 'in_progress', 'resolved']

work_status_list = ['new', 'resolved']


vars = ''
lists = [1,2]
if (1 not in lists):
    print(33333333)

else:
    print(444444)
strs = 'cdb-m3d6sihu,cdb-m3d6sihu,cdb-m3d6sih1'


old_list = strs.split(',')
new_list = list(set(old_list))
print(new_list)

print(",".join(new_list))


print("....................................")
def abc():
    new_list_data = [1,2,3,4]
    for val in new_list_data:
        if 1 == 1:
            return 2
    return 1

print(abc())

print("....................................")
