import 'package:contatos_app/shared/custom_text.dart';
import 'package:flutter/material.dart';

class ShowAlertDialog {
  static buildDialog(BuildContext context, String title, Function clickOk,
      {Widget? content}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shadowColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: CustomText.buildTitle(title),
            content: content,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: CustomText.buildCancelTitle("Cancelar")),
              TextButton(
                  onPressed: () {
                    clickOk();
                  },
                  child: CustomText.buildOkTitle("Ok"))
            ],
          );
        });
  }

  static buildDialogOk(BuildContext context, String title) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shadowColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: CustomText.buildTitle(title),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: CustomText.buildOkTitle("Ok"))
            ],
          );
        });
  }
}
