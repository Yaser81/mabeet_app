import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AppDialogs {
  /// Dialog لتأكيد عملية (مثل الحذف) باستخدام AwesomeDialog
  static void confirmAction({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'تأكيد',
    String cancelText = 'إلغاء',
    Color? confirmColor,
    DialogType dialogType = DialogType.warning,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.scale,
      title: title,
      desc: message,
      btnCancelText: cancelText,
      btnOkText: confirmText,
      btnCancelOnPress: () {
        if (onCancel != null) onCancel();
      },
      btnOkOnPress: () {
        if (onConfirm != null) onConfirm();
      },
      btnOkColor: confirmColor ?? Theme.of(context).colorScheme.error,
    ).show();
  }
}
