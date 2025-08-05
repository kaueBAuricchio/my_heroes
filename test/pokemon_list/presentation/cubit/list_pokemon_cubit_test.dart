import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_heroes/core/error/failure.dart';
import 'package:my_heroes/core/state/cubit_state.dart';
import 'package:my_heroes/pokemon_list/domain/entity/pokemon_entity.dart';
import 'package:my_heroes/pokemon_list/domain/repository/list_pokemons_repository.dart';
import 'package:my_heroes/pokemon_list/presentation/cubit/list_pokemon_cubit.dart';

class MockListPokemonsRepository extends Mock
    implements IListPokemonsRepository {}

void main() {
  late MockListPokemonsRepository mockRepository;

  const pokemon = PokemonEntity(
    name: 'pikachu',
    url: 'https://pokeapi.co/api/v2/pokemon/25/',
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png',
  );

  setUp(() {
    mockRepository = MockListPokemonsRepository();
  });

  group('ListPokemonCubit', () {
    blocTest<ListPokemonCubit, CubitState>(
      'should emit [LoadingCubitState, CubitState.success] when listPokemon succeeds',
      build: () {
        when(() => mockRepository.listPokemon())
            .thenAnswer((_) async => const Right([pokemon]));
        return ListPokemonCubit(mockRepository);
      },
      act: (cubit) => cubit.listPokemon(),
      expect: () => [
        isA<LoadingCubitState>(),
        CubitState.success(value: [pokemon]),
      ],
    );

    blocTest<ListPokemonCubit, CubitState>(
      'should throw [LoadingCubitState, CubitState.error] when a failure occurs',
      build: () {
        when(() => mockRepository.listPokemon())
            .thenAnswer((_) async => Left(ServerFailure()));
        return ListPokemonCubit(mockRepository);
      },
      act: (cubit) => cubit.listPokemon(),
      expect: () => [
        isA<LoadingCubitState>(),
        CubitState.error(message: 'Erro ao carregar pokémons'),
      ],
    );

    blocTest<ListPokemonCubit, CubitState>(
        'should not emit any status if isLoading is true', build: () {
      when(() => mockRepository.listPokemon())
          .thenAnswer((_) async => const Right([pokemon]));
      final cubit = ListPokemonCubit(mockRepository);
      cubit.isLoading = true;
      return cubit;
    });
  });
}
