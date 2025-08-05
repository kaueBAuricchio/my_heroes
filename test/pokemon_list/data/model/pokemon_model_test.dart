import 'package:flutter_test/flutter_test.dart';
import 'package:my_heroes/pokemon_list/data/model/pokemon_model.dart';

void main() {
  group('PokemonModel', () {
    test('must create a PokemonModel with default values', () {
      const model = PokemonModel();

      expect(model.name, '');
      expect(model.url, '');
    });

    test('fromJson must return a valid PokemonModel', () {
      final map = {
        'name': 'pikachu',
        'url': 'https://pokeapi.co/api/v2/pokemon/25/',
      };

      final model = PokemonModel.fromJson(map);

      expect(model.name, 'pikachu');
      expect(model.url, 'https://pokeapi.co/api/v2/pokemon/25/');
    });

    test('fromListMap should return a list of PokemonModel', () {
      final listMap = [
        {'name': 'bulbasaur', 'url': 'https://pokeapi.co/api/v2/pokemon/1/'},
        {'name': 'charmander', 'url': 'https://pokeapi.co/api/v2/pokemon/4/'},
      ];

      final models = PokemonModel.fromListMap(listMap);

      expect(models.length, 2);
      expect(models[0].name, 'bulbasaur');
      expect(models[1].name, 'charmander');
    });

    test('imageUrl should return the correct image URL', () {
      const model = PokemonModel(
        name: 'squirtle',
        url: 'https://pokeapi.co/api/v2/pokemon/7/',
      );

      final expectedImageUrl =
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png';

      expect(model.imageUrl, expectedImageUrl);
    });

    test('two models with the same values must be equal (Equatable)', () {
      const pokemon1 = PokemonModel(
        name: 'eevee',
        url: 'https://pokeapi.co/api/v2/pokemon/133/',
      );

      const pokemon2 = PokemonModel(
        name: 'eevee',
        url: 'https://pokeapi.co/api/v2/pokemon/133/',
      );

      expect(pokemon1, equals(pokemon2));
    });
  });
}
