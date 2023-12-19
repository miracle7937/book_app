// ignore_for_file: file_names, override_on_non_overriding_member, unused_import, deprecated_member_use, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:lovebook/Constance/theme.dart';

class MyTextFieald2 extends StatefulWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardtype;
  final bool hideTextfild;
  final VoidCallback? click;
  final Function(String)? onChange;

  const MyTextFieald2({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardtype = TextInputType.text,
    this.hideTextfild = false,
    this.click,
    this.onChange,
  });

  @override
  State<MyTextFieald2> createState() => _MyTextFieald2State();
}

class _MyTextFieald2State extends State<MyTextFieald2> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppTheme.isLightTheme
                  ? const Color.fromARGB(255, 231, 231, 231)
                  : Colors.grey,
              blurRadius: 6.0,
              spreadRadius: 2.0,
              offset: const Offset(0.0, 0.0),
            )
          ],
          color: Theme.of(context).cardColor,
        ),
        // color:
        //     AppTheme.isLightTheme ? HexColor("#FAFAFA") : HexColor("#1F222A"),
        child: TextFormField(
          onChanged: widget.onChange,
          onTap: widget.click,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 14,
              ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 16, top: 16),
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            disabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).dividerColor, width: 1.5),
              borderRadius: BorderRadius.circular(15), //<-- SEE HERE
            ),
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).dividerColor, width: 1.5),
              borderRadius: BorderRadius.circular(15), //<-- SEE HERE
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).dividerColor, width: 1.5),
              borderRadius: BorderRadius.circular(15), //<-- SEE HERE
            ),
          ),
        ),
      ),
    );
  }
}
