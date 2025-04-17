import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
            CameraPreview(_cameraController)
          else
            const Center(child: CircularProgressIndicator(color: Colors.white)),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
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
                      // Capture an image
                      if (_cameraController.value.isInitialized) {
                        final image = await _cameraController.takePicture();
                        // Handle the captured image (e.g., save or display it)
                        print('Image captured: ${image.path}');
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
