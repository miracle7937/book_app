// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lovebook/Constance/constance.dart';
import 'package:lovebook/home_screen/17_passage_2.dart';

class PassageScreen extends StatefulWidget {
  const PassageScreen({super.key});

  @override
  State<PassageScreen> createState() => _PassageScreenState();
}

class _PassageScreenState extends State<PassageScreen> {
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
                        builder: (_) => Passage2Screen(),
                      ),
                    );
                  },
                  child: Image.asset(
                    ConstanceData.m5,
                    height: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 70,
            ),
            Image.asset(
              ConstanceData.m6,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "1",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                      ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "/  12",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 16, color: Theme.of(context).dividerColor),
                ),
              ],
            ),
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
