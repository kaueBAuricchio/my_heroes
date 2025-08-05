import 'package:flutter_test/flutter_test.dart';
import 'package:my_heroes/pokemon_list/data/model/mapper/pokemon_model_mapper.dart';
import 'package:my_heroes/pokemon_list/data/model/pokemon_model.dart';

void main() {
  group('PokemonModelMapper', () {
    test('toEntity should convert PokemonModel to PokemonEntity', () {
      const pokemonModel = PokemonModel(
        name: 'pikachu',
        url: 'https://pokeapi.co/api/v2/pokemon/25/',
      );

      final pokemonEntity = pokemonModel.toEntity();

      expect(pokemonEntity.name, equals('pikachu'));
      expect(
          pokemonEntity.url, equals('https://pokeapi.co/api/v2/pokemon/25/'));
      expect(
        pokemonEntity.imageUrl,
        equals(
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png'),
      );
    });
  });

  group('ListPokemonModelMapper', () {
    test('toListEntity should convert a list of PokemonModel to PokemonEntity',
        () {
      const models = [
        PokemonModel(
            name: 'bulbasaur', url: 'https://pokeapi.co/api/v2/pokemon/1/'),
        PokemonModel(
            name: 'charmander', url: 'https://pokeapi.co/api/v2/pokemon/4/'),
      ];

      final entities = models.toListEntity();

      expect(entities.length, 2);

      expect(entities[0].name, 'bulbasaur');
      expect(
        entities[0].imageUrl,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      );

      expect(entities[1].name, 'charmander');
      expect(
        entities[1].imageUrl,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      );
    });
  });
}
