import 'package:flutter_test/flutter_test.dart';
import 'package:prime_counter/util/prime_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferences mockPref;
  late PrimeManager manager;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    mockPref = await SharedPreferences.getInstance();
    manager = PrimeManager(sharedPref: mockPref);
  });

  group('Test Cases of Prime Manager Clasee', () {
    const String primeKey = 'PrimeKey';
    const int timeStamp = 10;

    test('Save Current Prim Time Stamp', () async {
      await manager.saveCurrentPrimeTimeStamp(timeStamp);

      expect(
        mockPref.getInt(primeKey),
        timeStamp,
      );
    });

    test('Get Previous Saved Prime Time with Data', () async {
      await manager.saveCurrentPrimeTimeStamp(timeStamp);

      expect(
        manager.getPreviousSavedPrimeTime(),
        timeStamp,
      );
    });

    test('Get Previous Saved Prime Time Without Data', () {
      expect(
        manager.getPreviousSavedPrimeTime(),
        0,
      );
    });
  });
}
