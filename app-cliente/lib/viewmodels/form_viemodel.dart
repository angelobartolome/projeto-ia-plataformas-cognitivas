import 'package:flutter/foundation.dart';
import 'package:inadimplencia/service.dart';
import 'package:inadimplencia/services/api.dart';
import 'package:inadimplencia/services/face.dart';

class ModelResult {
  final double chancesForApproval;
  final double chancesForDenial;

  ModelResult(this.chancesForApproval, this.chancesForDenial);

  bool isApproved() {
    return chancesForApproval > chancesForDenial;
  }
}

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
    _deniedError = null;
    _deniedByPicture = false;
    _deniedByOther = false;
    _showResult = false;
    _isApproved = false;
    notifyListeners();

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
    var predictedGender = result.data?.face?.faceDetails![0].gender?.value;

    predictedGender = predictedGender == "Male" ? "Masculino" : "Feminino";

    if (gender != predictedGender) {
      _deniedByPicture = true;
      _isApproved = false;
      _showResult = true;
      _deniedError =
          "O gênero da foto $predictedGender não confere com o gênero informado $gender";
      notifyListeners();

      return;
    }

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

    if (model1.isApproved() || model2.isApproved()) {
      _isApproved = true;
    } else {
      _isApproved = false;
      _deniedByOther = true;
    }

    _modelsResult = [model1.chancesForApproval, model2.chancesForApproval];

    _showResult = true;
    notifyListeners();
  }

  Future<ModelResult> submitForModel(String model) async {
    var response = await serviceLocator<Api>().submit(
      name: "Teste",
      modelId: model,
      age: age.toString(),
      income: monthlyIncome.toString(),
      gender: gender?.toString(),
    );

    return ModelResult(
      response.data?.result?[0] ?? 0, // approval
      response.data?.result?[1] ?? 0,
    ); // denial
  }
}
