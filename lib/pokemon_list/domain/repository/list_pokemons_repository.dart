import 'package:dartz/dartz.dart';
import 'package:my_heroes/core/error/failure.dart';
import 'package:my_heroes/pokemon_list/domain/entity/pokemon_entity.dart';

abstract class IListPokemonsRepository {
  Future<Either<Failure, List<PokemonEntity>>> listPokemon();
}
