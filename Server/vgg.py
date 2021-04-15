import os
import sys
import getopt
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'


class SingleTone():
    singleInstance = None
    model = None

    def __init__(self):
        if SingleTone.singleInstance == None:
            SingleTone.singleInstance = self
            import tensorflow as tf
            from tensorflow.keras.applications.vgg16 import VGG16
            config = tf.compat.v1.ConfigProto()
            config.gpu_options.allow_growth = True
            session = tf.compat.v1.InteractiveSession(config=config)
            # load the model
            SingleTone.model = VGG16()

    @staticmethod
    def getInstance():
        if SingleTone.singleInstance == None:
            SingleTone()
        return SingleTone.singleInstance

def detect(Image):
    from tensorflow.keras.preprocessing.image import load_img
    from tensorflow.keras.preprocessing.image import img_to_array
    from tensorflow.keras.applications.vgg16 import preprocess_input
    from tensorflow.keras.applications.vgg16 import decode_predictions
    model = SingleTone.getInstance()
    # load an image from file
    image = load_img(Image, target_size=(224, 224))
    # convert the image pixels to a numpy array
    image = img_to_array(image)
    # reshape data for the model
    image = image.reshape((1, image.shape[0], image.shape[1], image.shape[2]))
    # prepare the image for the VGG model
    image = preprocess_input(image)
    # predict the probability across all output classes
    yhat = model.model.predict(image)
    # convert the probabilities to class labels
    label = decode_predictions(yhat)
    # retrieve the most likely result, e.g. highest probability
    label = label[0][0]
    # print the classification
    result = '%s (%.2f%%)' % (label[1], label[2]*100)
    # display(Image, result)
    return result
