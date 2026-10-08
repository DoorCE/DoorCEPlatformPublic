import 'dart:convert';

import 'package:app_platform/dtos/app.dart';
import 'package:app_platform/services/api.dart';
import 'package:app_platform/services/auth_api.dart';

abstract interface class AppManagementAPI {
  Future<List<XApp>> getAppList();
  Future<XApp> getApp(String identifier);
}

class AppManagement extends Api implements AppManagementAPI {

  AppManagement(AuthAPI authAPI) : super(authAPI);

  @override
  Future<List<XApp>> getAppList() async {
    final response = await httpGet('template/GetPlatformAppList');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;

      List<XApp> apps = jsonList.map((json) {
        XApp app = XApp();
        app.fromJson(json as Map<String, dynamic>);
        return app;
      }).toList();
      return apps;
    } else {
        throw Exception(
          'Error getting the apps - status code: ${response.statusCode}');
    }
  }

  @override
  Future<XApp> getApp(String identifier) async {
    final response = await httpGet('template/GetPlatformApp?identifier=$identifier');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final app = XApp();
      app.fromJson(jsonResponse);
      return app;
    } else {
      throw Exception(
          "Failed to fetch app with identifier: $identifier - status code: ${response.statusCode}");
    }
  }
}
