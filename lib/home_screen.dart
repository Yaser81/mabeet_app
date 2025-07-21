import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatelessWidget {
  final DateTime focusedDay = DateTime(2024, 4, 1);

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back_ios, color: Colors.black),
        actions: [
          Icon(Icons.settings, color: Colors.black),
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
                final color = getColorForDay(day);
                if (color != null) {
                  return Container(
                    margin: EdgeInsets.all(4),
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
                  margin: EdgeInsets.all(4),
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
                buildLegendItem(color: Color(0xFF4FD1C5), label: 'خلود'),
                buildLegendItem(color: Color(0xFFF597AD), label: 'وردة'),
                buildLegendItem(color: Color(0xFFB4A9FF), label: 'حنان'),
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
          Container(width: 20, height: 20, color: color),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  /// تحديد لون اليوم حسب جدول المستخدمين
  Color? getColorForDay(DateTime day) {
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

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
