import 'package:flutter/material.dart';
import 'package:my_heroes/marvel_list/domain/entity/character_entity.dart';

class CardHeroComponent extends StatelessWidget {
  const CardHeroComponent({
    required this.character,
    super.key,
  });

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              child: Image.network(
                character.imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            character.name,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 70),
          Text(
            character.description,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
