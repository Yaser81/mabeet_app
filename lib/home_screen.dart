import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabeet_app/add_out_home_screen.dart';
import 'package:mabeet_app/add_wife_screen.dart';
import 'package:mabeet_app/core/app_dialog.dart';
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
  DateTime? _rangStart;
  DateTime? _rangeEnd;
  DateTime? _selectedDay;
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 0,

        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
            icon: Icon(Icons.settings),
          ),
          SizedBox(width: 16),
        ],
        title: ScheduleHeaderView(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 16,

              left: 16,
              child: FloatingActionButton(
                heroTag: 'add-wife',
                onPressed: () {
                  debugPrint(
                    BlocProvider.of<ScheduleCubit>(
                      context,
                    ).schedule.wives.length.toString(),
                  );
                  if (BlocProvider.of<ScheduleCubit>(
                        context,
                      ).schedule.wives.length <
                      4) {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddWifeScreen()),
                    );
                  } else {
                    AppDialogs.showError(
                      onOk: () {},
                      context: context,
                      title: 'خطا',
                      message: ' لايمكن إضافة اكثر من 4 زوجات',
                    );
                  }
                },
                child: Icon(Icons.add),
              ),
            ),
            Positioned(
              bottom: 80,
              left: 16,
              child: FloatingActionButton(
                heroTag: 'add-out-home',
                onPressed: () {
                  if (_rangStart != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddOutHomeScreen(
                          startDate: _rangStart!,
                          endDate: _rangeEnd,
                        ),
                      ),
                    );
                  }
                },
                child: Icon(Icons.airplanemode_active),
              ),
            ),

            Column(
              children: [
                BlocConsumer<ScheduleCubit, ScheduleState>(
                  listener: (context, state) {
                    final schedule = BlocProvider.of<ScheduleCubit>(
                      context,
                    ).schedule;
                    colorMap = generateColorMapForMonth(
                      schedule,
                      _focusedDay.year,
                      _focusedDay.month,
                    );
                  },
                  builder: (context, state) {
                    return TableCalendar(
                      locale: 'en_US',
                      firstDay: DateTime(2020, 1, 1),
                      lastDay: DateTime(2030, 12, 31),
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
                          const arabicDays = [
                            'س',
                            'خ',
                            'ن',
                            'ث',
                            'ر',
                            'ح',
                            'ج',
                          ];
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
                          final color = getColorForDay(day.toLocal());
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
                      rangeStartDay: _rangStart,
                      rangeEndDay: _rangeEnd,
                      rangeSelectionMode: RangeSelectionMode.toggledOn,
                      selectedDayPredicate: (day) =>
                          isSameDay(day.toLocal(), _selectedDay ?? _focusedDay),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _focusedDay = focusedDay;
                          _selectedDay = selectedDay;
                        });
                      },
                      onRangeSelected: (start, end, focusedDay) {
                        setState(() {
                          _selectedDay = start;
                          _focusedDay = focusedDay;
                          _rangStart = start?.toLocal();
                          _rangeEnd = end?.toLocal();
                        });
                      },
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
          ],
        ),
      ),
    );
  }

  bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
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
        .where((d) => !outHomeDates.any((o) => isSameDay(d, o)))
        .toList();
    int index = 0;
    if (schedule.wives.isNotEmpty) {
      while (index < validDays.length) {
        for (var wife in schedule.wives.entries) {
          for (
            int i = 0;
            i < wife.value.days && index < validDays.length;
            i++
          ) {
            colorMap[validDays[index]] = wife.value.color;
            index++;
          }
        }
      }
    }
    _rangStart = null;
    _rangeEnd = null;
    _selectedDay = null;
    // 4. تحديد لون أيام outHome
    for (var d in outHomeDates) {
      colorMap[d] = Colors.grey;
    }

    /// add out of home days
    return colorMap;
  }
}

class ScheduleHeaderView extends StatelessWidget {
  const ScheduleHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'جدولي',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'My Schedule',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
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
          debugPrint('$state');
          final wifes = BlocProvider.of<ScheduleCubit>(context).schedule.wives;
          return Column(
            children: [
              for (var wife in wifes.values)
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
