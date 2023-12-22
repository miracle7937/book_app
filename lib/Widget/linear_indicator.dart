import 'package:flutter/material.dart';
import '../utils/color.dart';

class BookLinearProgressBar extends StatelessWidget {
  final bool? isloading;
  const BookLinearProgressBar({Key? key, this.isloading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isloading == true) {
      return LinearProgressIndicator(
        minHeight: 5,
        color: AppColor.mainColor,
        backgroundColor: Colors.white,
      );
    } else {
      return Container();
    }
  }
}
