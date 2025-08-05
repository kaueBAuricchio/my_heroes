import 'package:equatable/equatable.dart';

class PokemonModel extends Equatable {
  final String name;
  final String url;

  const PokemonModel({
    this.name = '',
    this.url = '',
  });

  factory PokemonModel.fromJson(Map<String, dynamic> map) {
    return PokemonModel(
      name: map['name'] ?? '',
      url: map['url'] ?? '',
    );
  }

  static List<PokemonModel> fromListMap(List maps) {
    return maps.map((map) => PokemonModel.fromJson(map)).toList();
  }

  String get imageUrl {
    final id = url.split('/')[url.split('/').length - 2];
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
  }

  @override
  List<Object?> get props => [
        name,
        url,
      ];
}
