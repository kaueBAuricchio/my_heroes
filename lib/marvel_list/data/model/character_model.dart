import 'package:equatable/equatable.dart';

class CharacterModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final String modified;
  final String imgUrl;

  const CharacterModel({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.modified = '',
    this.imgUrl = '',
  });

  factory CharacterModel.fromJson(Map<String, dynamic> map) {
    return CharacterModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      modified: map['modified'] ?? '',
      // ignore: prefer_interpolation_to_compose_strings
      imgUrl:
          map['thumbnail']['path'] + '.' + map['thumbnail']['extension'] ?? '',
    );
  }

  static List<CharacterModel> fromListMap(List maps) {
    return maps.map((map) => CharacterModel.fromJson(map)).toList();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        modified,
        imgUrl,
      ];
}
