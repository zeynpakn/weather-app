import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../models/weather_model.dart';

class WeatherService {
  final Dio _dio = DioClient().dio;

  Future<WeatherModel> fetchCityWeather(String city) async {
    final res = await _dio.get('/weather', queryParameters: {'q': city});
    return WeatherModel.fromJson(res.data as Map<String, dynamic>);
  }
}
