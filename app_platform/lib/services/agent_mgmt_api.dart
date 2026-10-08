import 'dart:convert';

import 'package:app_platform/dtos/user_account.dart';
import 'package:app_platform/services/api.dart';
import 'package:app_platform/services/auth_api.dart';
import 'package:http/http.dart' as http;

abstract interface class AgentManagementAPI {
  Future<List<String>> getAvailableAccountIds(String query);

  Future<XUserAccount> getCurrentUserAccount();
  Future<List<XUserAccount>> getUserAccounts();

  Future<http.Response> deleteAgent(String identifier);
  Future<http.Response> deleteUserAccount(String accountId);
  Future<http.Response> upsertUserAccount(XUserAccount user);
}

class AgentManagement extends Api implements AgentManagementAPI {

  AgentManagement(AuthAPI authAPI) : super(authAPI);

  @override
  Future<List<String>> getAvailableAccountIds(String query) async {
    if (3 > query.length) return [];
    final response = await httpGet('agents/GetAvailableAccountIds?query=$query');

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.cast<String>();
    } else if (response.statusCode == 400) {
      return [];
    } else {
      throw Exception(
          "Failed to fetch available account ids - status code: ${response.statusCode}");
    }
  }

  @override
  Future<XUserAccount> getCurrentUserAccount() async {
    final response = await httpGet('agents/GetUserAccount');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final account = XUserAccount();
      account.fromJson(jsonResponse);
      return account;
    } else {
      throw Exception(
          "Failed to fetch current user - status code: ${response.statusCode}");
    }
  }

  @override
  Future<List<XUserAccount>> getUserAccounts() async {
    final response = await httpGet('agents/GetUserAccountList');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;

      return jsonList.map((json) {
        XUserAccount userAccount = XUserAccount();
        userAccount.fromJson(json as Map<String, dynamic>);
        return userAccount;
      }).toList();
    } else {
      throw Exception(
          'Error getting user accounts - status code: ${response.statusCode}');
    }
  }


  @override
  Future<http.Response> deleteAgent(String identifier) async {
    final response = await httpDelete('agents/DeleteAgent?identifier=$identifier');
    return response;
  }

  @override
  Future<http.Response> deleteUserAccount(String accountId) async {
    final response = await httpDelete('agents/DeleteUserAccount?accountId=$accountId');
    return response;
  }

  @override
  Future<http.Response> upsertUserAccount(XUserAccount user) async {
    final body = jsonEncode(user.toJson());
    final response = await httpPost('agents/UpsertUserAccount', body);
    return response;
  }

}