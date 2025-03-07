import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:prime_counter/util/api_exception.dart';
import 'package:prime_counter/util/api_provider.dart';

import 'api_provider_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<Dio>(),
])
void main() {
  late Dio mockDio;
  late ApiProvider apiProvider;

  final requestOptions = RequestOptions();

  Object result;

  setUp(() {
    mockDio = MockDio();
    apiProvider = ApiProvider(
      dio: mockDio,
    );
  });

  group(
    'Test cases of get Method',
    () {
      test(
        'Get Method : Success Case',
        () async {
          when(
            mockDio.get('test'),
          ).thenAnswer(
            (inv) async => Response(
              requestOptions: requestOptions,
            ),
          );

          try {
            result = await apiProvider.getMethod('test');
          } catch (ex) {
            result = ex;
          }

          expect(
            result,
            isA<Right>().having(
              (right) => right.value,
              'right value',
              isA<Response>(),
            ),
          );
        },
      );

      test(
        'Get Method : Dio Exception (Connection Timeout) Case',
        () async {
          when(
            mockDio.get('test'),
          ).thenThrow(
            DioException(
              requestOptions: requestOptions,
              type: DioExceptionType.connectionTimeout,
              response: Response(
                requestOptions: requestOptions,
              ),
            ),
          );

          try {
            await apiProvider.getMethod('test');
          } catch (ex) {
            expect(
              ex,
              isA<Left>().having(
                (left) => left.value,
                'left value',
                isA<ApiException>().having(
                  (exception) => exception.message,
                  'exception Message Check',
                  'Request time out',
                ),
              ),
            );
          }
        },
      );

      test(
        'Get Method : Dio Exception (Receive Timeout) Case',
        () async {
          when(
            mockDio.get('test'),
          ).thenThrow(
            DioException(
              requestOptions: requestOptions,
              type: DioExceptionType.receiveTimeout,
              response: Response(
                requestOptions: requestOptions,
              ),
            ),
          );

          try {
            await apiProvider.getMethod('test');
          } catch (ex) {
            expect(
              ex,
              isA<Left>().having(
                (left) => left.value,
                'Left Value',
                isA<ApiException>().having(
                  (exception) => exception.message,
                  'Exception Message Check',
                  'Request time out',
                ),
              ),
            );
          }
        },
      );

      test(
        'Get Method : Dio Exception (Else) Case',
        () async {
          when(
            mockDio.get('test'),
          ).thenThrow(
            DioException(
              requestOptions: requestOptions,
              type: DioExceptionType.unknown,
              response: Response(
                requestOptions: requestOptions,
              ),
            ),
          );

          try {
            await apiProvider.getMethod('tet');
          } catch (ex) {
            expect(
              ex,
              isA<Left>().having(
                (left) => left.value,
                'Left Value',
                isA<ApiException>().having(
                  (exception) => exception.message,
                  'Exception Message Check',
                  'UnknownError',
                ),
              ),
            );
          }
        },
      );

      test(
        'Get Method : Generic Exception Failure Case',
        () async {
          when(
            mockDio.get('test'),
          ).thenThrow(
            Exception(
              'Random Error',
            ),
          );

          try {
            await apiProvider.getMethod('test');
          } catch (ex) {
            expect(
              ex,
              isA<Left>().having(
                (left) => left.value,
                'left value',
                isA<ApiException>().having(
                  (exception) => exception.message,
                  'Exception Message Test',
                  'Random Error',
                ),
              ),
            );
          }
        },
      );
    },
  );
}
