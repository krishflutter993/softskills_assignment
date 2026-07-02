import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/vault_item.dart';
import '../models/category.dart';
import '../database/database_service.dart';
import '../services/encryption_service.dart';

class VaultProvider with ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();
  final EncryptionService _encryptionService = EncryptionService();
  final _uuid = const Uuid();

  List<VaultItem> _items = [];
  List<ItemCategory> _categories = [];
  bool _isLoading = false;

  List<VaultItem> get items => _items;
  List<ItemCategory> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    await _encryptionService.init();
    await fetchCategories();
    await fetchItems();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchItems({String? category, bool? favorite, String? query, String? sortBy}) async {
    _items = await _dbService.readAllItems(
      category: category, 
      favorite: favorite, 
      query: query,
      sortBy: sortBy
    );
    notifyListeners();
  }
  
  Future<void> fetchCategories() async {
    _categories = await _dbService.readAllCategories();
    notifyListeners();
  }

  Future<void> addItem({
    required String title,
    String? username,
    String? email,
    required String password,
    String? website,
    String? notes,
    required String category,
    bool favorite = false,
  }) async {
    final encryptedPassword = _encryptionService.encryptPassword(password);
    
    final newItem = VaultItem(
      id: _uuid.v4(),
      title: title,
      username: username,
      email: email,
      password: encryptedPassword,
      website: website,
      notes: notes,
      category: category,
      favorite: favorite,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _dbService.createItem(newItem);
    await fetchItems(); // Refresh the list
  }

  Future<void> updateItem(VaultItem item, {String? newPassword}) async {
    String finalPassword = item.password;
    if (newPassword != null && newPassword.isNotEmpty) {
      finalPassword = _encryptionService.encryptPassword(newPassword);
    }
    
    final updatedItem = item.copyWith(
      password: finalPassword,
      updatedAt: DateTime.now(),
    );

    await _dbService.updateItem(updatedItem);
    await fetchItems();
  }

  Future<void> deleteItem(String id) async {
    await _dbService.deleteItem(id);
    await fetchItems();
  }

  Future<void> toggleFavorite(String id, bool currentStatus) async {
    await _dbService.toggleFavorite(id, !currentStatus);
    await fetchItems();
  }
  
  String decryptPassword(String encryptedPassword) {
    try {
      return _encryptionService.decryptPassword(encryptedPassword);
    } catch (e) {
      return 'Error decrypting';
    }
  }
}
