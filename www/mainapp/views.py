from django.shortcuts import render,get_object_or_404
from django.http import HttpResponse
from .models import Cheat
import os
from django.conf import settings

# Create your views here.

def main(request):
    return render(request,'mainapp/index.html')

def cheat_catalog(request):
    cheat = Cheat.objects.all()
    context = {
        'cheat': cheat,
    }
    return render(request,'mainapp/catalog.html',context)

def detail_cheat(request,pk):

    context = {
    'cheat':get_object_or_404(Cheat,pk=pk)
    }
    return render(request,'mainapp/detail_cheat.html',context)

def download_cheat(request, cheat_id):
    cheat = get_object_or_404(Cheat, pk=cheat_id)
    file_path = cheat.file.path  # Получаем абсолютный путь к файлу

    # Проверяем, что файл существует (дополнительная мера безопасности)
    if os.path.exists(file_path):
        with open(file_path, 'rb') as f:  # Открываем файл в бинарном режиме для чтения
            response = HttpResponse(f.read(), content_type="application/force-download")  # Создаем HttpResponse
            response['Content-Disposition'] = 'attachment; filename="%s"' % cheat.file.name.split('/')[-1]  # Указываем имя файла для скачивания
            return response
    else:
        # Обрабатываем случай, когда файл не найден
        return HttpResponse("Файл не найден", status=404)