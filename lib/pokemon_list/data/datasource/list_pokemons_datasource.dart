import 'package:my_heroes/pokemon_list/data/model/pokemon_model.dart';

abstract class IListCharactersDatasource {
  Future<List<PokemonModel>> listPokemons({int offset = 0, int limit = 151});
}
