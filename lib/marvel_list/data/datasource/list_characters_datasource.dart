import 'package:my_heroes/marvel_list/data/model/character_model.dart';

abstract class IListCharactersDatasource {
  Future<List<CharacterModel>> listCharacters();
}
