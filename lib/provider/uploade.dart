import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Uploade with ChangeNotifier {
  Future imageClass(String path) async {
    try {
      // final url = 'http://192.168.1.9:8000/api/imageclass/';
      final url = 'http://192.168.41.83:8000/api/imageclass/';
      var req = http.MultipartRequest('POST', Uri.parse(url));
      req.files.add(await http.MultipartFile.fromPath('image', path));
      final response = await http.Response.fromStream(await req.send());
      print(response.body);
      return editResClass(json.decode(response.body));
    } catch (e) {
      print('Error $e');
    }
  }

  Future imageDetect(String path) async {
    try {
      // final url = 'http://192.168.1.9:8000/api/imagedetect/';
      final url = 'http://192.168.41.83:8000/api/imagedetect/';
      var req = http.MultipartRequest('POST', Uri.parse(url));
      req.files.add(await http.MultipartFile.fromPath('image', path));
      final response = await http.Response.fromStream(await req.send());
      print(response.body);
      return editResDetect(json.decode(response.body));
    } catch (e) {
      print('Error $e');
    }
  }

  String editResClass(dynamic res) {
    String resClass = "${res["image"]}";
    int idx = resClass.indexOf("(");
    String finalres = resClass.substring(0, idx);
    finalres = finalres.replaceAll('_', ' ');
    String classRes = "";
    if (finalres.startsWith(RegExp('^[aeiouAEIOU][A-Za-z0-9_]*'))) {
      classRes = "this is an " + finalres;
    } else {
      classRes = "this is a " + finalres;
    }
    return classRes;
  }

  String editResDetect(dynamic res) {
    String img = res["image"];
    img = img.replaceAll('\'', '"');
    var parsed = json.decode(img);
    List right = [];
    List left = [];
    List inFront = [];
    parsed.forEach((obj, dir) {
      dir.forEach((pos, objNum) {
        if (pos == 'right') {
          right.add({obj: objNum});
        } else if (pos == 'left') {
          left.add({obj: objNum});
        } else {
          inFront.add({obj: objNum});
        }
      });
    });
    String detectRes = 'there is ';
    if (left.isNotEmpty) {
      left.forEach((obj) {
        detectRes = '$detectRes ${obj.values} ${obj.keys}';
      });
      detectRes = '$detectRes  on left,';
    }
    if (inFront.isNotEmpty) {
      inFront.forEach((obj) {
        detectRes = '$detectRes ${obj.values} ${obj.keys}';
      });
      detectRes = '$detectRes  in front,';
    }
    if (right.isNotEmpty) {
      right.forEach((obj) {
        detectRes = '$detectRes ${obj.values} ${obj.keys}';
      });
      detectRes = '$detectRes  on right';
    }
    return detectRes;
  }
}
