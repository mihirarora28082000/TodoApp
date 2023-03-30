import 'package:flutter/material.dart';


Future<bool?> showMyDialog(BuildContext ctx) async {

  return showDialog<bool>(
   context: ctx,
   barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Alert !'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Are you sure you want to delete this task ?'),
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
