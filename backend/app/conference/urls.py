from django.urls import path
from .views import (
    ConferenciaListView,
    ConferenciaCreateView,
    ConferenciaUpdateView,
    ConferenciaDeleteView
)

app_name = 'conference'

urlpatterns = [
    path('', ConferenciaListView.as_view(), name='conferencia-list'),
    path('new/', ConferenciaCreateView.as_view(), name='conferencia-create'),
    path('edit/', ConferenciaUpdateView.as_view(), name='conferencia-update'),
    path('delete/', ConferenciaDeleteView.as_view(), name='conferencia-delete'),
]
