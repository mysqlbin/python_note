from kafka import KafkaConsumer
import requests
import json
from elasticsearch import Elasticsearch
import logging


if __name__ == '__main__':
    kafka_host = '192.168.31.109:9092'
    group_id = "abc"
    #group_id = 'python3_consumer_' + str(random.randint(100, 10000))
    consumer = KafkaConsumer('slow_query_log',
                             bootstrap_servers=[kafka_host],
                             group_id=group_id,
                             auto_offset_reset='latest',
                             api_version=(0, 10))
    es = Elasticsearch('192.168.31.109:9200')

    for message in consumer:
        try:
            # message.value bytes数组 -> decode -> string
            obj = json.loads(message.value.decode('utf-8'))
            if "slowlog.query" not in obj.keys():
                logging.warning("invalid kafka message: %s", obj)
                continue
            try:
                url = 'http://localhost:8000/api/meta/getSchemaByUser/?user={}&ip={}'.format(obj['slowlog.user'],
                                                                                             obj['host']['ip'][0])
                response = requests.get(url, headers={'Content-Type': 'application/json'})
                if response.status_code != 200:
                    logging.error("got none-200 response: %d", response.status_code)
                    continue
                respJson = json.loads(response.text)
                if respJson['code'] != 200:
                    logging.error("got none-200 code: %d, message: %s", respJson['code'], respJson['message'])
                    continue

                es_data = {}
                for k, v in respJson['data'].items():
                    es_data[k] = v

                for k, v in obj.items():
                    if isinstance(k, str) and k.startswith("slowlog"):
                        newKey = k.replace(".", "_")
                        es_data[newKey] = v
                es_data["@timestamp"] = obj["@timestamp"]
                es.index(index='slow_query_log', doc_type='_doc', body=es_data)
            except json.decoder.JSONDecodeError as jde:
                logging.error("failed to parse response： %s", jde)
                pass
            except requests.exceptions.ConnectionError as ce:
                logging.error("failed to query schema: %s", ce)
                pass
        except json.decoder.JSONDecodeError as jde:
            logging.error("failed to parse kafka message: %s", jde)
            pass

