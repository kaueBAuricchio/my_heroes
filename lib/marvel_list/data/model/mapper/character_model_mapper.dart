import 'package:my_heroes/marvel_list/data/model/character_model.dart';
import 'package:my_heroes/marvel_list/domain/entity/character_entity.dart';

extension CharacterModelMapper on CharacterModel {
  CharacterEntity toEntity() => CharacterEntity(
        id: id,
        name: name,
        description: description,
        modified: modified,
        imgUrl: imgUrl,
      );
}

extension ListCharcterModelMapper on List<CharacterModel> {
  List<CharacterEntity> toListEntity() =>
      map((model) => model.toEntity()).toList();
}
