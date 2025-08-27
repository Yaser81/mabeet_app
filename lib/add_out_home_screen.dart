import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mabeet_app/core/app_dialog.dart';
import 'package:mabeet_app/cubit/cubit/schedule_cubit.dart';
import 'package:mabeet_app/models/models.dart';
import 'package:mabeet_app/widgets/custom_text_from_field.dart';
import 'package:mabeet_app/widgets/cutom_elevated_button.dart';

class AddOutHomeScreen extends StatelessWidget {
  final DateTime startDate;
  final DateTime? endDate;
  const AddOutHomeScreen({super.key, required this.startDate, this.endDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تحديد أيام خارج المنزل'), centerTitle: true),
      body: OutHomeView(startDate: startDate, endDate: endDate),
    );
  }
}

class OutHomeView extends StatelessWidget {
  final DateTime startDate;
  final DateTime? endDate;
  OutHomeView({super.key, required this.startDate, this.endDate});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 100),
            Center(
              child: Icon(
                Icons.airplanemode_active,
                size: 50,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            CustomTextFormField(
              initialValue: DateFormat('dd/MM/yyyy').format(startDate),
              labelText: 'من تاريخ',
              keyboardType: TextInputType.datetime,
            ),
            CustomTextFormField(
              initialValue: endDate != null
                  ? DateFormat('dd/MM/yyyy').format(endDate!)
                  : '',
              labelText: 'إلى تاريخ',
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 50),
            CustomElevatedButton(
              onPressed: () {
                try {
                  AppDialogs.confirmAction(
                    context: context,
                    title: 'تأكيد العملية',
                    message: 'هل أنت متاكد من تحديد الايام كخارج المنزل',
                    confirmText: 'موافق',
                    cancelText: 'إلغاء',
                    confirmColor: Colors.green,

                    icon: Icons.confirmation_num,
                    onConfirm: () {
                      BlocProvider.of<ScheduleCubit>(context).addOuthome(
                        OutHomeModel(
                          id: DateFormat('dd/MM/yyyy').format(startDate),
                          from: startDate,
                          to: endDate == null ? startDate : endDate!,
                        ),
                      );
                      AppDialogs.showAutoSuccess(
                        context: context,
                        message: 'تمت عملية الإضافة بنجاح',
                        autoHideSeconds: 3,
                      );
                    },
                    onCancel: () {
                      // عملية الإلغاء
                      debugPrint('تم الإلغاء');
                    },
                  );
                } catch (e) {
                  AppDialogs.showError(
                    context: context,
                    title: 'خطاً',
                    message: e.toString(),
                  );
                }
              },
              child: Text('حفظ'),
            ),
          ],
        ),
      ),
    );
  }
}
