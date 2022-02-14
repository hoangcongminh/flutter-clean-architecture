class Urls {
  static const String baseUrl = '';
  static const String apiKey = '';
  static String currentWeatherByCity(String city) =>
      '$baseUrl/weather?q=$city&appid=$apiKey';
  static String weatherIcon(String iconCode) => '';
}
