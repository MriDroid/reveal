from django.urls import path, include
from rest_framework.routers import DefaultRouter

from RevealApp import views

router = DefaultRouter()
router.register('imageclass', views.ImageClassViewSet)
router.register('imagedetect', views.ImageDetectViewSet)

urlpatterns = [
    path('', include(router.urls))
]