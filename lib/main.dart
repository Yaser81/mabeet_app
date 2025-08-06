import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabeet_app/cubit/cubit/schedule_cubit.dart';
import 'package:mabeet_app/home_screen.dart';

import 'models/models.dart';

void main() {
  final ScheduleModel scheduleModel = ScheduleModel(
    wivesStay: [
      WifeStayModel(id: 1, name: 'خلود', color: Color(0xFF4FD1C5), days: 4),
      WifeStayModel(id: 2, name: 'وردة', color: Color(0xFFF597AD), days: 5),
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
  runApp(MyApp(scheduleModel: scheduleModel));
}

class MyApp extends StatelessWidget {
  final ScheduleModel scheduleModel;
  const MyApp({super.key, required this.scheduleModel});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ScheduleCubit(scheduleModel)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('ar'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'), // English
          Locale('ar'), // Spanish
        ],
        title: 'تطبيق مبيت',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          // تعيين الخط الافتراضي للتطبيق كله
          textTheme: GoogleFonts.notoNaskhArabicTextTheme(
            Theme.of(context).textTheme,
          ),

          // يمكنك أيضاً تعيين عناصر واجهة المستخدم بشكل منفصل
          primaryTextTheme: GoogleFonts.notoNaskhArabicTextTheme(
            Theme.of(context).primaryTextTheme,
          ),

          // تعيين الخط لعناصر واجهة المستخدم الثانوية
        ),
        home: HomeScreen(),
      ),
    );
  }
}
