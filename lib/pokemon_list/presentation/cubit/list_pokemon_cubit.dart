import 'package:bloc/bloc.dart';
import 'package:my_heroes/pokemon_list/domain/entity/pokemon_entity.dart';
import 'package:my_heroes/pokemon_list/domain/repository/list_pokemons_repository.dart';
import 'package:my_heroes/core/state/cubit_state.dart';

class ListPokemonCubit extends Cubit<CubitState> {
  final IListPokemonsRepository _repository;

  List<PokemonEntity> pokemonList = [];
  bool hasMore = true;
  bool isLoading = false;

  ListPokemonCubit(this._repository) : super(CubitState.empty());

  Future<void> listPokemon() async {
    if (isLoading || !hasMore) return;

    isLoading = true;

    final isFirstLoad = pokemonList.isEmpty;
    if (isFirstLoad) emit(LoadingCubitState());

    final result = await _repository.listPokemon();
    final state = result.fold(
      (failure) => CubitState.error(message: 'Erro ao carregar pokémons'),
      (newPokemons) {
        pokemonList.addAll(newPokemons);
        return CubitState.success(value: pokemonList);
      },
    );

    emit(state);
    isLoading = false;
  }
}
