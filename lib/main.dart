import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabeet_app/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('en'),
      supportedLocales: const [Locale('en')],
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
    );
  }
}
