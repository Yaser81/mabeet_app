import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabeet_app/cubit/cubit/schedule_cubit.dart';
import 'package:mabeet_app/models/wife_model.dart';
import 'package:mabeet_app/widgets/custom_text_from_field.dart';

class AddWifeScreen extends StatefulWidget {
  const AddWifeScreen({super.key});

  @override
  State<AddWifeScreen> createState() => _AddWifeScreenState();
}

class _AddWifeScreenState extends State<AddWifeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة زوجة'),
        backgroundColor: Theme.of(
          context,
        ).colorScheme.primary, // ← اللون الأساسي
        foregroundColor: Theme.of(context).colorScheme.onPrimary, // ← لون النص
        centerTitle: true,
      ),
      body: AddWifeView(),
    );
  }
}

class AddWifeView extends StatefulWidget {
  const AddWifeView({super.key});

  @override
  State<AddWifeView> createState() => _AddWifeViewState();
}

class _AddWifeViewState extends State<AddWifeView> {
  Color _selectedColor = Colors.green; // Initial color
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _wifeName;
  late int _days;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                labelText: 'اسم الزوجة',
                hintText: 'أدخل اسم الزوجة',
                perfixIcon: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'اسم الزوجة مطلوب';
                  }
                  return null;
                },
                onSaved: (newValue) => _wifeName = newValue!,
              ),
              CustomTextFormField(
                labelText: 'عدد الأيام',
                hintText: 'أدخل عدد الأيام من 1 إلى 7',
                perfixIcon: Icon(
                  Icons.elderly,
                  color: Theme.of(context).primaryColor,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'عدد الايام مطلوب';
                  }
                  int? tryDays = int.tryParse(value);
                  if (tryDays == null || tryDays > 7 || tryDays < 1) {
                    return 'عدد الأيام يجب أن يكون بين 1 و 7';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _days = int.tryParse(newValue!)!;
                },
              ),

              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedColor,
                    foregroundColor: _selectedColor.computeLuminance() < 0.5
                        ? Colors.white
                        : Colors.black,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(5),
                    ),
                  ),
                  onPressed: () async {
                    final newColor = await showColorPickerDialog(
                      context,
                      _selectedColor,
                    );
                    setState(() {
                      _selectedColor = newColor;
                    });
                  },
                  child: Text('اضغط هنا لاختيار لون الزوجة'),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 400,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      WifeModel newWife = WifeModel(
                        name: _wifeName,
                        color: _selectedColor,
                        days: _days,
                      );
                      try {
                        BlocProvider.of<ScheduleCubit>(
                          context,
                        ).addWife(newWife: newWife);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('تمت عملية الاضافة بنجاح')),
                        );
                        _formKey.currentState!.reset();
                      } catch (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary, // ← لون الخلفية
                    foregroundColor: colorScheme.onPrimary, // ← لون النص
                  ),
                  child: Text('حفظ'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
