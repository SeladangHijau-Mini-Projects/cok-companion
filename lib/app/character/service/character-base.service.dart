import 'package:cokc/app/character/model/character.model.dart';
import 'package:cokc/app/character/service/character-mock.service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final characterServiceProvider = Provider((ref) => CharacterMockService());

abstract class CharacterBaseService {
  Future<CharacterModel> getCharacterById(String characterId);
  Future<List<CharacterModel>> getCharacterList();
}
