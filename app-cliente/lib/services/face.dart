import 'dart:io';

import 'package:camera/camera.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FaceDetector {
  Future<FaceStudy> checkFace({picturePath = String}) async {
    const URL = "http://35.222.14.71/face";

    File picture = File(picturePath);

    final bytes = await picture.readAsBytes();
    var response = await http.post(
      Uri.parse(URL),
      headers: {
        'Content-Type': 'application/octet-stream',
      },
      body: bytes,
    );

    // Read response as string
    // Parse JSON
    var json = jsonDecode(response.body);
    return FaceStudy.fromJson(json);
  }
}

class FaceStudy {
  String? status;
  Data? data;

  FaceStudy({this.status, this.data});

  FaceStudy.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Face? face;
  Moderation? moderation;

  Data({this.face, this.moderation});

  Data.fromJson(Map<String, dynamic> json) {
    face = json['face'] != null ? Face.fromJson(json['face']) : null;
    moderation = json['moderation'] != null
        ? Moderation.fromJson(json['moderation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (face != null) {
      data['face'] = face!.toJson();
    }
    if (moderation != null) {
      data['moderation'] = moderation!.toJson();
    }
    return data;
  }
}

class Face {
  List<FaceDetails>? faceDetails;

  Face({this.faceDetails});

  Face.fromJson(Map<String, dynamic> json) {
    if (json['FaceDetails'] != null) {
      faceDetails = <FaceDetails>[];
      json['FaceDetails'].forEach((v) {
        faceDetails!.add(FaceDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (faceDetails != null) {
      data['FaceDetails'] = faceDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FaceDetails {
  BoundingBox? boundingBox;
  AgeRange? ageRange;
  Gender? gender;
  List<Landmarks>? landmarks;
  double? confidence;

  FaceDetails(
      {this.boundingBox,
      this.ageRange,
      this.gender,
      this.landmarks,
      this.confidence});

  FaceDetails.fromJson(Map<String, dynamic> json) {
    boundingBox = json['BoundingBox'] != null
        ? BoundingBox.fromJson(json['BoundingBox'])
        : null;
    ageRange =
        json['AgeRange'] != null ? AgeRange.fromJson(json['AgeRange']) : null;
    gender = json['Gender'] != null ? Gender.fromJson(json['Gender']) : null;
    if (json['Landmarks'] != null) {
      landmarks = <Landmarks>[];
      json['Landmarks'].forEach((v) {
        landmarks!.add(Landmarks.fromJson(v));
      });

// only keep eyeLeft and eyeRight
      landmarks!.removeWhere((element) =>
          element.type != 'eyeLeft' &&
          element.type != 'eyeRight' &&
          element.type!.startsWith("mouth") == false);
    }
    confidence = json['Confidence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (boundingBox != null) {
      data['BoundingBox'] = boundingBox!.toJson();
    }
    if (ageRange != null) {
      data['AgeRange'] = ageRange!.toJson();
    }
    if (gender != null) {
      data['Gender'] = gender!.toJson();
    }
    if (landmarks != null) {
      data['Landmarks'] = landmarks!.map((v) => v.toJson()).toList();
    }
    data['Confidence'] = confidence;
    return data;
  }
}

class BoundingBox {
  double? width;
  double? height;
  double? left;
  double? top;

  BoundingBox({this.width, this.height, this.left, this.top});

  BoundingBox.fromJson(Map<String, dynamic> json) {
    width = json['Width'];
    height = json['Height'];
    left = json['Left'];
    top = json['Top'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Width'] = width;
    data['Height'] = height;
    data['Left'] = left;
    data['Top'] = top;
    return data;
  }
}

class AgeRange {
  int? low;
  int? high;

  AgeRange({this.low, this.high});

  AgeRange.fromJson(Map<String, dynamic> json) {
    low = json['Low'];
    high = json['High'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Low'] = low;
    data['High'] = high;
    return data;
  }
}

class Gender {
  String? value;
  double? confidence;

  Gender({this.value, this.confidence});

  Gender.fromJson(Map<String, dynamic> json) {
    value = json['Value'];
    confidence = json['Confidence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Value'] = value;
    data['Confidence'] = confidence;
    return data;
  }
}

class Landmarks {
  String? type;
  double? x;
  double? y;

  Landmarks({this.type, this.x, this.y});

  Landmarks.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    x = json['X'];
    y = json['Y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Type'] = type;
    data['X'] = x;
    data['Y'] = y;
    return data;
  }
}

class Moderation {
  bool? explicit;

  Moderation({this.explicit});

  Moderation.fromJson(Map<String, dynamic> json) {
    explicit = json['explicit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['explicit'] = explicit;
    return data;
  }
}
