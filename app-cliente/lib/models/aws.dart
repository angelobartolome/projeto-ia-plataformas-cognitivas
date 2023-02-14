class FaceRekognition {
  List<FaceDetails>? faceDetails;

  FaceRekognition({this.faceDetails});

  FaceRekognition.fromJson(Map<String, dynamic> json) {
    if (json['FaceDetails'] != null) {
      faceDetails = <FaceDetails>[];
      json['FaceDetails'].forEach((v) {
        faceDetails!.add(new FaceDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.faceDetails != null) {
      data['FaceDetails'] = this.faceDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FaceDetails {
  BoundingBox? boundingBox;
  AgeRange? ageRange;
  Smile? smile;
  Smile? eyeglasses;
  Smile? sunglasses;
  Gender? gender;
  Smile? beard;
  Smile? mustache;
  Smile? eyesOpen;
  Smile? mouthOpen;
  List<Emotions>? emotions;
  List<Landmarks>? landmarks;
  Pose? pose;
  Quality? quality;
  double? confidence;

  FaceDetails(
      {this.boundingBox,
      this.ageRange,
      this.smile,
      this.eyeglasses,
      this.sunglasses,
      this.gender,
      this.beard,
      this.mustache,
      this.eyesOpen,
      this.mouthOpen,
      this.emotions,
      this.landmarks,
      this.pose,
      this.quality,
      this.confidence});

  FaceDetails.fromJson(Map<String, dynamic> json) {
    boundingBox = json['BoundingBox'] != null
        ? new BoundingBox.fromJson(json['BoundingBox'])
        : null;
    ageRange = json['AgeRange'] != null
        ? new AgeRange.fromJson(json['AgeRange'])
        : null;
    smile = json['Smile'] != null ? new Smile.fromJson(json['Smile']) : null;
    eyeglasses = json['Eyeglasses'] != null
        ? new Smile.fromJson(json['Eyeglasses'])
        : null;
    sunglasses = json['Sunglasses'] != null
        ? new Smile.fromJson(json['Sunglasses'])
        : null;
    gender =
        json['Gender'] != null ? new Gender.fromJson(json['Gender']) : null;
    beard = json['Beard'] != null ? new Smile.fromJson(json['Beard']) : null;
    mustache =
        json['Mustache'] != null ? new Smile.fromJson(json['Mustache']) : null;
    eyesOpen =
        json['EyesOpen'] != null ? new Smile.fromJson(json['EyesOpen']) : null;
    mouthOpen = json['MouthOpen'] != null
        ? new Smile.fromJson(json['MouthOpen'])
        : null;
    if (json['Emotions'] != null) {
      emotions = <Emotions>[];
      json['Emotions'].forEach((v) {
        emotions!.add(new Emotions.fromJson(v));
      });
    }
    if (json['Landmarks'] != null) {
      landmarks = <Landmarks>[];
      json['Landmarks'].forEach((v) {
        landmarks!.add(new Landmarks.fromJson(v));
      });
    }
    pose = json['Pose'] != null ? new Pose.fromJson(json['Pose']) : null;
    quality =
        json['Quality'] != null ? new Quality.fromJson(json['Quality']) : null;
    confidence = json['Confidence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.boundingBox != null) {
      data['BoundingBox'] = this.boundingBox!.toJson();
    }
    if (this.ageRange != null) {
      data['AgeRange'] = this.ageRange!.toJson();
    }
    if (this.smile != null) {
      data['Smile'] = this.smile!.toJson();
    }
    if (this.eyeglasses != null) {
      data['Eyeglasses'] = this.eyeglasses!.toJson();
    }
    if (this.sunglasses != null) {
      data['Sunglasses'] = this.sunglasses!.toJson();
    }
    if (this.gender != null) {
      data['Gender'] = this.gender!.toJson();
    }
    if (this.beard != null) {
      data['Beard'] = this.beard!.toJson();
    }
    if (this.mustache != null) {
      data['Mustache'] = this.mustache!.toJson();
    }
    if (this.eyesOpen != null) {
      data['EyesOpen'] = this.eyesOpen!.toJson();
    }
    if (this.mouthOpen != null) {
      data['MouthOpen'] = this.mouthOpen!.toJson();
    }
    if (this.emotions != null) {
      data['Emotions'] = this.emotions!.map((v) => v.toJson()).toList();
    }
    if (this.landmarks != null) {
      data['Landmarks'] = this.landmarks!.map((v) => v.toJson()).toList();
    }
    if (this.pose != null) {
      data['Pose'] = this.pose!.toJson();
    }
    if (this.quality != null) {
      data['Quality'] = this.quality!.toJson();
    }
    data['Confidence'] = this.confidence;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Width'] = this.width;
    data['Height'] = this.height;
    data['Left'] = this.left;
    data['Top'] = this.top;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Low'] = this.low;
    data['High'] = this.high;
    return data;
  }
}

class Smile {
  bool? value;
  double? confidence;

  Smile({this.value, this.confidence});

  Smile.fromJson(Map<String, dynamic> json) {
    value = json['Value'];
    confidence = json['Confidence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Value'] = this.value;
    data['Confidence'] = this.confidence;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Value'] = this.value;
    data['Confidence'] = this.confidence;
    return data;
  }
}

class Emotions {
  String? type;
  double? confidence;

  Emotions({this.type, this.confidence});

  Emotions.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    confidence = json['Confidence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Type'] = this.type;
    data['Confidence'] = this.confidence;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Type'] = this.type;
    data['X'] = this.x;
    data['Y'] = this.y;
    return data;
  }
}

class Pose {
  double? roll;
  double? yaw;
  double? pitch;

  Pose({this.roll, this.yaw, this.pitch});

  Pose.fromJson(Map<String, dynamic> json) {
    roll = json['Roll'];
    yaw = json['Yaw'];
    pitch = json['Pitch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Roll'] = this.roll;
    data['Yaw'] = this.yaw;
    data['Pitch'] = this.pitch;
    return data;
  }
}

class Quality {
  double? brightness;
  double? sharpness;

  Quality({this.brightness, this.sharpness});

  Quality.fromJson(Map<String, dynamic> json) {
    brightness = json['Brightness'];
    sharpness = json['Sharpness'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Brightness'] = this.brightness;
    data['Sharpness'] = this.sharpness;
    return data;
  }
}
