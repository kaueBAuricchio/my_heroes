import 'package:dartz/dartz.dart';
import 'package:my_heroes/core/error/failure.dart';
import 'package:my_heroes/pokemon_list/data/datasource/list_pokemons_datasource.dart';
import 'package:my_heroes/pokemon_list/data/model/mapper/pokemon_model_mapper.dart';
import 'package:my_heroes/pokemon_list/domain/entity/pokemon_entity.dart';
import 'package:my_heroes/pokemon_list/domain/repository/list_pokemons_repository.dart';

class ListPokemonsRepositoryImplementation implements IListPokemonsRepository {
  final IListCharactersDatasource datasource;

  ListPokemonsRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, List<PokemonEntity>>> listPokemon() async {
    try {
      var result = await datasource.listPokemons();
      return Right(result.toListEntity());
    } on DataPostFailure catch (e) {
      return Left(e);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
