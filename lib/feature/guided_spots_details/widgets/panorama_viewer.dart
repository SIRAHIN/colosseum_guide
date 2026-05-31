import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class PanoramaViewerWidget extends StatelessWidget {
  final String imagePath;

  const PanoramaViewerWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return PanoramaViewer(
      animSpeed: 1.0,
      sensorControl: SensorControl.orientation,
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }
}
