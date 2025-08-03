import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_heroes/marvel_list/data/datasource/list_characters_datasource_implementation.dart';
import 'package:my_heroes/marvel_list/presentation/cubit/list_characters_cubit.dart';
import 'package:my_heroes/marvel_list/presentation/page/character_list_page.dart';
import 'package:my_heroes/marvel_list/repository/list_characters_repository_implementation.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => Dio()),
    Bind((i) => ListCharactersDatasourceImplementation(i.get())),
    Bind((i) => ListCharactersRepositoryImplementation(i.get())),
    Bind((i) => ListCharactersCubit(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const CharacterListPage()),
  ];
}
