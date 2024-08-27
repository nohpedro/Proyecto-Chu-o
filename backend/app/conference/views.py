from django.shortcuts import render, get_object_or_404, redirect
from django.urls import reverse_lazy
from django.views.generic import ListView, CreateView, UpdateView, DeleteView
from .models import Conferencia

from rest_framework.decorators import api_view


class ConferenciaListView(ListView):
    model = Conferencia
    context_object_name = 'conferencias'

class ConferenciaCreateView(CreateView):
    model = Conferencia
    success_url = reverse_lazy('conferencia-list')


class ConferenciaUpdateView(UpdateView):
    model = Conferencia
    success_url = reverse_lazy('conferencia-list')


class ConferenciaDeleteView(DeleteView):
    model = Conferencia
    success_url = reverse_lazy('conferencia-list')
