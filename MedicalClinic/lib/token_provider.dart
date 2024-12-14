import 'package:flutter/material.dart';

class TokenProvider extends ChangeNotifier {
  String _token = '';
  int? _user_id = 58;

  String get token => _token;
  int? get user_id => _user_id;

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  void setUserId(int userId) {
    _user_id = userId;
    notifyListeners();
  }

  void clearData() {
    _token = '';
    _user_id = null;
    notifyListeners();
  }
}