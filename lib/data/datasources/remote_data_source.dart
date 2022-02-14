import 'dart:convert';

import 'package:flutter_clean_architecture/data/constants.dart';
import 'package:flutter_clean_architecture/data/exception.dart';
import 'package:flutter_clean_architecture/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class RemoteDataSourceImp implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImp({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByCity(cityName)));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
