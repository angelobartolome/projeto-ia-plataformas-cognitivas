import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:inadimplencia/camera.dart';

class PhotoScreen extends StatelessWidget {
  const PhotoScreen({super.key, required this.camera});

  final CameraDescription camera;

  Widget buildCameraPreview() {
    return Container(
      height: 300,
      width: 300,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        color: Colors.blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Foto",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Envie uma foto sua para que possamos detectar que você é uma pessoa real.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 48),
              CameraApp(camera: camera),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  var controller = CameraController(
                    // Get a specific camera from the list of available cameras.
                    camera,
                    // Define the resolution to use.
                    ResolutionPreset.medium,
                  );

                  controller.initialize().then((_) {
                    if (!controller.value.isInitialized) {
                      return;
                    }

                    controller.takePicture().then((picture) => {
                          Navigator.of(context)
                              .pushNamed("/loading", arguments: {
                            "picture": picture,
                          })
                        });
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: const Text("Enviar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
