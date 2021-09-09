--- Logging error ---
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/logging/handlers.py", line 72, in emit
    self.doRollover()
  File "/usr/local/lib/python3.6/logging/handlers.py", line 396, in doRollover
    self.rotate(self.baseFilename, dfn)
  File "/usr/local/lib/python3.6/logging/handlers.py", line 113, in rotate
    os.rename(source, dest)
OSError: [Errno 26] Text file busy: '/home/vagrant/src/python_note/2020-09-05-Python-ZST-4200-new/zst_mysql_1110/log/sql_info.log' -> '/home/vagrant/src/python_note/2020-09-05-Python-ZST-4200-new/zst_mysql_1110/log/sql_info.log.2021-01-26'
Call stack:
  File "/usr/local/lib/python3.6/threading.py", line 884, in _bootstrap
    self._bootstrap_inner()
  File "/usr/local/lib/python3.6/threading.py", line 916, in _bootstrap_inner
    self.run()
  File "/usr/local/lib/python3.6/threading.py", line 864, in run
    self._target(*self._args, **self._kwargs)
  File "/usr/local/lib/python3.6/socketserver.py", line 639, in process_request_thread
    self.finish_request(request, client_address)
  File "/usr/local/lib/python3.6/socketserver.py", line 361, in finish_request
    self.RequestHandlerClass(request, client_address, self)
  File "/usr/local/lib/python3.6/socketserver.py", line 696, in __init__
    self.handle()
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/core/servers/basehttp.py", line 172, in handle
    self.handle_one_request()
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/core/servers/basehttp.py", line 197, in handle_one_request
    handler.run(self.server.get_app())
  File "/usr/local/lib/python3.6/wsgiref/handlers.py", line 137, in run
    self.result = application(self.environ, self.start_response)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/contrib/staticfiles/handlers.py", line 76, in __call__
    return self.application(environ, start_response)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/core/handlers/wsgi.py", line 133, in __call__
    response = self.get_response(request)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/core/handlers/base.py", line 128, in get_response
    response = self._middleware_chain(request)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/core/handlers/exception.py", line 47, in inner
    response = get_response(request)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/utils/deprecation.py", line 114, in __call__
    response = response or self.get_response(request)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/core/handlers/exception.py", line 47, in inner
    response = get_response(request)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/utils/deprecation.py", line 114, in __call__
    response = response or self.get_response(request)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/core/handlers/exception.py", line 47, in inner
    response = get_response(request)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/utils/deprecation.py", line 114, in __call__
    response = response or self.get_response(request)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/core/handlers/exception.py", line 47, in inner
    response = get_response(request)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/utils/deprecation.py", line 114, in __call__
    response = response or self.get_response(request)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/core/handlers/exception.py", line 47, in inner
    response = get_response(request)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/utils/deprecation.py", line 114, in __call__
    response = response or self.get_response(request)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/core/handlers/exception.py", line 47, in inner
    response = get_response(request)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/utils/deprecation.py", line 114, in __call__
    response = response or self.get_response(request)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/core/handlers/exception.py", line 47, in inner
    response = get_response(request)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/utils/deprecation.py", line 114, in __call__
    response = response or self.get_response(request)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/core/handlers/exception.py", line 47, in inner
    response = get_response(request)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/core/handlers/base.py", line 179, in _get_response
    response = wrapped_callback(request, *callback_args, **callback_kwargs)
  File "/home/vagrant/src/python_note/2020-09-05-Python-ZST-4200-new/zst_mysql_1110/slowquery/views.py", line 58, in get_top10_sql
    result['data'] = [SlowLog for SlowLog in slowquery_ojb]
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/db/models/query.py", line 287, in __iter__
    self._fetch_all()
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/db/models/query.py", line 1308, in _fetch_all
    self._result_cache = list(self._iterable_class(self))
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/db/models/query.py", line 111, in __iter__
    for row in compiler.results_iter(chunked_fetch=self.chunked_fetch, chunk_size=self.chunk_size):
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/db/models/sql/compiler.py", line 1108, in results_iter
    results = self.execute_sql(MULTI, chunked_fetch=chunked_fetch, chunk_size=chunk_size)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/db/models/sql/compiler.py", line 1156, in execute_sql
    cursor.execute(sql, params)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/db/backends/utils.py", line 98, in execute
    return super().execute(sql, params)
  File "/usr/local/lib/python3.6/contextlib.py", line 88, in __exit__
    next(self.gen)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/db/backends/utils.py", line 128, in debug_sql
    extra={'duration': duration, 'sql': sql, 'params': params},
Message: '(%.3f) %s; args=%s'
