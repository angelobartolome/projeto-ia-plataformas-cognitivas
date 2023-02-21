import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({Key? key, required this.camera}) : super(key: key);

  final CameraDescription camera;

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  @override
  Widget build(BuildContext context) {
    // Fill this out in the next steps.
    return Container(
      // height: 300,
      width: 300,
      // child: ,
    );
  }
}
