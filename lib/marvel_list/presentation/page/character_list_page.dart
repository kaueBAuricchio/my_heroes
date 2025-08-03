import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_heroes/core/state/cubit_state.dart';
import 'package:my_heroes/marvel_list/presentation/cubit/list_characters_cubit.dart';
import 'package:my_heroes/marvel_list/presentation/page/component/card_hero_component.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  final cubit = Modular.get<ListCharactersCubit>();

  @override
  void initState() {
    cubit.listCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListCharactersCubit, CubitState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is LoadingCubitState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ErrorCubitState) {
          return const Center(child: CircularProgressIndicator());
        }
        final component = cubit.charactersList;
        return Scaffold(
          appBar: AppBar(
            title: const Text('My heroes'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider(
                    items: component
                        .map((characters) =>
                            CardHeroComponent(character: characters))
                        .toList(),
                    options: CarouselOptions(
                      height: 250,
                      enlargeCenterPage: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                      children: component
                          .map((characters) =>
                              CardHeroComponent(character: characters))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
