import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_heroes/app/module/app_module.dart';
import 'package:my_heroes/pokemon_list/data/datasource/list_pokemons_datasource_implementation.dart';
import 'package:my_heroes/pokemon_list/domain/repository/list_pokemons_repository_implementation.dart';
import 'package:my_heroes/pokemon_list/presentation/cubit/list_pokemon_cubit.dart';
import 'package:dio/dio.dart';
import 'package:modular_test/modular_test.dart';

void main() {
  setUpAll(() {
    initModule(AppModule());
  });

  test('Must inject Dio', () {
    final dio = Modular.get<Dio>();
    expect(dio, isA<Dio>());
  });

  test('Must inject ListCharactersDatasourceImplementation', () {
    final datasource = Modular.get<ListCharactersDatasourceImplementation>();
    expect(datasource, isA<ListCharactersDatasourceImplementation>());
  });

  test('Must inject ListPokemonsRepositoryImplementation', () {
    final repository = Modular.get<ListPokemonsRepositoryImplementation>();
    expect(repository, isA<ListPokemonsRepositoryImplementation>());
  });

  test('Must inject ListPokemonCubit', () {
    final cubit = Modular.get<ListPokemonCubit>();
    expect(cubit, isA<ListPokemonCubit>());
  });
}
