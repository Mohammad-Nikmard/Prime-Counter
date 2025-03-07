import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prime_counter/bloc/prime_bloc.dart';
import 'package:prime_counter/bloc/prime_event.dart';
import 'package:prime_counter/bloc/prime_state.dart';
import 'package:prime_counter/repository/prime_remote_repository.dart';
import 'package:prime_counter/repository/prime_repository.dart';
import 'package:prime_counter/util/data/prime_calculation_result.dart';
import 'package:prime_counter/util/prime_manager.dart';
import 'prime_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<PrimeRemoteRepository>(),
  MockSpec<PrimeManager>(),
])
void main() {
  late PrimeRepository mockRepo;
  late PrimeManager mockManager;
  late PrimeBloc bloc;

  final timeStamp = DateTime.now().millisecondsSinceEpoch;

  group(
    'Test Cases of Prime Bloc',
    () {
      const int nonPrimeNumber = 10;
      const int primeNumber = 11;

      blocTest<PrimeBloc, PrimeState>(
        'Search Prime Number Event : Failure Case',
        setUp: () {
          mockRepo = MockPrimeRemoteRepository();
          mockManager = MockPrimeManager();
          bloc = PrimeBloc(mockRepo, mockManager);
        },
        build: () {
          when(mockRepo.getPrimeNumber()).thenAnswer(
            (inv) async => Left('Error'),
          );

          return bloc;
        },
        act: (bloc) => bloc.add(SearchPrimeNumberEvent()),
        expect: () => [
          PrimeLoadingState(),
          PrimeSearchResponseState(
            Left('Error'),
          ),
        ],
        verify: (bloc) {
          verifyNever(mockManager.saveCurrentPrimeTimeStamp(timeStamp));
        },
      );

      blocTest<PrimeBloc, PrimeState>(
        'Search Prime Number Event : Prime Number',
        setUp: () {
          mockRepo = MockPrimeRemoteRepository();
          mockManager = MockPrimeManager();
          bloc = PrimeBloc(mockRepo, mockManager);
        },
        build: () {
          when(mockRepo.getPrimeNumber())
              .thenAnswer((inv) async => Right(primeNumber));

          when(mockManager.getPreviousSavedPrimeTime()).thenReturn(0);

          return bloc;
        },
        act: (bloc) => bloc.add(SearchPrimeNumberEvent()),
        expect: () => [
          PrimeLoadingState(),
          PrimeSearchResponseState(
            Right(
              PrimeCalculationResult(
                primeNumber: primeNumber,
                elapsedTime: Duration.zero,
              ),
            ),
          ),
        ],
      );

      blocTest<PrimeBloc, PrimeState>(
        'Search Prime Number Event : Non Prime Number',
        setUp: () {
          mockRepo = MockPrimeRemoteRepository();
          mockManager = MockPrimeManager();
          bloc = PrimeBloc(mockRepo, mockManager);
        },
        build: () {
          when(mockRepo.getPrimeNumber())
              .thenAnswer((inv) async => Right(nonPrimeNumber));

          return bloc;
        },
        act: (bloc) => bloc.add(SearchPrimeNumberEvent()),
        expect: () => [
          PrimeLoadingState(),
          PrimeSearchResponseState(
            Left(
              'NOT A PRIME NUMBER',
            ),
          ),
        ],
        verify: (bloc) {
          verifyNever(mockManager.saveCurrentPrimeTimeStamp(timeStamp));
        },
      );
    },
  );
}
