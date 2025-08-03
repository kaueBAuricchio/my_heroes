import 'package:bloc/bloc.dart';
import 'package:my_heroes/marvel_list/domain/entity/character_entity.dart';
import 'package:my_heroes/marvel_list/repository/list_characters_repository.dart';
import 'package:my_heroes/core/state/cubit_state.dart';

class ListCharactersCubit extends Cubit<CubitState> {
  final IListCharactersRepository _repository;

  List<CharacterEntity> charactersList = [];

  ListCharactersCubit(this._repository) : super(CubitState.empty());

  Future<void> listCharacters() async {
    emit(CubitState.loading());

    final result = await _repository.listCharacters();
    final state =
        result.fold((failure) => CubitState.error(message: ''), (characters) {
      charactersList = characters;
      return CubitState.success(value: characters);
    });

    emit(state);
  }
}
