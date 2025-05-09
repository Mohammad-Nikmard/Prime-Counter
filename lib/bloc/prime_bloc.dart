import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_counter/bloc/prime_event.dart';
import 'package:prime_counter/bloc/prime_state.dart';
import 'package:prime_counter/repository/prime_repository.dart';
import 'package:prime_counter/util/data/prime_calculation_result.dart';
import 'package:prime_counter/util/extensions/prime_extension.dart';
import 'package:prime_counter/util/prime_manager.dart';

class PrimeBloc extends Bloc<PrimeEvent, PrimeState> {
  final PrimeRepository _primeRepository;
  final PrimeManager _primeManager;
  late Timer? timer;
  PrimeBloc(this._primeRepository, this._primeManager)
      : super(PrimeInitState()) {
    int requestCallTimeCounter = -1;

    void startTimer() {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) {
          if (requestCallTimeCounter > 0) {
            requestCallTimeCounter--;
          } else if (requestCallTimeCounter == 0) {
            timer?.cancel();
            add(SearchPrimeNumberEvent());
          }
        },
      );
    }

    Future<void> handlePrimeNumberResult(
        PrimeEvent event, Emitter<PrimeState> emit, int number) async {
      final savedTime = _primeManager.getPreviousSavedPrimeTime();
      final Duration calculatedElapsedTime;

      if (savedTime == 0) {
        calculatedElapsedTime = Duration.zero;
      } else {
        final oldConvertedTime = DateTime.fromMillisecondsSinceEpoch(savedTime);
        calculatedElapsedTime = DateTime.now().difference(oldConvertedTime);
      }

      emit(
        PrimeSearchResponseState(
          Right(
            PrimeCalculationResult(
              primeNumber: number,
              elapsedTime: calculatedElapsedTime,
            ),
          ),
        ),
      );

      await _primeManager.saveCurrentPrimeTimeStamp(
        DateTime.now().millisecondsSinceEpoch,
      );
    }

    on<SearchPrimeNumberEvent>(
      (event, emit) async {
        emit(PrimeLoadingState());

        final searchResponse = await _primeRepository.getPrimeNumber();

        searchResponse.fold(
          (exceptionMessage) {
            emit(
              PrimeSearchResponseState(Left(exceptionMessage)),
            );

            add(SetPrimeTimerCallerEvent());
          },
          (number) async {
            final primeResult = number.isPrime;

            if (primeResult) {
              await handlePrimeNumberResult(event, emit, number);
            } else {
              emit(
                PrimeSearchResponseState(
                  Left('NOT A PRIME NUMBER'),
                ),
              );
              add(SetPrimeTimerCallerEvent());
            }
          },
        );
      },
    );

    on<SetPrimeTimerCallerEvent>(
      (event, emit) async {
        requestCallTimeCounter = 10;
        startTimer();
      },
    );
  }

  @override
  Future<void> close() async {
    timer?.cancel();
    super.close();
  }
}
