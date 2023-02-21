import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inadimplencia/ui/button.dart';
import 'package:inadimplencia/viewmodels/form_viemodel.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key, required this.camera});

  CameraDescription camera;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  String? picturePath;

  bool isCameraReady = false;
  bool isTakingPicture = false;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
    _initializeControllerFuture.then((value) => {
          setState(() {
            isCameraReady = true;
          })
        });
  }

  void takePicture() async {
    setState(() {
      isTakingPicture = true;
    });

    var picture = await _controller.takePicture();

    setState(() {
      picturePath = picture.path;
      isTakingPicture = false;
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var formViewmodel = Provider.of<FormViewmodel>(context, listen: false);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bem-vindo!",
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Para prosseguir, precisamos que você tire uma foto sua.",
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              // Camera preview
              picturePath != null
                  ? Image.file(
                      File(picturePath!),
                      width: double.infinity,
                      // height: 300,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF7C4FFB),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: CameraPreview(_controller),
                    ),
              const SizedBox(height: 24),
              picturePath != null
                  ? CustomButton(
                      icon: const Icon(Icons.check, color: Colors.white),
                      onPressed: () {
                        formViewmodel.updatePicturePath(picturePath!);

                        _controller.dispose();

                        Navigator.of(context).pushReplacementNamed("/form");
                      },
                      text: "Continuar",
                      color: Colors.green,
                    )
                  : CustomButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: isCameraReady ? takePicture : null,
                      text: "Tirar foto",
                      color: const Color(0xFF7C4FFB),
                      disabled: isTakingPicture,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
