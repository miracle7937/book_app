import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Widget/buttons.dart';
import '../../Widget/rating_stars.dart';
import '../../Widget/textFiealds.dart';
import '../themes/theme_manager.dart';

void showRatingBookModal(
    BuildContext context, Function(String, int)? onRating) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      content: Wrap(
        children: [
          MyModalContent(
            onRating: onRating,
          ),
        ],
      ),
    ),
  );
}

class MyModalContent extends StatefulWidget {
  final Function(String, int)? onRating;

  const MyModalContent({super.key, this.onRating});

  @override
  State<MyModalContent> createState() => _MyModalContentState();
}

class _MyModalContentState extends State<MyModalContent> {
  int myRating = 0;
  String comment = "";
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: Container(
            color: ref.watch(themeController).isLight
                ? Colors.white
                : Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Rate this book',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  MyTextFieald(
                      hintText: "Comment",
                      onChange: (v) {
                        comment = v.toString();
                      }),
                  SizedBox(height: 16),
                  RatingStar(
                    iconSize: 30,
                    onRatingChanged: (rating) {
                      myRating = rating;
                    },
                  ),
                  SizedBox(height: 16),
                  MyButton(
                    click: () {
                      widget.onRating == null
                          ? null
                          : widget.onRating!(comment, myRating);
                      Navigator.pop(context);
                    },
                    btnName: 'Submit',
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
