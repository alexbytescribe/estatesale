import 'dart:io';

import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class VisionService {
  final ImageLabeler _labeler = GoogleMlKit.vision.imageLabeler();
  CameraController? _controller;

  Future<String?> identifyFromCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    _controller = CameraController(camera, ResolutionPreset.medium);
    await _controller!.initialize();
    final file = await _controller!.takePicture();
    final inputImage = InputImage.fromFilePath(file.path);
    final labels = await _labeler.processImage(inputImage);
    await _controller!.dispose();
    if (labels.isEmpty) return null;
    return labels.first.label;
  }
}
