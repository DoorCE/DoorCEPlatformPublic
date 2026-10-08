import 'package:app_platform/dtos/app.dart';

class MRunAppWindow {
  late XApp app;
  late String datasetUri;
  late String? refreshToken;

  MRunAppWindow(
    this.app,
    this.datasetUri,
    this.refreshToken,
  );

}