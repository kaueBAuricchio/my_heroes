import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_heroes/core/error/failure.dart';
import 'package:my_heroes/pokemon_list/data/datasource/list_pokemons_datasource.dart';
import 'package:my_heroes/pokemon_list/data/model/pokemon_model.dart';
import 'package:my_heroes/pokemon_list/domain/repository/list_pokemons_repository.dart';
import 'package:my_heroes/pokemon_list/domain/repository/list_pokemons_repository_implementation.dart';

class MockDatasource extends Mock implements IListCharactersDatasource {}

void main() {
  late MockDatasource mockDatasource;
  late IListPokemonsRepository repository;

  setUp(() {
    mockDatasource = MockDatasource();
    repository = ListPokemonsRepositoryImplementation(mockDatasource);
  });

  const mockPokemonModel = PokemonModel(
    name: 'pikachu',
    url: 'https://pokeapi.co/api/v2/pokemon/25/',
  );

  group('ListPokemonsRepositoryImplementation', () {
    test(
        'should return Right with a list of PokemonEntity when the call is successful',
        () async {
      // Arrange
      when(() => mockDatasource.listPokemons())
          .thenAnswer((_) async => [mockPokemonModel]);

      // Act
      final result = await repository.listPokemon();

      // Assert
      expect(result.isRight(), true);

      result.fold(
        (_) => fail('Should be Right'),
        (list) {
          expect(list.length, 1);
          expect(list.first.name, 'pikachu');
          expect(list.first.imageUrl,
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png');
        },
      );
    });

    test(
        'should return Left with DataPostFailure when DataPostFailure is thrown',
        () async {
      // Arrange
      final failure = DataPostFailure(message: 'Error');

      when(() => mockDatasource.listPokemons()).thenThrow(failure);

      // Act
      final result = await repository.listPokemon();

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (error) => expect(error, isA<DataPostFailure>()),
        (_) => fail('Should be Left'),
      );
    });

    test(
        'deve retornar Left com ServerFailure quando uma Exception genérica for lançada',
        () async {
      // Arrange
      when(() => mockDatasource.listPokemons()).thenThrow(Exception('Erro'));

      // Act
      final result = await repository.listPokemon();

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (error) => expect(error, isA<ServerFailure>()),
        (_) => fail('Deveria ser Left'),
      );
    });
  });
}
