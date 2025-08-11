
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showDeleteConfirmDialog(BuildContext context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.scale,
    title: 'تأكيد الحذف',
    desc: 'هل تريد حذف هذا العنصر نهائيًا؟',
    btnCancelText: 'إلغاء',
    btnOkText: 'حذف',
    btnCancelOnPress: () {},
    btnOkOnPress: () {
      // عملية الحذف
    },
    btnOkColor: Colors.red,
  ).show();
}
