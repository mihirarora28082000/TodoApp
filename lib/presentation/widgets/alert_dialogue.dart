import 'package:flutter/material.dart';
import 'package:todoapp/data/scaling_query.dart';

Future<bool?> showMyDialog(BuildContext ctx, String dialogueTitle) async {
  return showDialog<bool>(
    context: ctx,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert !',
            style: TextStyle(
                fontSize: ScalingQuery(context).fontSize(2.5))),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                dialogueTitle,
                style: TextStyle(
                    fontSize: ScalingQuery(context).fontSize(2)),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('NO'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text('YES'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
