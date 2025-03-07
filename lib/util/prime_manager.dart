import 'package:shared_preferences/shared_preferences.dart';

class PrimeManager {
  final SharedPreferences _sharedPref;

  final _primeKey = 'PrimeKey';

  const PrimeManager({required SharedPreferences sharedPref})
      : _sharedPref = sharedPref;

  Future<void> saveCurrentPrimeTimeStamp(int timeStamp) async {
    await _sharedPref.setInt(_primeKey, timeStamp);
  }

  int getPreviousSavedPrimeTime() {
    return _sharedPref.getInt(_primeKey) ?? 0;
  }
}
