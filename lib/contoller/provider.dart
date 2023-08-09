import 'package:extest/model/modeldata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AppState extends ChangeNotifier {
  bool isLoading = false;
  int? temp;

  DataModel? _dataModel;

  DataModel? get dataModel => _dataModel;
  List<DataModel> dataList = [];

  void updateDataModel(List<DataModel> dataList) {
    this.dataList = dataList;
    notifyListeners();
  }

  void updateTemp(int temp) {
    this.temp = temp;
    notifyListeners();
  }

  Future<void> fetchDataModel() async {
    isLoading = true;
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$temp'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      _dataModel = DataModel.fromJson(jsonData);
      isLoading = false;
      notifyListeners();
    } else {
      throw Exception('Failed to load data model');
    }
  }
}
