import 'package:equatable/equatable.dart';

class CharacterEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String modified;
  final String imgUrl;

  const CharacterEntity({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.modified = '',
    this.imgUrl = '',
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        modified,
        imgUrl,
      ];
}
