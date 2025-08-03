import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:my_heroes/marvel_list/data/datasource/list_characters_datasource.dart';
import 'package:my_heroes/marvel_list/data/model/character_model.dart';

class ListCharactersDatasourceImplementation
    implements IListCharactersDatasource {
  final Dio dio;
  final String publicKey = '8ab9e86f16211efae1de3424873db3a0';
  final String privateKey = 'd4757772e4565a9c35ba741e33cf071429bda0af';
  final String baseUrl = 'https://gateway.marvel.com/v1/public';

  ListCharactersDatasourceImplementation(this.dio);

  @override
  Future<List<CharacterModel>> listCharacters() async {
    final timestamp = '1';
    final hash = generateHash(timestamp);

    try {
      final response = await dio.get(
        '$baseUrl/characters',
        queryParameters: {
          'ts': timestamp,
          'apikey': publicKey,
          'hash': hash,
        },
      );

      print('✅ StatusCode: ${response.statusCode}');

      if (response.statusCode == 200) {
        return CharacterModel.fromListMap(response.data);
      } else {
        throw Exception(response.statusCode.toString());
      }
    } on DioException catch (e) {
      print('❌ DioError: ${e.response?.statusCode}');
      print('❌ DioError data: ${e.response?.data}');
      throw Exception('Erro ao buscar personagens: ${e.message}');
    } catch (e) {
      print('❌ Erro inesperado: $e');
      rethrow;
    }
  }

  String generateHash(String timestamp) {
    final content = timestamp + privateKey + publicKey;
    final bytes = utf8.encode(content);
    final digest = md5.convert(bytes);
    return digest.toString();
  }
}
