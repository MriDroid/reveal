import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../provider/tts.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<TextToSpeech>(context, listen: false).distroy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Hello")),
    );
  }
}
