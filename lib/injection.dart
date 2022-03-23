import 'package:flutter_clean_architecture/data/datasources/remote_data_source.dart';
import 'package:flutter_clean_architecture/data/repositories/weather_repository_impl.dart';
import 'package:flutter_clean_architecture/domain/repositories/weather_repository.dart';
import 'package:flutter_clean_architecture/domain/usecases/get_current_weather.dart';
import 'package:flutter_clean_architecture/presentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetCurrentWeather(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImp(
      client: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
