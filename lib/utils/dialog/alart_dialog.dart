import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialog(BuildContext context,
    {String? title, String? subTitle, VoidCallback? onTap}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('Delete Account?'),
        content: Text(
            'Are you sure you want to delete your account? This action cannot be undone.'),
        actions: <Widget>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              onTap != null ? onTap() : null;
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}
