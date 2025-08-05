import 'package:my_heroes/pokemon_list/data/model/pokemon_model.dart';
import 'package:my_heroes/pokemon_list/domain/entity/pokemon_entity.dart';

extension PokemonModelMapper on PokemonModel {
  PokemonEntity toEntity() => PokemonEntity(
        name: name,
        url: url,
        imageUrl: imageUrl,
      );
}

extension ListPokemonModelMapper on List<PokemonModel> {
  List<PokemonEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
