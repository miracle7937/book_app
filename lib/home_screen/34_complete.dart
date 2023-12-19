// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lovebook/Constance/constance.dart';
import 'package:lovebook/Widget/buttons.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({super.key});

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: 18,
            right: 18,
            top: MediaQuery.of(context).padding.top + 16,
            bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ConstanceData.m50),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Your order #47416 \nis issued!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 20,
                        ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ConstanceData.d1,
                        height: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Image.asset(
                        ConstanceData.d1,
                        height: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Image.asset(
                        ConstanceData.d1,
                        height: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Image.asset(
                        ConstanceData.d1,
                        height: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Image.asset(
                        ConstanceData.d2,
                        height: 30,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "How do you assess the work \nof our application?",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 14, color: Theme.of(context).disabledColor),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  MyButton(
                      btnName: "Complete",
                      click: () {
                        Navigator.pop(context);
                      }),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Go to order history",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 14, color: Theme.of(context).disabledColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
