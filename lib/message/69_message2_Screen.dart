// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import '../Constance/constance.dart';
import '../message/70_message3Screen.dart';

class Message2Screen extends StatefulWidget {
  const Message2Screen({super.key});

  @override
  State<Message2Screen> createState() => _Message2ScreenState();
}

class _Message2ScreenState extends State<Message2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: MediaQuery.of(context).padding.top + 16,
                bottom: MediaQuery.of(context).padding.bottom),
            child: Row(
              children: [
                Text(
                  "Bookshelf",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Message3Screen(),
                      ),
                    );
                  },
                  child: Image.asset(
                    ConstanceData.v32,
                    height: 20,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Image.asset(
                  ConstanceData.v33,
                  height: 20,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 450,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 14, right: 14),
              children: [
                Row(
                  children: [
                    Image.asset(ConstanceData.v47),
                    SizedBox(
                      width: 20,
                    ),
                    Image.asset(ConstanceData.v48),
                    SizedBox(
                      width: 20,
                    ),
                    Image.asset(ConstanceData.v49),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "The Divine Comedy",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 18,
                    ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Dante Alighieri",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 12, color: Theme.of(context).disabledColor),
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                ConstanceData.v43,
                // width: MediaQuery.of(context).size.width,
              )
            ],
          ),
        ],
      ),
    );
  }
}
