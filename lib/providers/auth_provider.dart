import 'package:flutter/foundation.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  String? _token;
  String? _userId;
  String? _username;
  bool _isAuthenticated = false;

  String? get token => _token;
  String? get userId => _userId;
  String? get username => _username;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> signIn(String email, String password) async {
    try {
      final response = await _apiService.login(email, password);
      _token = response['token'];
      _userId = response['userId'];
      _username = response['username'];
      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    _token = null;
    _userId = null;
    _username = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
