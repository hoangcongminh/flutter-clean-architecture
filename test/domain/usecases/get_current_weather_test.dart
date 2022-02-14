import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/domain/entities/weather.dart';
import 'package:flutter_clean_architecture/domain/usecases/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetCurrentWeather usecase;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetCurrentWeather(mockWeatherRepository);
  });

  const testWeatherDetail = Weather(
    cityName: 'London',
    main: 'Clouds',
    description: 'scattered clouds',
    iconCode: '03d',
    temperature: 10.0,
    pressure: 1010,
    humidity: 50,
  );

  const tCityName = 'London';

  test('should have current weather detail from the repository', () async {
    //arrange
    when(mockWeatherRepository.getCurrentWeather(tCityName))
        .thenAnswer((_) async => const Right(testWeatherDetail));

    //act
    final result = await usecase.execute(tCityName);

    //assert
    expect(result, equals(const Right(testWeatherDetail)));
  });
}
