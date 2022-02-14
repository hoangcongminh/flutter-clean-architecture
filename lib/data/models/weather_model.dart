import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/domain/entities/weather.dart';

class WeatherModel extends Equatable {
  const WeatherModel({
    required this.cityName,
    required this.main,
    required this.description,
    required this.iconCode,
    required this.temperature,
    required this.pressure,
    required this.humidity,
  });
  final String cityName;
  final String main;
  final String description;
  final String iconCode;
  final double temperature;
  final int pressure;
  final int humidity;

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] as String,
      main: json['weather'][0]['main'] as String,
      description: json['weather'][0]['description'] as String,
      iconCode: json['weather'][0]['icon'] as String,
      temperature: json['main']['temp'] as double,
      pressure: json['main']['pressure'] as int,
      humidity: json['main']['humidity'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'weather': [
          {
            'main': main,
            'description': description,
            'icon': iconCode,
          }
        ],
        'main': {
          'temp': temperature,
          'pressure': pressure,
          'humidity': humidity,
        },
        'name': cityName,
      };

  Weather toEntity() => Weather(
        cityName: cityName,
        main: main,
        description: description,
        iconCode: iconCode,
        temperature: temperature,
        pressure: pressure,
        humidity: humidity,
      );

  @override
  List<Object?> get props => [
        cityName,
        main,
        description,
        iconCode,
        temperature,
        pressure,
        humidity,
      ];
}
