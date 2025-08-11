import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabeet_app/cubit/cubit/schedule_cubit.dart';
import 'package:mabeet_app/home_screen.dart';

import 'models/models.dart';

void main() {
  final ScheduleModel scheduleModel = ScheduleModel(
    wives: {
      'خلود': WifeModel(name: 'خلود', color: Color(0xFF4FD1C5), days: 4),
      /*'وردة': WifeModel(name: 'وردة', color: Color(0xFFF597AD), days: 5),
      'حنان': WifeModel(name: 'حنان', color: Color(0xFFB4A9FF), days: 1), */
    },
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
          iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(foregroundColor: colorScheme.primary),
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

/* import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mabeet_app/widgets/custom_text_from_field.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _fullName;
  late String _email;
  late String _password;
  late int _age;
  late String _aboutYou;
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  keyboardType: TextInputType.text,
                  labelText: 'الاسم الكامل',
                  hintText: 'أدخل اسمك الكامل',
                  perfixIcon: Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'هذا الحقل مطلوب';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _fullName = newValue!,
                ),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'البريد الإلكتروني مطلوب';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'البريد الالكتروني غير صالح';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'البريد الإلكتروني',

                  hintText: 'أدخل البريد الإلكتروني',
                  perfixIcon: Icon(
                    Icons.email,
                    color: Theme.of(context).primaryColor,
                  ),

                  onSaved: (newValue) {
                    _email = newValue!;
                  },
                ),
                CustomTextFormField(
                  labelText: 'كلمة المرور',

                  keyboardType: TextInputType.text,
                  obscureText: true,
                  perfixIcon: Icon(
                    Icons.password,
                    color: Theme.of(context).primaryColor,
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'كلمة المرور مطلوبة';
                    }
                    if (value.length < 6) {
                      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                    }
                  },
                  onSaved: (newValue) => _password = newValue!,
                ),
                CustomTextFormField(
                  labelText: 'العمر',

                  keyboardType: TextInputType.number,
                  perfixIcon: Icon(
                    Icons.elderly,
                    color: Theme.of(context).primaryColor,
                  ),
                  validator: (value) {
                    if (int.tryParse(value!) == null) {
                      return ' العمر يجب ان يكون رقم';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _age = int.parse(newValue!),
                ),

                CustomTextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  labelText: 'نبذة عنك ',
                  perfixIcon: Icon(
                    Icons.description,
                    color: Theme.of(context).primaryColor,
                  ),
                  onSaved: (newValue) => _aboutYou = newValue!,
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
                        if (!_formKey.currentState!.validate()) {
                          debugPrint('validation error');
                          return;
                        }
                        _formKey.currentState!.save();
                        showError('''
            تم الحفظ بنجاح
            الاسم: $_fullName
            البريد الإلكتروني: $_email
            كلمة المرور: $_password
            العمر: $_age
            نبذة عنك: $_aboutYou
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
                        _formKey.currentState!.reset();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
 */
