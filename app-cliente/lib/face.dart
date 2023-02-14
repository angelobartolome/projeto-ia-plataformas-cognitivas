import 'package:camera/camera.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inadimplencia/azure/model.dart';

class FaceDetectionResult {
  FaceDetectionResult({
    required this.faceId,
    required this.faceRectangle,
    required this.faceModelVersion,
  });

  final String faceId;
  final FaceRectangle faceRectangle;
  final String faceModelVersion;

  factory FaceDetectionResult.fromJson(Map<String, dynamic> json) =>
      FaceDetectionResult(
        faceId: json["faceId"],
        faceRectangle: FaceRectangle.fromJson(json["faceRectangle"]),
        faceModelVersion: json["faceModelVersion"],
      );
}

class FaceRectangle {
  FaceRectangle({
    required this.top,
    required this.left,
    required this.width,
    required this.height,
  });

  final int top;
  final int left;
  final int width;
  final int height;

  factory FaceRectangle.fromJson(Map<String, dynamic> json) => FaceRectangle(
        top: json["top"],
        left: json["left"],
        width: json["width"],
        height: json["height"],
      );
}

class FaceDetector {
  FaceDetector._(this._handle);

  final int _handle;

  /// Detects faces in the given image.
  static Future<FaceDetectionType?> detectInImage(XFile image) async {
    final bytes = await image.readAsBytes();
    var response = await http.post(
      Uri.parse(
          'https://app-inadimplencia.cognitiveservices.azure.com/face/v1.0/detect?returnFaceId=false&returnFaceLandmarks=true&returnFaceAttributes=age,gender'),
      headers: {
        'Content-Type': 'application/octet-stream',
        'Ocp-Apim-Subscription-Key': '....',
      },
      body: bytes,
    );

    var list = jsonDecode(response.body);

    if (list.isEmpty) {
      return null;
    }

    FaceDetectionType type =
        FaceDetectionType.fromJson(jsonDecode(response.body)[0]);

    return type;
  }
}
