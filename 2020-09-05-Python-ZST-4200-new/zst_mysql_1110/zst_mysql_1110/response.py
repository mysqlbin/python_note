from rest_framework.response import Response
from rest_framework.views import exception_handler
from rest_framework.exceptions import NotAcceptable
import logging

# 用的是 DRF 的构架,继承于 DRF 中的Response
class MyJsonResponse(Response):
    def __init__(self, data=None, message="", code=2000, **kwargs):
        super().__init__(**kwargs)
        self.data = {
            "code": code,
            "message": message,
            "data": data
        }

def my_api_exception_handler(exec, context):
    exception_handler(exec, context)
    return MyJsonResponse(code=5000, data=None, message=str(exec))

# def my_api_exception_handler(exec, context):
#     logging.exception("exception occur: %s", exec)
#     response = exception_handler(exec, context)
#     if response is None:
#         resp_mapping = (
#             (NotAcceptable, 40001, 'invalid data'),
#         )
#         for m in resp_mapping:
#             if isinstance(exec, m[0]):
#                 response = ZstJsonResponse(code=m[1], message=m[2])
#
#         response = ZstJsonResponse(code=5001, message="internal error") if response is None else response
#     else:
#         response = ZstJsonResponse(code=response.status_code, message=response.data)
#
#     return response
