import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:inadimplencia/face.dart';

class LoadingPictureScreen extends StatefulWidget {
  const LoadingPictureScreen({super.key});

  @override
  State<LoadingPictureScreen> createState() => _LoadingPictureScreenState();
}

class _LoadingPictureScreenState extends State<LoadingPictureScreen> {
  @override
  initState() {
    super.initState();

    // Analyze picture
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var picture = args["picture"] as XFile;

    processImage(picture: picture);
  }

  void processImage({picture: XFile}) async {
    var result = await FaceDetector.detectInImage(picture);

    if (result == null) {
      Navigator.of(context).pushReplacementNamed("/no-face");
      return;
    }

    // Navigate to result screen
    Navigator.of(context).pushReplacementNamed("/approved", arguments: {
      "result": result,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text(
                "Analisando foto...",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
