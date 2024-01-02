import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialog(BuildContext context,
    {String? title,
    String? subTitle,
    VoidCallback? onTap,
    String? btnTitle}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(title ?? ""),
        content: Text(subTitle ?? ""),
        actions: <Widget>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              onTap != null ? onTap() : null;
              Navigator.of(context).pop();
            },
            child: Text(btnTitle ?? 'Delete'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
            ),
          ),
        ],
      );
    },
  );
}
