import 'package:flutter/foundation.dart';
import 'package:inadimplencia/service.dart';
import 'package:inadimplencia/services/api.dart';
import 'package:inadimplencia/services/face.dart';

class FormViewmodel extends ChangeNotifier {
  int? _age;
  double? _monthlyIncome;
  String? _gender;

  String? _picturePath;

  int? get age => _age;
  double? get monthlyIncome => _monthlyIncome;
  String? get gender => _gender;
  String? get picturePath => _picturePath;

  bool? _deniedByPicture = false;
  bool? get deniedByPicture => _deniedByPicture;

  bool _deniedByOther = false;
  bool get deniedByOther => _deniedByOther;

  bool _showResult = false;
  bool get showResult => _showResult;

  bool _isApproved = false;
  bool get isApproved => _isApproved;

  List<double> _modelsResult = [0, 0];
  List<double> get modelsResult => _modelsResult;
  // double[] get modelsResult => _modelsResult;

  void setShowResult(bool show) {
    _showResult = show;
    notifyListeners();
  }

  void setDeniedByPicture() {
    _deniedByPicture = true;
    _isApproved = false;
    _showResult = true;
    notifyListeners();
  }

  void setDeniedByOther() {
    _deniedByOther = true;
    _isApproved = false;
    _showResult = true;
    notifyListeners();
  }

  void updateGender(String gender) {
    _gender = gender;
    notifyListeners();
  }

  void updateIncome(double income) {
    _monthlyIncome = income;
    notifyListeners();
  }

  void updatePicturePath(String? picturePath) {
    _picturePath = picturePath;
    notifyListeners();
  }

  void updateAge(int? age) {
    _age = age;
    notifyListeners();
  }

  void updateMonthlyIncome(double? monthlyIncome) {
    _monthlyIncome = monthlyIncome;
    notifyListeners();
  }

  void reset() {
    _deniedByPicture = null;
    _deniedByOther = false;
    _showResult = false;

    _age = null;
    notifyListeners();
  }

  FaceStudy? faceStudy;

  bool _isProcessingFace = false;
  bool get isProcessingFace => _isProcessingFace;

  String? _deniedError;
  String? get deniedError => _deniedError;

  void submit() async {
    // 1. Process face
    var face = serviceLocator<FaceDetector>();

    _isProcessingFace = true;
    notifyListeners();

    var result = await face.checkFace(picturePath: _picturePath);

    _isProcessingFace = false;
    faceStudy = result;

    if (result.data?.face?.faceDetails == null ||
        result.data?.face?.faceDetails?.isEmpty == true) {
      _deniedByPicture = true;
      _isApproved = false;
      _showResult = true;
      notifyListeners();

      return;
    }

    // Check if face's age matches with the user's age
    var minAge = result.data?.face?.faceDetails![0].ageRange?.low ?? 0;
    var maxAge = result.data?.face?.faceDetails![0].ageRange?.high ?? 0;

    if (age! < minAge || age! > maxAge) {
      _deniedByPicture = true;
      _isApproved = false;
      _showResult = true;
      _deniedError =
          "A idade da foto $minAge - $maxAge não confere com a idade informada $age";
      notifyListeners();

      return;
    }

    // Face is ok, continue
    var model1 = await submitForModel("model1");
    var model2 = await submitForModel("model2");

    if (model1 >= 0.5 || model2 >= 0.5) {
      _isApproved = true;
    } else {
      _isApproved = false;
      _deniedByOther = true;
    }

    _modelsResult = [model1, model2];

    _showResult = true;
    notifyListeners();
  }

  Future<double> submitForModel(String model) async {
    var response = await serviceLocator<Api>().submit(
      name: "Teste",
      modelId: model,
      age: age.toString(),
      income: monthlyIncome.toString(),
    );

    return response.data?.result ?? -1;
  }
}
