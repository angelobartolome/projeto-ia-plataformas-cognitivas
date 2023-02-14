class FaceDetectionType {
  FaceRectangle? faceRectangle;
  FaceLandmarks? faceLandmarks;

  FaceDetectionType({this.faceRectangle, this.faceLandmarks});

  FaceDetectionType.fromJson(Map<String, dynamic> json) {
    faceRectangle = json['faceRectangle'] != null
        ? FaceRectangle.fromJson(json['faceRectangle'])
        : null;
    faceLandmarks = json['faceLandmarks'] != null
        ? new FaceLandmarks.fromJson(json['faceLandmarks'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.faceRectangle != null) {
      data['faceRectangle'] = this.faceRectangle!.toJson();
    }
    if (this.faceLandmarks != null) {
      data['faceLandmarks'] = this.faceLandmarks!.toJson();
    }
    return data;
  }
}

class FaceRectangle {
  int? top;
  int? left;
  int? width;
  int? height;

  FaceRectangle({this.top, this.left, this.width, this.height});

  FaceRectangle.fromJson(Map<String, dynamic> json) {
    top = json['top'];
    left = json['left'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['top'] = this.top;
    data['left'] = this.left;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class FaceLandmarks {
  PupilLeft? pupilLeft;
  PupilLeft? pupilRight;
  NoseTip? noseTip;
  PupilLeft? mouthLeft;
  PupilLeft? mouthRight;
  PupilLeft? eyebrowLeftOuter;
  PupilLeft? eyebrowLeftInner;
  PupilLeft? eyeLeftOuter;
  PupilLeft? eyeLeftTop;
  PupilLeft? eyeLeftBottom;
  EyeLeftInner? eyeLeftInner;
  PupilLeft? eyebrowRightInner;
  EyeLeftInner? eyebrowRightOuter;
  PupilLeft? eyeRightInner;
  PupilLeft? eyeRightTop;
  PupilLeft? eyeRightBottom;
  PupilLeft? eyeRightOuter;
  NoseTip? noseRootLeft;
  PupilLeft? noseRootRight;
  PupilLeft? noseLeftAlarTop;
  PupilLeft? noseRightAlarTop;
  PupilLeft? noseLeftAlarOutTip;
  PupilLeft? noseRightAlarOutTip;
  PupilLeft? upperLipTop;
  EyeLeftInner? upperLipBottom;
  PupilLeft? underLipTop;
  PupilLeft? underLipBottom;

  FaceLandmarks(
      {this.pupilLeft,
      this.pupilRight,
      this.noseTip,
      this.mouthLeft,
      this.mouthRight,
      this.eyebrowLeftOuter,
      this.eyebrowLeftInner,
      this.eyeLeftOuter,
      this.eyeLeftTop,
      this.eyeLeftBottom,
      this.eyeLeftInner,
      this.eyebrowRightInner,
      this.eyebrowRightOuter,
      this.eyeRightInner,
      this.eyeRightTop,
      this.eyeRightBottom,
      this.eyeRightOuter,
      this.noseRootLeft,
      this.noseRootRight,
      this.noseLeftAlarTop,
      this.noseRightAlarTop,
      this.noseLeftAlarOutTip,
      this.noseRightAlarOutTip,
      this.upperLipTop,
      this.upperLipBottom,
      this.underLipTop,
      this.underLipBottom});

  FaceLandmarks.fromJson(Map<String, dynamic> json) {
    pupilLeft = json['pupilLeft'] != null
        ? new PupilLeft.fromJson(json['pupilLeft'])
        : null;
    pupilRight = json['pupilRight'] != null
        ? new PupilLeft.fromJson(json['pupilRight'])
        : null;
    noseTip =
        json['noseTip'] != null ? new NoseTip.fromJson(json['noseTip']) : null;
    mouthLeft = json['mouthLeft'] != null
        ? new PupilLeft.fromJson(json['mouthLeft'])
        : null;
    mouthRight = json['mouthRight'] != null
        ? new PupilLeft.fromJson(json['mouthRight'])
        : null;
    eyebrowLeftOuter = json['eyebrowLeftOuter'] != null
        ? new PupilLeft.fromJson(json['eyebrowLeftOuter'])
        : null;
    eyebrowLeftInner = json['eyebrowLeftInner'] != null
        ? new PupilLeft.fromJson(json['eyebrowLeftInner'])
        : null;
    eyeLeftOuter = json['eyeLeftOuter'] != null
        ? new PupilLeft.fromJson(json['eyeLeftOuter'])
        : null;
    eyeLeftTop = json['eyeLeftTop'] != null
        ? new PupilLeft.fromJson(json['eyeLeftTop'])
        : null;
    eyeLeftBottom = json['eyeLeftBottom'] != null
        ? new PupilLeft.fromJson(json['eyeLeftBottom'])
        : null;
    eyeLeftInner = json['eyeLeftInner'] != null
        ? new EyeLeftInner.fromJson(json['eyeLeftInner'])
        : null;
    eyebrowRightInner = json['eyebrowRightInner'] != null
        ? new PupilLeft.fromJson(json['eyebrowRightInner'])
        : null;
    eyebrowRightOuter = json['eyebrowRightOuter'] != null
        ? new EyeLeftInner.fromJson(json['eyebrowRightOuter'])
        : null;
    eyeRightInner = json['eyeRightInner'] != null
        ? new PupilLeft.fromJson(json['eyeRightInner'])
        : null;
    eyeRightTop = json['eyeRightTop'] != null
        ? new PupilLeft.fromJson(json['eyeRightTop'])
        : null;
    eyeRightBottom = json['eyeRightBottom'] != null
        ? new PupilLeft.fromJson(json['eyeRightBottom'])
        : null;
    eyeRightOuter = json['eyeRightOuter'] != null
        ? new PupilLeft.fromJson(json['eyeRightOuter'])
        : null;
    noseRootLeft = json['noseRootLeft'] != null
        ? new NoseTip.fromJson(json['noseRootLeft'])
        : null;
    noseRootRight = json['noseRootRight'] != null
        ? new PupilLeft.fromJson(json['noseRootRight'])
        : null;
    noseLeftAlarTop = json['noseLeftAlarTop'] != null
        ? new PupilLeft.fromJson(json['noseLeftAlarTop'])
        : null;
    noseRightAlarTop = json['noseRightAlarTop'] != null
        ? new PupilLeft.fromJson(json['noseRightAlarTop'])
        : null;
    noseLeftAlarOutTip = json['noseLeftAlarOutTip'] != null
        ? new PupilLeft.fromJson(json['noseLeftAlarOutTip'])
        : null;
    noseRightAlarOutTip = json['noseRightAlarOutTip'] != null
        ? new PupilLeft.fromJson(json['noseRightAlarOutTip'])
        : null;
    upperLipTop = json['upperLipTop'] != null
        ? new PupilLeft.fromJson(json['upperLipTop'])
        : null;
    upperLipBottom = json['upperLipBottom'] != null
        ? new EyeLeftInner.fromJson(json['upperLipBottom'])
        : null;
    underLipTop = json['underLipTop'] != null
        ? new PupilLeft.fromJson(json['underLipTop'])
        : null;
    underLipBottom = json['underLipBottom'] != null
        ? new PupilLeft.fromJson(json['underLipBottom'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pupilLeft != null) {
      data['pupilLeft'] = this.pupilLeft!.toJson();
    }
    if (this.pupilRight != null) {
      data['pupilRight'] = this.pupilRight!.toJson();
    }
    if (this.noseTip != null) {
      data['noseTip'] = this.noseTip!.toJson();
    }
    if (this.mouthLeft != null) {
      data['mouthLeft'] = this.mouthLeft!.toJson();
    }
    if (this.mouthRight != null) {
      data['mouthRight'] = this.mouthRight!.toJson();
    }
    if (this.eyebrowLeftOuter != null) {
      data['eyebrowLeftOuter'] = this.eyebrowLeftOuter!.toJson();
    }
    if (this.eyebrowLeftInner != null) {
      data['eyebrowLeftInner'] = this.eyebrowLeftInner!.toJson();
    }
    if (this.eyeLeftOuter != null) {
      data['eyeLeftOuter'] = this.eyeLeftOuter!.toJson();
    }
    if (this.eyeLeftTop != null) {
      data['eyeLeftTop'] = this.eyeLeftTop!.toJson();
    }
    if (this.eyeLeftBottom != null) {
      data['eyeLeftBottom'] = this.eyeLeftBottom!.toJson();
    }
    if (this.eyeLeftInner != null) {
      data['eyeLeftInner'] = this.eyeLeftInner!.toJson();
    }
    if (this.eyebrowRightInner != null) {
      data['eyebrowRightInner'] = this.eyebrowRightInner!.toJson();
    }
    if (this.eyebrowRightOuter != null) {
      data['eyebrowRightOuter'] = this.eyebrowRightOuter!.toJson();
    }
    if (this.eyeRightInner != null) {
      data['eyeRightInner'] = this.eyeRightInner!.toJson();
    }
    if (this.eyeRightTop != null) {
      data['eyeRightTop'] = this.eyeRightTop!.toJson();
    }
    if (this.eyeRightBottom != null) {
      data['eyeRightBottom'] = this.eyeRightBottom!.toJson();
    }
    if (this.eyeRightOuter != null) {
      data['eyeRightOuter'] = this.eyeRightOuter!.toJson();
    }
    if (this.noseRootLeft != null) {
      data['noseRootLeft'] = this.noseRootLeft!.toJson();
    }
    if (this.noseRootRight != null) {
      data['noseRootRight'] = this.noseRootRight!.toJson();
    }
    if (this.noseLeftAlarTop != null) {
      data['noseLeftAlarTop'] = this.noseLeftAlarTop!.toJson();
    }
    if (this.noseRightAlarTop != null) {
      data['noseRightAlarTop'] = this.noseRightAlarTop!.toJson();
    }
    if (this.noseLeftAlarOutTip != null) {
      data['noseLeftAlarOutTip'] = this.noseLeftAlarOutTip!.toJson();
    }
    if (this.noseRightAlarOutTip != null) {
      data['noseRightAlarOutTip'] = this.noseRightAlarOutTip!.toJson();
    }
    if (this.upperLipTop != null) {
      data['upperLipTop'] = this.upperLipTop!.toJson();
    }
    if (this.upperLipBottom != null) {
      data['upperLipBottom'] = this.upperLipBottom!.toJson();
    }
    if (this.underLipTop != null) {
      data['underLipTop'] = this.underLipTop!.toJson();
    }
    if (this.underLipBottom != null) {
      data['underLipBottom'] = this.underLipBottom!.toJson();
    }
    return data;
  }
}

class PupilLeft {
  double? x;
  double? y;

  PupilLeft({this.x, this.y});

  PupilLeft.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }
}

class NoseTip {
  double? x;
  double? y;

  NoseTip({this.x, this.y});

  NoseTip.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }
}

class EyeLeftInner {
  double? x;
  double? y;

  EyeLeftInner({this.x, this.y});

  EyeLeftInner.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }
}
