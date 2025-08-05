import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_heroes/pokemon_list/data/datasource/list_pokemons_datasource_implementation.dart';
import 'package:my_heroes/pokemon_list/data/model/pokemon_model.dart';

// Mock do Dio
class DioMock extends Mock implements Dio {}

void main() {
  late Dio dio;
  late ListCharactersDatasourceImplementation datasource;

  setUp(() {
    dio = DioMock();
    datasource = ListCharactersDatasourceImplementation(dio);
  });

  group('ListCharactersDatasourceImplementation', () {
    test('should return a list of PokemonModel when the request is successful',
        () async {
      // Arrange
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {
          'results': [
            {
              'name': 'bulbasaur',
              'url': 'https://pokeapi.co/api/v2/pokemon/1/'
            },
            {'name': 'ivysaur', 'url': 'https://pokeapi.co/api/v2/pokemon/2/'},
          ],
        },
      );

      when(() => dio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await datasource.listPokemons();

      // Assert
      expect(result, isA<List<PokemonModel>>());
      expect(result.length, 2);
      expect(result[0].name, 'bulbasaur');
    });

    test('should throw an exception if statusCode is not 200', () async {
      // Arrange
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 404,
        data: {},
      );

      when(() => dio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(() => datasource.listPokemons(), throwsException);
    });

    test('should throw an exception if a DioException', () async {
      // Arrange
      when(() => dio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        message: 'Erro de rede',
        type: DioExceptionType.badResponse,
      ));

      // Act & Assert
      expect(() => datasource.listPokemons(), throwsException);
    });
  });
}
