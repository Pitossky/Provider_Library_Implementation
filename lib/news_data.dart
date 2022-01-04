import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class NewsData with ChangeNotifier {
  Map<String, dynamic> _newsMap = {};
  bool _newsError = true;
  String _newsErrorMessage = '';

  Map<String, dynamic> get newsMap => _newsMap;
  bool get newsError => _newsError;
  String get newsErrorMessage => _newsErrorMessage;

  Future<void> get getData async {
    final response = await get(
      Uri.parse(
          'https://saurav.tech/NewsAPI/top-headlines/category/health/in.json'),
    );

    if (response.statusCode == 200) {
      try {
        _newsMap = jsonDecode(response.body);
        _newsError = false;
      } catch (e) {
        _newsError = true;
        _newsErrorMessage = e.toString();
        _newsMap = {};
      }
    } else {
      _newsError = true;
      _newsErrorMessage = 'Network Error';
      _newsMap = {};
    }
    notifyListeners();
  }

  void initialValues(){
    _newsMap = {};
    _newsError = false;
    _newsErrorMessage = '';
    notifyListeners();
  }
}
