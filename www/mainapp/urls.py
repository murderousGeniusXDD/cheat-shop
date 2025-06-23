from django.contrib import admin
from django.urls import path,include

from . import views as mainapp

app_name = 'mainapp'

urlpatterns = [
    path('',mainapp.main,name='main'),
    path('catalog/',mainapp.cheat_catalog,name='catalog'),
    path('detail_cheat/<int:pk>/',mainapp.detail_cheat,name='detail_cheat'),
    path('download/<int:cheat_id>/',mainapp.download_cheat,name='download_cheat'),
]