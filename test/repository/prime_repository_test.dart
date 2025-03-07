import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:prime_counter/repository/prime_remote_repository.dart';
import 'package:prime_counter/repository/prime_repository.dart';
import 'package:prime_counter/util/api_exception.dart';
import 'package:prime_counter/util/api_provider.dart';

import 'prime_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ApiProvider>(),
])
void main() {
  late ApiProvider mockApiProvider;
  late PrimeRepository repo;

  final RequestOptions requestOptions = RequestOptions();

  Object result;

  setUp(() {
    mockApiProvider = MockApiProvider();
    repo = PrimeRemoteRepository(apiProvider: mockApiProvider);
  });

  group(
    'Test Cases of Get Prime Number',
    () {
      test(
        'Get Prime Number : Success Case',
        () async {
          when(
            mockApiProvider.getMethod(
              'v1.0/random',
            ),
          ).thenAnswer(
            (inv) async => Right(
              Response(
                requestOptions: requestOptions,
                data: [0],
              ),
            ),
          );

          try {
            result = await repo.getPrimeNumber();
          } catch (ex) {
            result = ex;
          }

          expect(
            result,
            isA<Right>().having(
              (right) => right.value,
              'Right value',
              0,
            ),
          );
        },
      );

      test(
        'Get Prime Number: Failure Case',
        () async {
          when(
            mockApiProvider.getMethod(
              'v1.0/random',
            ),
          ).thenAnswer(
            (inv) async => Left(
              ApiException(
                message: 'Error',
              ),
            ),
          );

          try {
            await repo.getPrimeNumber();
          } catch (ex) {
            expect(
              ex,
              isA<Left>().having(
                (left) => left.value,
                'left Val',
                'Error',
              ),
            );
          }
        },
      );
    },
  );
}
