import 'package:flutter/material.dart';
import 'package:rto_assmant/models/user_model.dart';
import 'package:rto_assmant/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  UserModel? _currentUser;
  bool _isLoading = true;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  AuthProvider() {
    checkSession();
  }

  Future<void> checkSession() async {
    _isLoading = true;
    notifyListeners();

    _currentUser = await _authRepository.autoLogin();
    
    if (_currentUser == null) {
      // For local app, automatically login the first user if session expired/empty
      _currentUser = await _authRepository.login();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> registerAndLogin(String name, String email, String avatar) async {
    _isLoading = true;
    notifyListeners();

    _currentUser = await _authRepository.register(name, email, avatar);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateCurrentUser(UserModel updatedUser) async {
    _currentUser = updatedUser;
    notifyListeners();
  }

  Future<void> logout() async {
    await _authRepository.logout();
    _currentUser = null;
    notifyListeners();
  }
}
