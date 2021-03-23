import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';

// Providers
import '../../provider/tts.dart';
import '../../provider/uploade.dart';

class CameraWidget extends StatefulWidget {
  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;
  late CameraDescription firstCamera;
  Future<void>? _initializeControllerFuture;
  XFile? imageFile;

  @override
  void initState() {
    super.initState();
    Provider.of<TextToSpeech>(context, listen: false).initTts();
    initCam().then((value) {
      controller = CameraController(firstCamera, ResolutionPreset.veryHigh,
          imageFormatGroup: ImageFormatGroup.jpeg);
      setState(() {
        _initializeControllerFuture = controller!.initialize();
      });
    });
  }

  void dispose() {
    controller!.dispose();
    Provider.of<TextToSpeech>(context, listen: false).distroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {},
      onPointerUp: (event) {
        sendClassReq();
      },
      child: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(controller!);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<void> initCam() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    firstCamera = cameras.first;
  }

  void sendClassReq() async {
    await onTakePicture();
    final tts = Provider.of<TextToSpeech>(context, listen: false);
    final response = await Provider.of<Uploade>(context, listen: false)
        .imageClass(imageFile!.path);
    print('Response $response');
    tts.onChange(response);
    tts.speak();
  }

  void sendDetectReq() async {
    await onTakePicture();
    final tts = Provider.of<TextToSpeech>(context, listen: false);
    final response = await Provider.of<Uploade>(context, listen: false)
        .imageDetect(imageFile!.path);
    print('Response $response');
    tts.onChange(response);
    tts.speak();
  }

  Future onTakePicture() async {
    final file = await takePicture();
    if (mounted) {
      setState(() {
        imageFile = file;
      });
      if (file != null) print('Picture saved to ${file.path}');
    }
  }

  Future<XFile?> takePicture() async {
    try {
      XFile file = await controller!.takePicture();
      return file;
    } on CameraException catch (e) {
      print(e.toString());
      return null;
    }
  }
}
