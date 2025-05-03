import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Get the list of available cameras
    _cameras = await availableCameras();

    // Initialize the first camera (usually the back camera)
    _cameraController = CameraController(
      _cameras[0], // Use the first camera
      ResolutionPreset.high, // Set the resolution
    );

    // Initialize the camera and update the state
    await _cameraController.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  @override
  void dispose() {
    // Dispose of the camera controller when the widget is disposed
    _cameraController.dispose();
    super.dispose();
  }

  Future<String> extractTextFromXFile(XFile imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      // This is where you send to Supabase
      final response = await Supabase.instance.client.functions.invoke(
        'ocr', // Your Supabase function name
        body: {'image_base64': 'data:image/jpeg;base64,$base64Image'},
      );

      return response.data['text'] ?? 'No text detected';
    } catch (e) {
      print('OCR Error: $e');
      throw Exception('OCR processing failed: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/Asset 1@2x.png', width: 140),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Display the camera preview if the camera is initialized
          if (_isCameraInitialized)
            SizedBox.expand(child: CameraPreview(_cameraController))
          else
            const Center(child: CircularProgressIndicator(color: Colors.white)),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              color: Colors.black.withOpacity(0.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      // Action for the flash button
                    },
                    icon: const Icon(Icons.flash_on, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (!_cameraController.value.isInitialized) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Camera not ready')),
                        );
                        return;
                      }

                      try {
                        // Capture image
                        final XFile image =
                            await _cameraController.takePicture();
                        print('Image path: ${image.path}');

                        // Show loading indicator
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing image...')),
                        );

                        // Read image as bytes
                        final bytes = await image.readAsBytes();
                        final base64Image = base64Encode(bytes);

                        // Prepare the request
                        final response = await http.post(
                          Uri.parse(
                            'https://mmkrtiqfogqgjpqxhipw.supabase.co/functions/v1/ocr',
                          ),
                          headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer YOUR_SUPABASE_ANON_KEY',
                          },
                          body: jsonEncode({
                            'image_base64':
                                'data:image/jpeg;base64,$base64Image',
                          }),
                        );

                        // Handle response
                        if (response.statusCode == 200) {
                          final result = jsonDecode(response.body);
                          print('OCR Result: $result');

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Extracted text: ${result['text']}',
                              ),
                            ),
                          );
                        } else {
                          throw Exception(
                            'Failed with status ${response.statusCode}',
                          );
                        }
                      } catch (e) {
                        print('Error: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${e.toString()}')),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.camera,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Switch between cameras (front/back)
                      if (_cameras.length > 1) {
                        final newCameraIndex =
                            _cameraController.description == _cameras[0]
                                ? 1
                                : 0;
                        _cameraController = CameraController(
                          _cameras[newCameraIndex],
                          ResolutionPreset.high,
                        );
                        _cameraController.initialize().then((_) {
                          setState(() {});
                        });
                      }
                    },
                    icon: const Icon(Icons.switch_camera, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
