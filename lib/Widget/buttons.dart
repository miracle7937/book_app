// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../Constance/theme.dart';

class MyButton extends StatelessWidget {
  final String btnName;
  final VoidCallback? click;
  final bool isLoading;

  const MyButton({
    Key? key,
    required this.btnName,
    this.click,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : click,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isLoading
              ? Colors.grey
              : AppTheme.isLightTheme
                  ? Theme.of(context).primaryColor
                  : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text(
                  btnName,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isLoading ? Colors.transparent : Colors.white,
                      ),
                ),
        ),
      ),
    );
  }
}
