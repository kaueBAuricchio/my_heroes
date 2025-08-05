import 'package:dio/dio.dart';
import 'package:my_heroes/pokemon_list/data/datasource/list_pokemons_datasource.dart';
import 'package:my_heroes/pokemon_list/data/model/pokemon_model.dart';

class ListCharactersDatasourceImplementation
    implements IListCharactersDatasource {
  final Dio dio;

  ListCharactersDatasourceImplementation(this.dio);

  @override
  Future<List<PokemonModel>> listPokemons(
      {int offset = 0, int limit = 151}) async {
    try {
      final url = 'https://pokeapi.co/api/v2/pokemon';
      final response = await dio.get(url, queryParameters: {
        'offset': offset,
        'limit': limit,
      });

      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];

        return PokemonModel.fromListMap(results);
      } else {
        throw Exception(response.statusCode.toString());
      }
    } on DioException catch (e) {
      throw Exception('Erro ao buscar personagens: ${e.message}');
    } catch (e) {
      rethrow;
    }
  }
}
