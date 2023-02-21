import 'package:get_it/get_it.dart';
import 'package:inadimplencia/services/api.dart';
import 'package:inadimplencia/services/face.dart';
import 'package:inadimplencia/viewmodels/form_viemodel.dart';

var serviceLocator = GetIt.instance;

void register() {
  serviceLocator.registerSingleton<FormViewmodel>(FormViewmodel());

  serviceLocator.registerFactory<Api>(() => Api());
  serviceLocator.registerFactory<FaceDetector>(() => FaceDetector());
}
