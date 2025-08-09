/* import 'package:flutter/material.dart';
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
  MyApp({super.key, required this.scheduleModel});

  final colorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 91, 210, 198),
  );
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
          useMaterial3: true, // <== ضروري لتفعيل الألوان الجديدة
          colorScheme: colorScheme,
          appBarTheme: AppBarTheme(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
          ),
          // primaryColor: Color.fromARGB(255, 2, 22, 151),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
            ),
          ),
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
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: const AddNewUserScreen(title: 'تسجيل مستخدم جديد'),
    );
  }
}

class AddNewUserScreen extends StatefulWidget {
  final String title;

  const AddNewUserScreen({super.key, required this.title});

  @override
  State<AddNewUserScreen> createState() => _AddNewUserScreenState();
}

class _AddNewUserScreenState extends State<AddNewUserScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _aboutYouController = TextEditingController();
  String? _errorfullName;
  String? _errorEmail;
  String? _errorPassword;
  String? _errorAge;
  Timer? _debounceTimer;
  void _onEmailChanged(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      // يتم التحقق فقط بعد 500ms من توقف الكتابة
      final email = value.trim();

      if (email.isEmpty) {
        setState(() {
          _errorEmail = 'البريد الإلكتروني مطلوب';
        });
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        setState(() {
          _errorEmail = 'البريد الإلكتروني غير صالح';
        });
      } else {
        setState(() {
          _errorEmail = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: _fullNameController,
                keyboardType: TextInputType.text,
                labelText: 'الاسم الكامل',
                errorText: _errorfullName,
                hintText: 'أدخل اسمك الكامل',
                perfixIcon: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
                onChanged: (_) => clearError('_errorfullName'),
              ),
              CustomTextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                labelText: 'البريد الإلكتروني',
                errorText: _errorEmail,
                hintText: 'أدخل البريد الإلكتروني',
                perfixIcon: Icon(
                  Icons.email,
                  color: Theme.of(context).primaryColor,
                ),
                onChanged: _onEmailChanged,
              ),
              CustomTextField(
                controller: _passwordController,
                labelText: 'كلمة المرور',
                errorText: _errorPassword,
                keyboardType: TextInputType.text,
                obscureText: true,
                perfixIcon: Icon(
                  Icons.password,
                  color: Theme.of(context).primaryColor,
                ),
                onChanged: (_) => clearError('_errorPassword'),
              ),
              CustomTextField(
                controller: _ageController,
                labelText: 'العمر',
                errorText: _errorAge,
                keyboardType: TextInputType.number,
                perfixIcon: Icon(
                  Icons.elderly,
                  color: Theme.of(context).primaryColor,
                ),
                onChanged: (_) => clearError('_errorAge'),
              ),

              CustomTextField(
                controller: _aboutYouController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                labelText: 'نبذة عنك ',
                perfixIcon: Icon(
                  Icons.description,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('حفظ', style: TextStyle(fontSize: 18)),
                    onPressed: () {
                      setState(() {
                        _errorfullName = null;
                        _errorEmail = null;
                        _errorPassword = null;
                        _errorAge = null;
                      });
                      /*   */
                      final String fullName = _fullNameController.text.trim();
                      final String email = _emailController.text.trim();
                      final String pasword = _passwordController.text.trim();
                      final int age = int.tryParse(_ageController.text) ?? 0;
                      if (fullName.isEmpty) {
                        setState(() {
                          _errorfullName = 'الاسم مطلوب';
                        });

                        ///  showError(' الاسم مطلوب');
                        return;
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                        setState(() {
                          _errorEmail = ' البريد الالكتروني غير صالح ';
                        });

                        ///  showError(' البريد الالكتروني غير صالح ');
                        return;
                      }
                      if (pasword.length < 6) {
                        setState(() {
                          _errorPassword =
                              ' كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                        });

                        ///  showError(' كلمة المرور يجب أن تكون 6 أحرف على الأقل');
                        return;
                      }
                      if (age == 0) {
                        setState(() {
                          _errorAge = ' العمر يجب أن يكون رقم';
                        });

                        ///  showError(' العمر يجب أن يكون رقم');

                        return;
                      }

                      showError('''
تم الحفظ بنجاح
الاسم: ${_fullNameController.text}
البريد الإلكتروني: ${_emailController.text}
كلمة المرور: ${_passwordController.text}
العمر: ${_ageController.text}
نبذة عنك: ${_aboutYouController.text}
 ''');
                    },
                  ),
                  SizedBox(width: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('إلغاء', style: TextStyle(fontSize: 18)),
                    onPressed: () {
                      _fullNameController.clear();
                      _emailController.clear();
                      _passwordController.clear();
                      _ageController.clear();
                      _aboutYouController.clear();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clearError(String field) {
    setState(() {
      if (field == '_errorfullName') _errorfullName = null;
      if (field == '_errorEmail') _errorEmail = null;
      if (field == '_errorPassword') _errorPassword = null;
      if (field == '_errorAge') _errorAge = null;
    });
  }

  void showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    _aboutYouController.dispose();
    super.dispose();
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final String? errorText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int maxLines;
  final Widget? perfixIcon;
  final ValueChanged<String>? onChanged;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.errorText,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.perfixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: perfixIcon,
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
          border: OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
