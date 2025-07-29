import 'package:flutter/material.dart';
import 'package:mabeet_app/models/out_home_model.dart';
import 'package:mabeet_app/models/schedule_model.dart';
import 'package:mabeet_app/setting_screen.dart';
import 'package:table_calendar/table_calendar.dart';

import 'models/wife_stay_model.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  final DateTime focusedDay = DateTime(2024, 4, 1);
  final schedule = ScheduleModel(
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
  );
  var colorMap = {};
  HomeScreen({super.key}) {
    colorMap = generateColorMapForMonth(
      schedule,
      focusedDay.year,
      focusedDay.month,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back_ios, color: Colors.black),
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
          TableCalendar(
            locale: 'en_US',
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: focusedDay,
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
                    schedule,
                    focusedDay.year,
                    focusedDay.month,
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
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                for (var wifeStay in schedule.wivesStay)
                  buildLegendItem(color: wifeStay.color, label: wifeStay.name),

                buildLegendItem(color: Color(0xFFD3D3D3), label: 'خارج المنزل'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLegendItem({required Color color, required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,

            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          Flexible(flex: 4, child: SizedBox(width: 25)),
          Text(label, style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }

  Color? getColorForDay(DateTime day) {
    return colorMap[DateTime(day.year, day.month, day.day)] ??
        Colors.transparent;
  }

  /// تحديد لون اليوم حسب جدول المستخدمين
  /*  Color? getColorForDay(DateTime day) {
    final khuloodDays = [DateTime(2024, 4, 3), DateTime(2024, 4, 5)];
    final wardahDays = [DateTime(2024, 4, 6), DateTime(2024, 4, 7)];
    final hananDays = [
      DateTime(2024, 4, 10),
      DateTime(2024, 4, 11),
      DateTime(2024, 4, 12),
      DateTime(2024, 4, 13),
      DateTime(2024, 4, 14),
      DateTime(2024, 4, 17),
      DateTime(2024, 4, 18),
      DateTime(2024, 4, 21),
      DateTime(2024, 4, 22),
      DateTime(2024, 4, 23),
      DateTime(2024, 4, 24),
      DateTime(2024, 4, 25),
      DateTime(2024, 4, 26),
      DateTime(2024, 4, 27),
      DateTime(2024, 4, 28),
    ];
    final outsideDay = DateTime(2024, 4, 30);

    if (khuloodDays.any((d) => isSameDay(d, day))) {
      return Color(0xFF4FD1C5); // سماوي
    } else if (wardahDays.any((d) => isSameDay(d, day))) {
      return Color(0xFFF597AD); // وردي
    } else if (hananDays.any((d) => isSameDay(d, day))) {
      return Color(0xFFB4A9FF); // بنفسجي
    } else if (isSameDay(outsideDay, day)) {
      return Color(0xFFD3D3D3); // رمادي
    }
    return null;
  }
 */
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

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
