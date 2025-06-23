from django.db import models

# Create your models here.

class Cheat(models.Model):
    name = models.CharField(max_length=65,unique=True)
    dsc = models.TextField(max_length=415)
    image = models.ImageField(upload_to='cheat_images',blank=True,null=True)
    file = models.FileField(upload_to='files',null=False,blank=False)

    def __str__(self):
        return self.name

