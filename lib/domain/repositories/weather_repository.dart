import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/data/failure.dart';
import 'package:flutter_clean_architecture/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
}
