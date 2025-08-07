import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabeet_app/cubit/cubit/schedule_cubit.dart';

import 'package:mabeet_app/setting_screen.dart';
import 'package:table_calendar/table_calendar.dart';

import 'models/models.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _focusedDay = DateTime(2024, 4, 1);
  var colorMap = {};
  /* final schedule = ScheduleModel(
    wivesStay: [
      WifeStayModel(id: 1, name: 'خلود', color: Color(0xFF4FD1C5), days: 3),
      WifeStayModel(id: 2, name: 'وردة', color: Color(0xFFF597AD), days: 2),
      WifeStayModel(id: 3, name: 'حنان', color: Color(0xFFB4A9FF), days: 1),
    ],
    outHomeDays: {
      "2025-07": OutHomeModel(
        id: "2025-07",
        from: DateTime(2024, 4, 1),
        to: DateTime(2024, 4, 3),
      ),
      "": OutHomeModel(
        id: '2',
        from: DateTime(2024, 4, 15),
        to: DateTime(2024, 4, 30),
      ),
    },
  ); */
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF4FD1C5),
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        actions: [
          IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
            icon: Icon(Icons.settings),
          ),
          SizedBox(width: 16),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'جدولي',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'My Schedule',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocConsumer<ScheduleCubit, ScheduleState>(
            listener: (context, state) {
              final schedule = BlocProvider.of<ScheduleCubit>(context).schedule;
              colorMap = generateColorMapForMonth(
                schedule,
                _focusedDay.year,
                _focusedDay.month,
              );
              // TODO: implement listener
            },
            builder: (context, state) {
              return TableCalendar(
                locale: 'en_US',
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                headerVisible: true,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  dowTextFormatter: (date, locale) {
                    const arabicDays = ['س', 'خ', 'ن', 'ث', 'ر', 'ح', 'ج'];
                    return arabicDays[date.weekday % 7];
                  },
                  weekdayStyle: TextStyle(color: Colors.black),
                  weekendStyle: TextStyle(color: Colors.black),
                ),
                calendarStyle: CalendarStyle(
                  defaultTextStyle: TextStyle(color: Colors.black),
                  weekendTextStyle: TextStyle(color: Colors.black),
                  todayDecoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  defaultDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  outsideDaysVisible: false,
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, _) {
                    if (colorMap.isEmpty) {
                      colorMap = generateColorMapForMonth(
                        BlocProvider.of<ScheduleCubit>(context).schedule,
                        _focusedDay.year,
                        _focusedDay.month,
                      );
                    }
                    final color = getColorForDay(day);
                    if (color != null) {
                      return Container(
                        margin: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${day.day}',
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }
                    return null;
                  },
                  todayBuilder: (context, day, _) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ),
                onPageChanged: (focusedDay) {
                  colorMap = {};
                  colorMap = generateColorMapForMonth(
                    BlocProvider.of<ScheduleCubit>(context).schedule,
                    focusedDay.year,
                    focusedDay.month,
                  );
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                },
              );
            },
          ),
          const SizedBox(height: 100),
          WifeList(),
        ],
      ),
    );
  }

  Color? getColorForDay(DateTime day) {
    return colorMap[DateTime(day.year, day.month, day.day)] ??
        Colors.transparent;
  }

  Map<DateTime, Color> generateColorMapForMonth(
    ScheduleModel schedule,
    int year,
    int month,
  ) {
    Map<DateTime, Color> colorMap = {};
    // 1. توليد كل الأيام في الشهر
    DateTime start = DateTime(year, month, 1);
    DateTime end = DateTime(year, month + 1, 0); // نهاية الشهر
    List<DateTime> allDays = [];
    DateTime current = start;
    while (!current.isAfter(end)) {
      allDays.add(current);
      current = current.add(Duration(days: 1));
    }
    // 2. حذف أيام outHome
    Set<DateTime> outHomeDates = {};

    schedule.outHomeDays.forEach((_, outHome) {
      DateTime current = outHome.from;
      while (!current.isAfter(outHome.to)) {
        outHomeDates.add(current);
        current = current.add(Duration(days: 1));
      }
    });
    // 3. توزيع الأيام على الزوجات حسب الدور

    List<DateTime> validDays = allDays
        .where((d) => !outHomeDates.contains(d))
        .toList();
    int index = 0;
    while (index < validDays.length) {
      for (var wife in schedule.wivesStay) {
        for (int i = 0; i < wife.days && index < validDays.length; i++) {
          colorMap[validDays[index]] = wife.color;
          index++;
        }
      }
    }
    // 4. تحديد لون أيام outHome
    for (var d in outHomeDates) {
      colorMap[d] = Colors.grey;
    }

    /// add out of home days
    return colorMap;
  }
}

class WifeList extends StatelessWidget {
  const WifeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: BlocConsumer<ScheduleCubit, ScheduleState>(
        listener: (context, state) {},
        builder: (context, state) {
          print('$state');
          final wifes = BlocProvider.of<ScheduleCubit>(
            context,
          ).schedule.wivesStay;
          return Column(
            children: [
              for (var wife in wifes)
                WifeLabel(color: wife.color, label: wife.name),

              WifeLabel(color: Color(0xFFD3D3D3), label: 'خارج المنزل'),
            ],
          );
        },
      ),
    );
  }
}

class WifeLabel extends StatelessWidget {
  const WifeLabel({super.key, required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(label, style: TextStyle(fontSize: 20)),
          ),
          Flexible(flex: 4, child: SizedBox(width: 100)),
          Container(
            width: 100,
            height: 40,

            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ],
      ),
    );
  }
}
