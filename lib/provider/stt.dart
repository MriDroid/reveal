import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToText with ChangeNotifier {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastWord = '';
  String lastError = '';
  String lastStatus = '';
  String systemlocale = '';
  int resultListened = 0;

  stt.SpeechToText speech = stt.SpeechToText();

  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize(
        debugLogging: true, onStatus: statusListener, onError: errorListener);
    if (hasSpeech) {
      systemlocale = 'en_US';
    }
    _hasSpeech = hasSpeech;
    notifyListeners();
  }

  void start() {
    if (_hasSpeech || !speech.isListening) {
      startListening();
    }
  }

  void startListening() {
    lastWords = '';
    lastError = '';
    speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: 5),
      pauseFor: Duration(seconds: 5),
      partialResults: true,
      localeId: systemlocale,
      onSoundLevelChange: soundLevelListener,
      cancelOnError: true,
    );
  }

  void stop() {
    if (speech.isListening) {
      stopListening();
    }
  }

  void stopListening() {
    speech.stop();
    level = 0.0;
    notifyListeners();
  }

  void cancel() {
    if (speech.isListening) {
      cancelListening();
    }
  }

  void cancelListening() {
    speech.cancel();
    level = 0.0;
    notifyListeners();
  }

  void resultListener(SpeechRecognitionResult result) {
    ++resultListened;
    // print('Result listener $resultListened');
    final now = DateTime.now().toIso8601String();
    print('$now resultListener: final ${result.finalResult}');
    if (result.finalResult) {
      print('  no. alternates ${result.alternates.length}');
      for (final a in result.alternates) {
        print('  - ${a.recognizedWords} (${a.confidence})');
      }
    }
    lastWords = '${result.recognizedWords} - ${result.finalResult}';
    lastWord = '${result.recognizedWords}';
    notifyListeners();
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    this.level = level;
    notifyListeners();
  }

  void errorListener(SpeechRecognitionError error) {
    // print("Received error status: $error, listening: ${speech.isListening}");
    lastError = '${error.errorMsg} - ${error.permanent}';
    notifyListeners();
  }

  void statusListener(String status) {
    // print(
    // 'Received listener status: $status, listening: ${speech.isListening}');
    lastStatus = '$status';
    notifyListeners();
  }
}
