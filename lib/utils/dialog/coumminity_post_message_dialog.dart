import 'package:flutter/material.dart';

import '../../Widget/textFiealds.dart';

class PostCommentDialog extends StatelessWidget {
  final Function(String?)? onTap;
  PostCommentDialog({this.onTap});
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Post a Comment'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyTextFieald(
              controller: messageController,
              hintText: "Post a comment",
              onChange: (v) {}),
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
            'Post',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
