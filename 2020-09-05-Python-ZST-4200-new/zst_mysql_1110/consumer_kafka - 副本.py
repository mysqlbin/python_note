
from kafka import KafkaConsumer
import random
if __name__ == '__main__':

    kafka_host = '192.168.0.45:9092'
    # group_id = str(random.randint(100, 10000))
    group_id = 'python_consumer_14'
    print("group_id: {}".format(group_id))
    consumer = KafkaConsumer('slow_query_log',
                             bootstrap_servers=[kafka_host],
                             group_id='python_consumer_' + group_id,
                             auto_offset_reset='latest')
    for message in consumer:
        print("got a message", message.offset, message.value)

        
