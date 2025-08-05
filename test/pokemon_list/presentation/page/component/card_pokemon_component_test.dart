import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_heroes/pokemon_list/domain/entity/pokemon_entity.dart';
import 'package:my_heroes/pokemon_list/presentation/page/component/card_pokemon_component.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('CardPokemonComponent should display the Pokemons name and image',
      (WidgetTester tester) async {
    // Arrange
    const testPokemon = PokemonEntity(
      name: 'Pikachu',
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png',
    );

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CardPokemonComponent(pokemonEntity: testPokemon),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Pikachu'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
    });
  });
}
