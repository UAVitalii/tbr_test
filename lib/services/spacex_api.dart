import 'package:dio/dio.dart';
import '../models/rocket.dart';
import '../models/launch.dart';

class SpaceXApi {
  static const _baseUrl = 'https://api.spacexdata.com/v3';
  final Dio _dio;

  SpaceXApi({Dio? dio}) : _dio = dio ?? Dio(BaseOptions(baseUrl: _baseUrl));

  Future<List<Rocket>> getRockets() async {
    final response = await _dio.get('/rockets');
    return (response.data as List<dynamic>)
        .map((json) => Rocket.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<Launch>> getLaunches(String rocketId) async {
    final response = await _dio.get(
      '/launches',
      queryParameters: {'rocket_id': rocketId},
    );
    return (response.data as List<dynamic>)
        .map((json) => Launch.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
