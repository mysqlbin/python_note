# 导入socket库:
import socket

if __name__ == '__main__':
    # 创建一个socket:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    # 建立连接，连接到 server
    s.connect(('127.0.0.1', 9999))
    while True:
        d = input(">")
        if d == "EOF":
            break
        print(d)
        s.send(d.encode())
    #s.send('GET / HTTP/1.1\r\nHost: www.sina.com.cn\r\nConnection: close\r\n\r\n'.encode())
    # buffer = []
    # while True:
    #     # 每次最多接收1k字节:
    #     d = s.recv(1024)
    #     if d:
    #         buffer.append(d)
    #     else:
    #         break
    # data = ''.join(buffer)
    # print(f"data: {data}")
    s.close()
