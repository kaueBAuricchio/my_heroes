import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_heroes/core/state/cubit_state.dart';
import 'package:my_heroes/pokemon_list/presentation/cubit/list_pokemon_cubit.dart';
import 'package:my_heroes/pokemon_list/presentation/page/component/card_pokemon_component.dart';
import 'package:my_heroes/pokemon_list/presentation/page/shimmer/pokemon_list_shimmer.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<PokemonListPage> {
  final cubit = Modular.get<ListPokemonCubit>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    cubit.listPokemon();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      cubit.listPokemon();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<ListPokemonCubit, CubitState>(
      bloc: cubit,
      builder: (context, state) {
        final allPokemons = cubit.pokemonList;
        final showLoader = cubit.hasMore && state is LoadingCubitState;

        if (state is LoadingCubitState && allPokemons.isEmpty) {
          return PokemonListShimmer();
        }
        if (state is ErrorCubitState && allPokemons.isEmpty) {
          return const Center(child: Text('Erro ao carregar pokémons'));
        }
        if (allPokemons.isEmpty) {
          return const Center(child: Text('Nenhum pokémon encontrado.'));
        }

        final carouselPokemons = allPokemons.length >= 5
            ? allPokemons.take(5).toList()
            : allPokemons;
        final listPokemons =
            allPokemons.length > 5 ? allPokemons.skip(5).toList() : [];

        return Scaffold(
          appBar: AppBar(title: const Text('Pokemons')),
          body: Column(
            children: [
              CarouselSlider(
                items: carouselPokemons
                    .map((pokemon) =>
                        CardPokemonComponent(pokemonEntity: pokemon))
                    .toList(),
                options: CarouselOptions(
                  height: screenHeight * 0.35,
                  enlargeCenterPage: true,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: listPokemons.length + (showLoader ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (showLoader && index == listPokemons.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final pokemon = listPokemons[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: CardPokemonComponent(pokemonEntity: pokemon),
                      );
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
