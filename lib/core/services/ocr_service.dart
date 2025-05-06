import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class OCRService {
  static const String _serverUrl = 'http://192.168.0.173:8000/ocr';
  static const int _timeoutSeconds = 60;

  static Future<Map<String, dynamic>> extractText(File imageFile) async {
    try {
      final compressed = await FlutterImageCompress.compressWithFile(
        imageFile.path,
        quality: 85,
        minWidth: 500,
        minHeight: 500,
      );
      final tempFile = File('${imageFile.path}_compressed.jpg')
        ..writeAsBytesSync(compressed!);

      // 2. Create request
      final request = http.MultipartRequest('POST', Uri.parse(_serverUrl))
        ..files.add(
          await http.MultipartFile.fromPath(
            'file',
            tempFile.path,
            contentType: MediaType('image', 'jpeg'),
          ),
        );

      // 3. Send with timeout
      final response = await request.send().timeout(
        Duration(seconds: _timeoutSeconds),
      );

      // 4. Handle response
      final body = await response.stream.bytesToString();
      final data = jsonDecode(body);

      if (response.statusCode == 200) {
        return data;
      } else {
        throw Exception(data['detail'] ?? 'OCR failed');
      }
    } on SocketException {
      throw Exception('Network error - check connection');
    } on TimeoutException {
      throw Exception('Processing timeout');
    } catch (e) {
      throw Exception('OCR error: ${e.toString()}');
    }
  }
}
