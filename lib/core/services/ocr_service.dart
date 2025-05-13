import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class OCRService {
  static const String _serverUrl =
      'http://192.168.0.185:5000/ocr'; // Update with your server's IP and port
  static const int _timeoutSeconds = 60;

  static Future<Map<String, dynamic>> extractText(File imageFile) async {
    try {
      // Compress the image
      final compressed = await FlutterImageCompress.compressWithFile(
        imageFile.path,
        quality: 85,
        minWidth: 500,
        minHeight: 500,
      );
      final tempFile = File('${imageFile.path}_compressed.jpg')
        ..writeAsBytesSync(compressed!);

      // Create a multipart request
      final request = http.MultipartRequest('POST', Uri.parse(_serverUrl))
        ..files.add(
          await http.MultipartFile.fromPath(
            'file',
            tempFile.path,
            contentType: MediaType('image', 'jpeg'),
          ),
        );

      // Send the request with a timeout
      final response = await request.send().timeout(
        Duration(seconds: _timeoutSeconds),
      );

      // Parse the response
      final body = await response.stream.bytesToString();
      final data = jsonDecode(body);

      if (response.statusCode == 200) {
        return data; // Return the extracted text and metadata
      } else {
        throw Exception(data['error'] ?? 'OCR failed');
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
