import socket
import time
import threading


def tcplink(sock, addr):
    print('Accept new connection from %s:%s...' % addr)
    # sock.send('Welcome!'.encode())
    while True:
        data = sock.recv(10)
        time.sleep(1)
        if data.decode() == 'exit' or not data:
            print('exit')
            break
        print(f"data: {data}")
        sock.send(('Hello, %s!' % data).encode())
    sock.close()
    print('Connection from %s:%s closed.' % addr)


if __name__ == '__main__':
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    # listen: 127.0.0.1:9999
    # addr
    # 3306
    # 127.0.0.1:9999 只能本机的client来连接
    # s.bind(('192.168.1.2', 9999))
    # s.bind(('0.0.0.0', 9999)) 任何人都可以来连接你的这个程序
    s.bind(('127.0.0.1', 9999))  # 绑定 127.0.0.1:9999, client 就可以根据 127.0.0.1:9999 来连接 server .
    s.listen(5)
    while True:
        # 接受一个新连接:
        # (192.168.1.2,9999, 192.168.1.3,9800)
        # (192.168.1.2,9999, 192.168.1.3,9801)
        # socket 四元组
        sock, addr = s.accept()
        # 创建新线程来处理TCP连接:
        t = threading.Thread(target=tcplink, args=(sock, addr))
        t.start()

    # server 端的应用先启动， client 端才能连接成功。
