import 'package:dartz/dartz.dart';
import 'package:my_heroes/core/error/failure.dart';
import 'package:my_heroes/marvel_list/data/datasource/list_characters_datasource.dart';
import 'package:my_heroes/marvel_list/data/model/mapper/character_model_mapper.dart';
import 'package:my_heroes/marvel_list/domain/entity/character_entity.dart';
import 'package:my_heroes/marvel_list/repository/list_characters_repository.dart';

class ListCharactersRepositoryImplementation
    implements IListCharactersRepository {
  final IListCharactersDatasource datasource;

  ListCharactersRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, List<CharacterEntity>>> listCharacters() async {
    try {
      var result = await datasource.listCharacters();
      return Right(result.toListEntity());
    } on DataPostFailure catch (e) {
      return Left(e);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
