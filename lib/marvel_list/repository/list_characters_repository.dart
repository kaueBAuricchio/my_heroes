import 'package:dartz/dartz.dart';
import 'package:my_heroes/core/error/failure.dart';
import 'package:my_heroes/marvel_list/domain/entity/character_entity.dart';

abstract class IListCharactersRepository {
  Future<Either<Failure, List<CharacterEntity>>> listCharacters();
}
