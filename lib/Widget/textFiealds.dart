// ignore_for_file: file_names, override_on_non_overriding_member, unused_import, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovebook/Constance/theme.dart';

import '../utils/themes/theme_manager.dart';

class MyTextFieald extends StatefulWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardtype;
  final bool hideTextfild;
  final VoidCallback? click;
  final Function(String?)? onChange;
  final bool? obscureText;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;

  const MyTextFieald(
      {super.key,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.keyboardtype = TextInputType.text,
      this.hideTextfild = false,
      this.onChange,
      this.click,
      this.obscureText = false,
      this.controller,
      this.inputFormatters});

  @override
  State<MyTextFieald> createState() => _MyTextFiealdState();
}

class _MyTextFiealdState extends State<MyTextFieald> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
            inputFormatters: widget.inputFormatters,
            controller: widget.controller,
            obscureText: _obscureText,
            onChanged: (v) {
              widget.onChange!(v);
            },
            onTap: widget.click,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 14,
                ),
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              focusedBorder: const UnderlineInputBorder(),
              suffixIcon: widget.suffixIcon != null ||
                      widget.obscureText == true
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : widget.suffixIcon,
              hintText: widget.hintText,
            )),
      ),
    );
  }
}

class CustomDropdown extends StatefulWidget {
  final String hintText;
  final List<String> dropdownItems;
  final Function(String)? onSelect;

  CustomDropdown({
    required this.hintText,
    required this.dropdownItems,
    this.onSelect,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool isDropdownOpened = false;
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDropdownOpened = !isDropdownOpened;
        });
      },
      child: Consumer(builder: (context, ref, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AbsorbPointer(
                        absorbing: true,
                        child: TextFormField(
                          readOnly: true,
                          controller:
                              TextEditingController(text: selectedValue),
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 14,
                                  ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            border: const UnderlineInputBorder(),
                            focusedBorder: const UnderlineInputBorder(),
                            hintText: widget.hintText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (isDropdownOpened)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: ref.watch(themeController).isLight
                          ? Colors.white
                          : null,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      children: widget.dropdownItems.map((item) {
                        return ListTile(
                          title: Text(item),
                          onTap: () {
                            setState(() {
                              selectedValue = item;
                              isDropdownOpened = false;
                            });
                            widget.onSelect?.call(item);
                          },
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
