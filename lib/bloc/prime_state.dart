import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prime_counter/util/data/prime_calculation_result.dart';

abstract class PrimeState extends Equatable {}

class PrimeInitState extends PrimeState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class PrimeLoadingState extends PrimeState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class PrimeSearchResponseState extends PrimeState {
  final Either<String, PrimeCalculationResult> searchResponse;

  PrimeSearchResponseState(this.searchResponse);

  @override
  List<Object?> get props => [searchResponse];

  @override
  bool? get stringify => false;
}
