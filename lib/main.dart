import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reveal/screen/welcome_screen.dart';

// Providers
import './provider/tts.dart';
import './provider/uploade.dart';
import './provider/stt.dart';

// Screens
import './screen/cam_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: TextToSpeech()),
        ChangeNotifierProvider.value(value: Uploade()),
        ChangeNotifierProvider.value(value: SpeechToText()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CamScreen(),
        routes: {
          CamScreen.routeName: (_) => CamScreen(),
          WelcomeScreen.routeName: (_) => WelcomeScreen(),
        },
      ),
    );
  }
}
