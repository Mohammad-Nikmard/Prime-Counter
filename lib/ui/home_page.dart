import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prime_counter/bloc/prime_bloc.dart';
import 'package:prime_counter/bloc/prime_event.dart';
import 'package:prime_counter/bloc/prime_state.dart';
import 'package:prime_counter/core/constants/constants.dart';
import 'package:prime_counter/core/gen/fonts.gen.dart';
import 'package:prime_counter/ui/prime_notice_page.dart';
import 'package:prime_counter/util/data/calendar_detail.dart';
import 'package:prime_counter/util/extensions/calendar_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final time = DateTime.now();
  late Timer timer;
  late String timeStamp;

  late CalendarDetail currentTimeDetail;

  @override
  void initState() {
    currentTimeDetail = time.calendarDetails;

    timeStamp = time.currentTimeStamp;

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (context.mounted) {
          setState(() {
            timeStamp = DateFormat('HH:mm').format(DateTime.now());
          });
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              timeStamp,
              style: TextStyle(
                fontFamily: FontFamily.rr,
                fontSize: 100,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${currentTimeDetail.date}. ',
                        style: TextStyle(
                          fontFamily: FontFamily.rr,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: '${time.day}. ',
                        style: TextStyle(
                          fontFamily: FontFamily.rr,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: '${currentTimeDetail.month}. ',
                        style: TextStyle(
                          fontFamily: FontFamily.rr,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'KW ${currentTimeDetail.calendarWeek}',
                  style: TextStyle(
                    fontFamily: FontFamily.rr,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            BlocConsumer<PrimeBloc, PrimeState>(
              builder: (context, state) {
                if (state is PrimeLoadingState) {
                  return SizedBox(
                    height: 25,
                    width: 25,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return const SizedBox(
                    height: 25,
                    width: 25,
                  );
                }
              },
              listener: (context, state) {
                if (state is PrimeSearchResponseState) {
                  state.searchResponse.fold(
                    (exceptionMessage) {
                      print(exceptionMessage);
                    },
                    (response) async {
                      String? res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrimeNoticePage(
                            result: response,
                          ),
                        ),
                      );

                      if (res != null && context.mounted) {
                        context
                            .read<PrimeBloc>()
                            .add(SetPrimeTimerCallerEvent());
                      }
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
