import 'dart:convert';

import 'package:flutter_clean_architecture/data/constants.dart';
import 'package:flutter_clean_architecture/data/datasources/remote_data_source.dart';
import 'package:flutter_clean_architecture/data/exception.dart';
import 'package:flutter_clean_architecture/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late RemoteDataSourceImp dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteDataSourceImp(client: mockHttpClient);
  });

  group('get current weather', () {
    const tCityName = 'Jakarta';
    final tWeatherModel = WeatherModel.fromJson(
        json.decode(readJson('helpers/mock_data/mock_weather_response.json')));

    test('should return weather model when the response code is 200', () async {
      // arrange
      when(
        mockHttpClient.get(Uri.parse(Urls.currentWeatherByCity(tCityName))),
      ).thenAnswer(
        (_) async => http.Response(
            readJson('helpers/mock_data/mock_weather_response.json'), 200),
      );
      //act
      final result = await dataSource.getCurrentWeather(tCityName);

      //assert
      expect(result, equals(tWeatherModel));
    });

    test(
        'should throw a server exception when the response code is 404 or other',
        () async {
      // arrange
      when(
        mockHttpClient.get(Uri.parse(Urls.currentWeatherByCity(tCityName))),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );
      //act
      final call = dataSource.getCurrentWeather(tCityName);

      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
