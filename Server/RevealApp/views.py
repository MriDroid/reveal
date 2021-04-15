import os
import time

from rest_framework import viewsets
from rest_framework.response import Response

from RevealApp import models, serializers
from rest_framework.settings import settings


class ImageClassViewSet(viewsets.ModelViewSet):
    queryset = models.Images.objects.all()
    serializer_class = serializers.ImagesSerializer

    def create(self,request):
        t1 = time.time()
        from vgg import detect
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        file = self.request.data['image']
        image = models.Images.objects.create(image=file)
        res = detect(f'./images/{file}')
        os.remove(f'./images/{file}')
        models.Images.objects.filter(pk=image.pk).delete()
        t = round(time.time() - t1, 3)
        return Response({'image': f'{res}', 'Response Time': f'{t}s'})

class ImageDetectViewSet(viewsets.ModelViewSet):
    queryset = models.Images.objects.all()
    serializer_class = serializers.ImagesSerializer

    def create(self,request):
        t1 = time.time()
        from ssd.object_detection_commented import detectImage
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        file = self.request.data['image']
        image = models.Images.objects.create(image=file)
        res = detectImage(f'./images/{file}')
        os.remove(f'./images/{file}')
        models.Images.objects.filter(pk=image.pk).delete()
        t = round(time.time() - t1, 3)
        return Response({'image': f'{res}', 'Response Time': f'{t}s'})