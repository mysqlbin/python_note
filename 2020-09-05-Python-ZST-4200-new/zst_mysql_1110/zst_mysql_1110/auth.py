from rest_framework.authentication import SessionAuthentication, BasicAuthentication
# 安全的HTTP请求 GET HEAD OPTION； CSRF 不拦截这些请求
# 非安全 POST PUT，CSRF； 拦截这些请求
class CsrfExemptSessionAuthentication(SessionAuthentication):
    # 不把CSRF关闭，postman是请求不过去的
    # 复写 enforce_csrf 方法，把 csrf 关闭
    def enforce_csrf(self, request):
        return  # To not perform the csrf check previously happening