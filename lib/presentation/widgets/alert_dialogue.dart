import 'package:flutter/material.dart';

import 'package:todoapp/presentation/utils/scaling_query.dart';
import 'package:todoapp/presentation/constants/label_names.dart';

Future<bool?> showMyDialog(BuildContext ctx, String dialogueTitle) async {
  return showDialog<bool>(
      context: ctx,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(ALERT_TITLE,
                style:
                    TextStyle(fontSize: ScalingQuery(context).fontSize(2.5))),
            content: SingleChildScrollView(
                child: ListBody(children: <Widget>[
              Text(dialogueTitle,
                  style: TextStyle(fontSize: ScalingQuery(context).fontSize(2)))
            ])),
            actions: <Widget>[
              TextButton(
                  child: Text(ALERT_NO_BUTTON,
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  }),
              TextButton(
                  child: Text(
                    ALERT_YES_BUTTON,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  })
            ]);
      });
}
