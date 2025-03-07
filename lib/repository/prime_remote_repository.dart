import 'package:dartz/dartz.dart';
import 'package:prime_counter/repository/prime_repository.dart';
import 'package:prime_counter/util/api_provider.dart';

class PrimeRemoteRepository implements PrimeRepository {
  final ApiProvider _apiProvider;

  const PrimeRemoteRepository({required ApiProvider apiProvider})
      : _apiProvider = apiProvider;

  @override
  Future<Either<String, int>> getPrimeNumber() async {
    final response = await _apiProvider.getMethod(
      'v1.0/random',
    );

    return response.fold(
      (exceptionMessage) => left(exceptionMessage.message),
      (response) => right(response.data[0]),
    );
  }
}
