import 'package:shared_preferences/shared_preferences.dart';
import 'package:rto_assmant/models/user_model.dart';
import 'package:rto_assmant/database/database_service.dart';

class AuthRepository {
  final DatabaseService _dbService = DatabaseService();
  static const String _sessionKey = 'user_session_id';

  Future<UserModel?> login() async {
    // For local auth without a specific login screen, we just load the default user
    // or the first user in the DB.
    UserModel? user = await _dbService.getFirstUser();
    
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_sessionKey, user.id!);
      return user;
    }
    return null;
  }

  Future<UserModel?> register(String name, String email, String avatar) async {
    UserModel newUser = UserModel(
      name: name,
      email: email,
      avatar: avatar,
    );
    int id = await _dbService.insertUser(newUser);
    newUser = newUser.copyWith(id: id);
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_sessionKey, id);
    
    return newUser;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }

  Future<UserModel?> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt(_sessionKey);
    
    if (userId != null) {
      return await _dbService.getUser(userId);
    }
    return null;
  }
}
