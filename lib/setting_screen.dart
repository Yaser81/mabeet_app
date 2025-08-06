import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabeet_app/cubit/cubit/schedule_cubit.dart';
import 'package:mabeet_app/models/models.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool usePin = false;

  final Map<String, TextEditingController> controllers = {};
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var wifes = BlocProvider.of<ScheduleCubit>(context).schedule.wivesStay;
    if (controllers.isEmpty) {
      for (var wife in wifes) {
        print('${wife.days}');
        controllers[wife.name] = TextEditingController(text: '${wife.days}');
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('الإعدادات', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: const Color(0xFFF9F9F9),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'مدة البقاء لكل زوجة في كل مرة:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            ...controllers.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        entry.key,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: TextField(
                        controller: entry.value,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const Divider(height: 40),
            Row(
              children: [
                Switch(
                  value: usePin,
                  onChanged: (val) {
                    setState(() => usePin = val);
                  },
                ),
                const SizedBox(width: 10),
                const Text(
                  'القفل باستخدام رمز الدخول',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
