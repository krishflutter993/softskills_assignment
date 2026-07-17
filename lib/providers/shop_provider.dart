import 'package:flutter/material.dart';
import 'package:rto_assmant/services/character_service.dart';
import 'package:rto_assmant/providers/app_state_provider.dart';

class ShopProvider extends ChangeNotifier {
  final CharacterService _characterService;
  final AppStateProvider _appStateProvider;
  List<Map<String, dynamic>> _characters = [];

  ShopProvider({
    required CharacterService characterService,
    required AppStateProvider appStateProvider,
  })  : _characterService = characterService,
        _appStateProvider = appStateProvider {
    _init();
  }

  List<Map<String, dynamic>> get characters => _characters;

  Future<void> _init() async {
    await _characterService.initDefaultCharacters();
    await loadCharacters();
  }

  Future<void> loadCharacters() async {
    _characters = await _characterService.getAllCharacters();
    notifyListeners();
  }

  Future<bool> buyCharacter(String characterId, int price, String currency) async {
    if (currency == 'coins') {
      if (_appStateProvider.coins >= price) {
        _appStateProvider.addCoins(-price);
        await _characterService.purchaseCharacter(characterId);
        await loadCharacters();
        await _appStateProvider.syncWithCharacterService();
        return true;
      }
    } else if (currency == 'gems' || currency == 'diamonds') {
      if (_appStateProvider.gems >= price) {
        _appStateProvider.addGems(-price);
        await _characterService.purchaseCharacter(characterId);
        await loadCharacters();
        await _appStateProvider.syncWithCharacterService();
        return true;
      }
    }
    return false;
  }

  Future<void> equipCharacter(String characterId) async {
    await _characterService.equipCharacter(characterId);
    await loadCharacters();
    // Sync with AppStateProvider
    await _appStateProvider.syncWithCharacterService();
  }

  Future<void> resetProgress() async {
    await _characterService.resetProgress();
    await loadCharacters();
    await _appStateProvider.syncWithCharacterService();
  }
}
