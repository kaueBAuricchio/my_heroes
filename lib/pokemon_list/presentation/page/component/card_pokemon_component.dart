import 'package:flutter/material.dart';
import 'package:my_heroes/pokemon_list/domain/entity/pokemon_entity.dart';

class CardPokemonComponent extends StatelessWidget {
  const CardPokemonComponent({
    required this.pokemonEntity,
    super.key,
  });

  final PokemonEntity pokemonEntity;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              height: screenHeight * 0.35,
              width: double.infinity,
              child: Image.network(
                pokemonEntity.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              pokemonEntity.name,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
