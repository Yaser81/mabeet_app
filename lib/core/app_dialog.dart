import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AppDialogs {
  /// تأكيد عملية (مثل الحذف)
  static void confirmAction({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'تأكيد',
    String cancelText = 'إلغاء',
    Color? confirmColor,
    DialogType dialogType = DialogType.warning,
    IconData? icon,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.scale,
      customHeader: icon != null
          ? Icon(icon, size: 50, color: confirmColor ?? Colors.orange)
          : null,
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

  /// رسالة نجاح
  static void showSuccess({
    required BuildContext context,
    required String title,
    required String message,
    IconData? icon,
    VoidCallback? onOk,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      customHeader: icon != null
          ? Icon(icon, size: 50, color: Colors.green)
          : null,
      title: title,
      desc: message,
      btnOkOnPress: onOk,
      btnOkColor: Colors.green,
    ).show();
  }

  /// رسالة خطأ
  static void showError({
    required BuildContext context,
    required String title,
    required String message,
    IconData? icon = Icons.error,
    VoidCallback? onOk,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      customHeader: icon != null
          ? Icon(icon, size: 50, color: Colors.red)
          : null,
      title: title,
      desc: message,
      btnOkOnPress: onOk,
      btnOkColor: Colors.red,
    ).show();
  }

  /// رسالة معلومات
  static void showInfo({
    required BuildContext context,
    required String title,
    required String message,
    IconData? icon,
    VoidCallback? onOk,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      customHeader: icon != null
          ? Icon(icon, size: 50, color: Theme.of(context).colorScheme.primary)
          : null,
      title: title,
      desc: message,
      btnOkOnPress: onOk,
      btnOkColor: Theme.of(context).colorScheme.primary,
    ).show();
  }

  /// رسالة نجاح تغلق تلقائياً أو بالضغط على OK
  static void showAutoSuccess({
    required BuildContext context,
    required String message,
    int autoHideSeconds = 2,
    IconData icon = Icons.check_circle,
    Color color = Colors.green,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      customHeader: Icon(icon, size: 50, color: color),
      title: 'نجاح',
      desc: message,
      autoHide: Duration(seconds: autoHideSeconds),
      btnOkOnPress: () {}, // يقدر المستخدم يضغط OK إذا أراد
      btnOkColor: color,
    ).show();
  }
}
