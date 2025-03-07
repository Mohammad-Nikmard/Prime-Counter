import 'package:equatable/equatable.dart';

abstract class PrimeEvent extends Equatable {}

class SearchPrimeNumberEvent extends PrimeEvent {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class SetPrimeTimerCallerEvent extends PrimeEvent {
  SetPrimeTimerCallerEvent();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}
