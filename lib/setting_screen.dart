import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabeet_app/cubit/cubit/schedule_cubit.dart';

import 'add_wife_screen.dart';
import 'core/app_dialog.dart';
import 'widgets/cutom_elevated_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool usePin = false;

  final Map<String, TextEditingController> controllers = {};
  String? _selectedWife = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var wifes = BlocProvider.of<ScheduleCubit>(context).schedule.wives;
    if (controllers.isEmpty && wifes.isNotEmpty) {
      for (var wife in wifes.values) {
        debugPrint('${wife.days}');
        controllers[wife.name] = TextEditingController(text: '${wife.days}');
      }
    }

    return Scaffold(
      appBar: AppBar(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (BlocProvider.of<ScheduleCubit>(context).schedule.wives.length <=
              4) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => AddWifeScreen()));
          } else {
            AppDialogs.showError(
              context: context,
              title: 'خطا',
              message: ' لايمكن إضافة اكثر من 4 زوجات',
            );
          }
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
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
                child: GestureDetector(
                  onLongPress: () {
                    setState(() {
                      _selectedWife = _selectedWife == entry.key
                          ? ''
                          : entry.key;
                    });
                  },

                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: _selectedWife == entry.key
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.green[50],
                          )
                        : BoxDecoration(),
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
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          onPressed: _selectedWife != entry.key
                              ? null
                              : () {
                                  AppDialogs.confirmAction(
                                    context: context,
                                    title: 'تأكيد الحذف',
                                    message:
                                        'هل تريد حذف معلومات الزوجة نهائياً؟',
                                    confirmText: 'حذف',
                                    cancelText: 'إلغاء',
                                    confirmColor: Colors.green,

                                    icon: Icons.delete_forever,
                                    onConfirm: () {
                                      // تنفيذ عملية الحذف
                                      BlocProvider.of<ScheduleCubit>(
                                        context,
                                      ).deleteWife(wifeName: entry.key);
                                      setState(() {
                                        controllers.remove(entry.key);
                                      });
                                      print('تم الحذف');
                                    },
                                    onCancel: () {
                                      // عملية الإلغاء
                                      print('تم الإلغاء');
                                    },
                                  );
                                },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
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
                const SizedBox(width: 5),
                const Text(
                  'القفل باستخدام رمز الدخول',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 50),
            Center(
              child: CustomElevatedButton(
                child: const Text('حفظ', style: TextStyle(fontSize: 16)),
                onPressed: () {
                  Map<String, int> wifesUpdatedData = {};
                  for (var key in controllers.keys) {
                    wifesUpdatedData[key] = int.parse(controllers[key]!.text);
                  }
                  BlocProvider.of<ScheduleCubit>(
                    context,
                  ).updateWives(wifesUpdatedData);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
