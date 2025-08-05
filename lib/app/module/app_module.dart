import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_heroes/pokemon_list/data/datasource/list_pokemons_datasource_implementation.dart';
import 'package:my_heroes/pokemon_list/presentation/cubit/list_pokemon_cubit.dart';
import 'package:my_heroes/pokemon_list/presentation/page/pokemon_list_page.dart';
import 'package:my_heroes/pokemon_list/domain/repository/list_pokemons_repository_implementation.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => Dio()),
    Bind((i) => ListCharactersDatasourceImplementation(i.get())),
    Bind((i) => ListPokemonsRepositoryImplementation(i.get())),
    Bind((i) => ListPokemonCubit(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const PokemonListPage()),
  ];
}
