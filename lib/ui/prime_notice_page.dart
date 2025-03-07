import 'package:flutter/material.dart';
import 'package:prime_counter/core/constants/constants.dart';
import 'package:prime_counter/core/gen/fonts.gen.dart';
import 'package:prime_counter/util/data/prime_calculation_result.dart';

class PrimeNoticePage extends StatelessWidget {
  const PrimeNoticePage({
    super.key,
    required this.result,
  });
  final PrimeCalculationResult result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                child: SizedBox(
                  height: 10,
                  width: 30,
                  child: ColoredBox(
                    color: AppColors.greenColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Congrats!',
                    style: TextStyle(
                      fontFamily: FontFamily.rr,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'You obtained a prime number, it was: ${result.primeNumber}',
                    style: TextStyle(
                      fontFamily: FontFamily.rr,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Time since last prime number : ${result.elapsedTime.inSeconds} seconds',
                    style: TextStyle(
                      fontFamily: FontFamily.rr,
                      fontSize: 14,
                      color: AppColors.grayColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context, 'Success'),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      fontFamily: FontFamily.rr,
                      fontSize: 18,
                      color: Color(0xff131c20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
