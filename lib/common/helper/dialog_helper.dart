import 'package:flutter/cupertino.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class DialogHelper {
  static StylishDialog loading(BuildContext context,
      {String title = "", String content = ""}) {
    StylishDialog dialog = StylishDialog(
      context: context,
      dismissOnTouchOutside: false,
      alertType: StylishDialogType.PROGRESS,
      titleText: title,
      contentText: content,
      animationLoop: true,
    );
    return dialog;
  }

  static StylishDialog sukses(BuildContext context,
      {String title = "", String content = "", Widget? widget}) {
    StylishDialog dialog = StylishDialog(
        dismissOnTouchOutside: false,
        context: context,
        alertType: StylishDialogType.SUCCESS,
        titleText: title,
        contentText: content,
        confirmButton: widget);
    return dialog;
  }

  static StylishDialog error(BuildContext context,
      {String title = "", String content = "", Widget? widget}) {
    StylishDialog dialog = StylishDialog(
        context: context,
        alertType: StylishDialogType.ERROR,
        titleText: title,
        contentText: content,
        confirmButton: widget);
    return dialog;
  }

  static StylishDialog warning(BuildContext context,
      {String title = "", String content = "", Widget? widget}) {
    StylishDialog dialog = StylishDialog(
        context: context,
        alertType: StylishDialogType.WARNING,
        titleText: title,
        contentText: content,
        confirmButton: widget);
    return dialog;
  }
}
