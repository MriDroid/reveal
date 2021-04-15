from rest_framework import serializers

from RevealApp import models

class ImagesSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Images
        fields = ('id','image')