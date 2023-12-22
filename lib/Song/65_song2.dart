// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import '../Constance/constance.dart';
import '../Constance/theme.dart';

class Song2Screen extends StatefulWidget {
  const Song2Screen({super.key});

  @override
  State<Song2Screen> createState() => _Song2ScreenState();
}

class _Song2ScreenState extends State<Song2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: MediaQuery.of(context).padding.top + 16,
            bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  ConstanceData.s1,
                  height: 20,
                ),
                Image.asset(
                  ConstanceData.m1,
                  height: 10,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Image.asset(
                    ConstanceData.v21,
                    height: 200,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Harry Potter and The\nHalf-Blood Prince",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 16,
                        ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "J. K. Rowling",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 14, color: HexColor("##4D7EFF")),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "11:50",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 12,
                            color: Theme.of(context).disabledColor),
                      ),
                      Text(
                        "-5:11:41",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 12,
                            color: Theme.of(context).disabledColor),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Image.asset(
                    ConstanceData.v22,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Chapter IX",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 12,
                            color: Theme.of(context).disabledColor),
                      ),
                      Text(
                        "Chapter XI in 44:44",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 12,
                            color: Theme.of(context).disabledColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ConstanceData.v23,
                        height: 30,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Image.asset(
                        ConstanceData.v24,
                        height: 120,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Image.asset(
                        ConstanceData.v25,
                        height: 30,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ConstanceData.v26,
                        height: 50,
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Image.asset(
                        ConstanceData.v27,
                        height: 50,
                      ),
                      SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
