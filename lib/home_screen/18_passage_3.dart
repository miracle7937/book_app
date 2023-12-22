// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Constance/constance.dart';

class Passage3Screen extends StatefulWidget {
  const Passage3Screen({super.key});

  @override
  State<Passage3Screen> createState() => _Passage3ScreenState();
}

class _Passage3ScreenState extends State<Passage3Screen> {
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    ConstanceData.sv1,
                    height: 15,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    ConstanceData.c1,
                    height: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset(ConstanceData.c2),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Image.asset(ConstanceData.c3),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Image.asset(ConstanceData.c4),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Image.asset(ConstanceData.c5),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset(ConstanceData.c6),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Image.asset(ConstanceData.c7),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Image.asset(ConstanceData.c8),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Image.asset(ConstanceData.c9),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset(ConstanceData.c10),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Image.asset(ConstanceData.c11),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Image.asset(ConstanceData.c12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Image.asset(ConstanceData.c13),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
