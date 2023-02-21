import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:inadimplencia/screens/form.dart';
import 'package:inadimplencia/screens/photo.dart';
import 'package:inadimplencia/screens/welcome.dart';
import 'package:inadimplencia/screens/loading.dart';
import 'package:inadimplencia/screens/result.dart';
import 'package:inadimplencia/service.dart';
import 'package:inadimplencia/viewmodels/form_viemodel.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.firstWhere(
      (element) => element.lensDirection == CameraLensDirection.front);

  register();

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera});

  final CameraDescription camera;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FormViewmodel>(
      create: (context) => serviceLocator<FormViewmodel>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => WelcomeScreen(camera: camera),
          "/form": (context) => const FormScreen(),
          "/loading": (context) => const LoadingPictureScreen(),
          "/photo": (context) => PhotoScreen(camera: camera),
          "/approved": (context) => const ApprovedScreen(),
          "/denied": (context) => const DeniedScreen(),
          "/no-face": (context) => const NoFaceDetected(),
        },
      ),
    );
  }
}
