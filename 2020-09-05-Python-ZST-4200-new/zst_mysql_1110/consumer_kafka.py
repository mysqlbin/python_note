from kafka import KafkaConsumer
from kafka import TopicPartition
import random
import time
import json
import requests
from elasticsearch import Elasticsearch
import time
import hashlib

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

        obj = json.loads(val)
        print(obj)

        if "slowlog.query" not in obj.keys():
            # logging.warning("invalid kafka message: %s", obj)
            continue


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
            # print(response.text)
            finger_print_info = json.loads(response.text)
            finger_print = finger_print_info["finger_print"]
            print(finger_print)


            es_data = {}
            for k, v in obj.items():
                if isinstance(k, str) and k.startswith("slowlog"):
                    newKey = k.replace(".", "_")
                    es_data[newKey] = v

            es_data["@timestamp"] = obj["@timestamp"]
            es_data["finger"] = finger_print
            es_data["hash"] = hashlib.md5(finger_print.encode('utf-8')).hexdigest()
            es_data["schema"] = "test_db"
            es_data["ip"] = "192.168.0.201"
            write_elasticsearch(es_data)

