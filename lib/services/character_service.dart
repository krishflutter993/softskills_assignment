import 'package:rto_assmant/repositories/character_repository.dart';

class CharacterService {
  final CharacterRepository _repository;

  CharacterService({required CharacterRepository repository}) : _repository = repository;

  Future<void> initDefaultCharacters() async {
    await _repository.initDefaultCharacters();
  }

  Future<List<Map<String, dynamic>>> getAllCharacters() async {
    return await _repository.getAllCharacters();
  }

  Future<void> purchaseCharacter(String characterId) async {
    await _repository.purchaseCharacter(characterId);
  }

  Future<void> equipCharacter(String characterId) async {
    await _repository.equipCharacter(characterId);
  }

  Future<Map<String, dynamic>?> getEquippedCharacter() async {
    return await _repository.getEquippedCharacter();
  }

  Future<void> resetProgress() async {
    await _repository.resetProgress();
  }
}
