import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

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
  Color selectedColor = Colors.green; // Initial color
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(
                label: Text('اسم الزوجة'),
                hint: Text('ادخل اسم الزوجة'),
                border: OutlineInputBorder(),
                // Border color when focused
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              label: Text('عدد الأيام'),
              hint: Text('أدخل عدد الايام من 1 الى 7'),
              border: OutlineInputBorder(),
              // Border color when focused
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),

          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: Container(
                  height: 50,

                  decoration: BoxDecoration(
                    color: selectedColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(width: 3),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(5),
                    ),
                  ),
                  onPressed: () async {
                    final newColor = await showColorPickerDialog(
                      context,
                      selectedColor,
                    );
                    setState(() {
                      selectedColor = newColor;
                    });
                  },
                  child: Text('تحديد اللون'),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 400,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {},
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary, // ← لون الخلفية
                foregroundColor: colorScheme.onPrimary, // ← لون النص
              ),
              child: Text('إضافة'),
            ),
          ),
        ],
      ),
    );
  }
}
