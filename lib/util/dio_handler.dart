import 'package:dio/dio.dart';

class DioHandler {
  static Dio getDio() {
    final Dio dio = Dio(
      BaseOptions(baseUrl: 'http://www.randomnumberapi.com/api/'),
    );

    return dio;
  }
}
