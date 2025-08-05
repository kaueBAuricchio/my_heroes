import 'package:equatable/equatable.dart';

class PokemonEntity extends Equatable {
  final String name;
  final String url;
  final String imageUrl;

  const PokemonEntity({
    this.name = '',
    this.url = '',
    this.imageUrl = '',
  });

  @override
  List<Object?> get props => [
        name,
        url,
        imageUrl,
      ];
}
