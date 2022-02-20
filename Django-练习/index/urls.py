from django.urls import path
from . import views, dml_operator, select_operator
urlpatterns = [
    path('', views.index),
    path('create_user', dml_operator.create_user),
    path('update_user', dml_operator.update_user),
    path('insert_base_data', select_operator.insert_base_data),
    path('single_table_select', select_operator.select_opt)
]
