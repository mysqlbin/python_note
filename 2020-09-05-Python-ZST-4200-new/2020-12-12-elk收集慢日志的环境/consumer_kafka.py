
from kafka import KafkaConsumer
import random
if __name__ == '__main__':

    kafka_host = '192.168.0.45:9092'
    consumer = KafkaConsumer('slow_query_log', bootstrap_servers=[kafka_host],group_id='python_consumer_' + str(random.randint(100, 10000)))
    for message in consumer:
        print("got a message", message.offset, message.value)

