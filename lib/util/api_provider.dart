import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prime_counter/util/api_exception.dart';

class ApiProvider {
  final Dio _dio;

  const ApiProvider({required Dio dio}) : _dio = dio;

  Future<Either<ApiException, dynamic>> getMethod(String endPoint) async {
    try {
      final response = await _dio.get(endPoint);

      return right(response);
    } on DioException catch (ex) {
      return _handleDioExceptionType(ex);
    } catch (ex) {
      return _handleGenericException(ex);
    }
  }

  Left<ApiException, dynamic> _handleDioExceptionType(DioException exception) {
    if (exception.type == DioExceptionType.connectionTimeout ||
        exception.type == DioExceptionType.receiveTimeout) {
      return Left(
        ApiException(message: 'Request time out'),
      );
    } else {
      return Left(
        ApiException(
          message: exception.message ?? 'UnknownError',
          errorCode: exception.response?.statusCode,
        ),
      );
    }
  }

  Left<ApiException, dynamic> _handleGenericException(dynamic exception) {
    return Left(
      ApiException(message: '$exception'),
    );
  }
}
