from kafka import KafkaConsumer
from kafka import TopicPartition
import random
import time
import json
import requests
from elasticsearch import Elasticsearch
import time
import hashlib
import logging


def write_elasticsearch(slow_log):
    es = Elasticsearch('192.168.0.45:9200')
    es.index("mysql-slowlog-{}".format(time.strftime('%Y-%m-%d')), doc_type="_doc", body=slow_log)

if __name__ == '__main__':
    kafka_host = '192.168.0.45:9092'
    # group_id = "python_consumer_" + str(random.randint(1, 1000))
    group_id = "python_consumer_same_group_id_20"
    print("Group_id: {}".format(group_id))
    consumer = KafkaConsumer('slow_query_log',
                             bootstrap_servers=[kafka_host],
                             group_id=group_id,
                             auto_offset_reset='latest')
    # print(consumer)
    for message in consumer:
        # message.value byte[]
        # str unicode
        # network str -> byte[]
        # receive from network byte[]
        # str()
        # print("got a message", message.offset, )
        # print("got a message", message.value )

        val = str(message.value, encoding='utf-8')

        # 将消息反序列化为python对象
        obj = json.loads(val)
        print("got a obj：", obj)

        if "slowlog.query" not in obj.keys():
            # logging.warning("invalid kafka message: %s", obj)
            continue

        # 获取指纹的api
        url = "http://192.168.0.45:8090/api"

        payload = {
            "sql": obj['slowlog.query']
        }
        payload = json.dumps(payload)
        headers = {
            'Content-Type': 'application/json'
        }

        response = requests.request("POST", url, headers=headers, data=payload)


        if response.status_code == 200:

            print(1)
            # print(response.text)
            # 获取指纹
            finger_print_info = json.loads(response.text)
            finger_print = finger_print_info["finger_print"]
            # print(finger_print)

            # 获取schema信息
            try:
                # 通过api进行查询，获取schema信息
                url_schema = 'http://192.168.0.45:8001/api/meta_manage/v1/get_schema_by_ip?ip={}'.format(
                    obj['host']['ip'][0])
                response_url_schema = requests.get(url_schema, headers={'Content-Type': 'application/json'})
                # print(response_url_schema)
                if response_url_schema.status_code != 200:
                    logging.error("got none-200 response: %d", response.status_code)
                    continue

                respJson = json.loads(response_url_schema.text)
                print(respJson)
                if respJson['code'] != 2000:
                    logging.error("got none-200 code: %d, message: %s", respJson['code'], respJson['message'])
                    continue

                es_data = {}
                for k, v in obj.items():
                    if isinstance(k, str) and k.startswith("slowlog"):
                        newKey = k.replace(".", "_")
                        es_data[newKey] = v

                print(obj["@timestamp"])
                es_data["@timestamp"] = obj["@timestamp"]
                es_data["finger"] = finger_print
                es_data["hash"] = hashlib.md5(finger_print.encode('utf-8')).hexdigest()
                es_data["schema"] = respJson['data']['schema']
                es_data["ip"] = respJson['data']["schema_ip"]

                write_elasticsearch(es_data)

            except json.decoder.JSONDecodeError as jde:
                logging.error("failed to parse response： %s", jde)
                pass
            except requests.exceptions.ConnectionError as ce:
                logging.error("failed to query schema: %s", ce)
                pass