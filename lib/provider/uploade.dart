import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Uploade with ChangeNotifier {
  Future imageClass(String path) async {
    try {
      final url = 'http://192.168.1.9:8000/api/imageclass/';
      var req = http.MultipartRequest('POST', Uri.parse(url));
      req.files.add(await http.MultipartFile.fromPath('image', path));
      final response = await http.Response.fromStream(await req.send());
      return response.body;
    } catch (e) {
      print('Error $e');
    }
  }

  Future imageDetect(String path) async {
    try {
      final url = 'http://192.168.1.9:8000/api/imagedetect/';
      var req = http.MultipartRequest('POST', Uri.parse(url));
      req.files.add(await http.MultipartFile.fromPath('image', path));
      final response = await http.Response.fromStream(await req.send());
      return response.body;
    } catch (e) {
      print('Error $e');
    }
  }
}
