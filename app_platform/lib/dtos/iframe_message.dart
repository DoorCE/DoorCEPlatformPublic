import 'package:app_platform/common/consts/iframe_texts.dart';

class XIFrameMessage {
  String type = IFrameTexts.readyFromPlatform;
  String token = "";
  String datasetUri = "";

  XIFrameMessage();

  Map<String, dynamic> toJson() => {
    'type': type,
    'token': token,
    'datasetUri': datasetUri,
  };

  factory XIFrameMessage.fromJson(Map<String, dynamic> json) {
    return XIFrameMessage()
      ..type = json['type']
      ..token = json['token']
      ..datasetUri = json['datasetUri'];
  }
}