// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Constance/constance.dart';
import '../home_screen/18_passage_3.dart';

class Passage2Screen extends StatefulWidget {
  const Passage2Screen({super.key});

  @override
  State<Passage2Screen> createState() => _Passage2ScreenState();
}

class _Passage2ScreenState extends State<Passage2Screen> {
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Passage3Screen(),
                      ),
                    );
                  },
                  child: Image.asset(
                    ConstanceData.m8,
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
                        child: Image.asset(ConstanceData.m7),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Image.asset(ConstanceData.m9),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset(ConstanceData.m10),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Image.asset(ConstanceData.m11),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset(ConstanceData.m12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Image.asset(ConstanceData.m13),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset(ConstanceData.m14),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Image.asset(ConstanceData.m15),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset(ConstanceData.m16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Image.asset(ConstanceData.m17),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset(ConstanceData.m18),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Image.asset(ConstanceData.m19),
                      ),
                    ],
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
