import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:inadimplencia/screens/photo.dart';
import 'package:inadimplencia/screens/welcome.dart';
import 'package:inadimplencia/screens/loading.dart';
import 'package:inadimplencia/screens/result.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.firstWhere(
      (element) => element.lensDirection == CameraLensDirection.front);

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera});

  final CameraDescription camera;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomeScreen(),
      routes: {
        "/loading": (context) => const LoadingPictureScreen(),
        "/photo": (context) => PhotoScreen(camera: camera),
        "/approved": (context) => const ApprovedScreen(),
        "/denied": (context) => const DeniedScreen(),
        "/no-face": (context) => const NoFaceDetected(),
      },
    );
  }
}
