import 'dart:convert';
import 'package:demo_project_new/Constant/ApiUrl.dart';
import 'package:demo_project_new/Model/user_data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../DBService/database_helper.dart';

class UserDataRepository with ChangeNotifier {
  UserDataRepository() {
    getProductList();
  }

  final DatabaseHelper _databaseService = DatabaseHelper();
  List<UserDataModel>? futurePost1;

  Future<void> getProductList() async {
    await _databaseService.initDB();
    Uri uri = Uri.parse(ApiUrl.baseUrl);

    final response =
        await http.get(uri, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      List jsonResponse =
          json.decode(response.body).cast<Map<String, dynamic>>();

      await _databaseService.deleteAllEmployees();
      for (var element in jsonResponse) {
        await _databaseService.createEmployee(UserDataModel.fromJson(element));
      }
      futurePost1 = await _databaseService.getAllEmployees();
      notifyListeners();
    } else {
      futurePost1 = [];
      notifyListeners();
      throw Exception("Failed");
    }
  }

  Future<void> delete(int id) async {
    await _databaseService.initDB();
    _databaseService.delete(id);
    futurePost1 = await _databaseService.getAllEmployees();
    notifyListeners();
  }

  Future<void> insert(
    UserDataModel user,
  ) async {
    await _databaseService.initDB();
    _databaseService.insert(user);
    futurePost1 = await _databaseService.getAllEmployees();
    notifyListeners();
  }
}
