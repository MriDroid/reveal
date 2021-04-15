import 'package:flutter/material.dart';

// Widgets
import '../widget/cam_screen/camera_widget.dart';

class CamScreen extends StatefulWidget {
  static const String routeName = '/cam_screen';
  @override
  _CamScreenState createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reveal'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.8,
        child: CameraWidget(),
      ),
    );
  }
}
