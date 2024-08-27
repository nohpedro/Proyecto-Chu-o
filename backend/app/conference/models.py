from django.db import models

class Categoria(models.Model):
    nombre = models.CharField(max_length=200)

    def _str_(self):
        return self.nombre


class Conferencia(models.Model):
    fecha_hora = models.DateTimeField()
    publica = models.BooleanField()
    capacidad = models.IntegerField()
    foto = models.CharField(max_length=255)
    cancelada = models.BooleanField()
    fecha_creacion = models.DateTimeField(auto_now_add=True)
    fecha_cancelacion = models.DateTimeField(null=True, blank=True)
    ubicacion = models.CharField(max_length=255)
    enlace = models.CharField(max_length=255)
    categoria = models.ManyToManyField(Categoria, through='ConferenciaCategoria')

    def _str_(self):
        return f'Conferencia en {self.ubicacion} el {self.fecha_hora}'


class ConferenciaCategoria(models.Model):
    conferencia = models.ForeignKey(Conferencia, on_delete=models.CASCADE)
    categoria = models.ForeignKey(Categoria, on_delete=models.CASCADE)

    def _str_(self):
        return f'{self.conferencia} - {self.categoria}'


