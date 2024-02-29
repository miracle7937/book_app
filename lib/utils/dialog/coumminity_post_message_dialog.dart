import 'package:flutter/material.dart';

import '../../Widget/textFiealds.dart';

class CommentDialog extends StatelessWidget {
  final String title, btnTitle;

  final Function(String?)? onTap;
  CommentDialog({this.onTap, required this.title, required this.btnTitle});
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyTextFieald(
              controller: messageController, hintText: title, onChange: (v) {}),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onTap != null ? onTap!(messageController.text) : null;
          },
          child: Text(
            btnTitle,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
