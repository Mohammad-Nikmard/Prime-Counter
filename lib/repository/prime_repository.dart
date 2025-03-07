import 'package:dartz/dartz.dart';

abstract class PrimeRepository {
  Future<Either<String, int>> getPrimeNumber();
}
