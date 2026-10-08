import 'package:app_platform/services/auth_api.dart';
import 'package:http/http.dart' as http;

abstract class Api {
  String backendPath = const String.fromEnvironment("UDAS_SERVER_URL", defaultValue: "http://localhost:8081");
  
  AuthAPI _authAPI;

  Api(this._authAPI);

  Future<Map<String,String>> getCommonHeaders() async {
    final token = await _authAPI.getAccessToken();
    return {
      'Accept': '*/*',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, String>> getUpsertHeaders() async {
    final commonHeaders = await getCommonHeaders();
    return {
      ...commonHeaders,
      'Content-Type': 'application/json'
    };
  }

  Future<http.Response> httpGet(String urlPostfix) async {
    final url = Uri.parse("$backendPath/$urlPostfix");
    http.Response response = await http.get(url, headers: await getCommonHeaders());
    if (response.statusCode == 401) {
      await _authAPI.refresh();
      response = await http.get(url, headers: await getCommonHeaders());
    }
    return response;
  }

  Future<http.Response> httpPost(String urlPostfix, String? body) async {
    final url = Uri.parse("$backendPath/$urlPostfix");
    http.Response response = await http.post(url, headers: await getUpsertHeaders(), body: body);
    if (response.statusCode == 401) {
      await _authAPI.refresh();
      response = await http.post(url, headers: await getUpsertHeaders(), body: body);
    }
    return response;
  }

  Future<http.Response> httpDelete(String urlPostfix) async {
    final url = Uri.parse("$backendPath/$urlPostfix");
    http.Response response = await http.delete(url, headers: await getCommonHeaders());
    if (response.statusCode == 401) {
      await _authAPI.refresh();
      response = await http.delete(url, headers: await getCommonHeaders());
    }
    return response;
  }
}