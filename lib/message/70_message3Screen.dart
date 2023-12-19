// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lovebook/Constance/constance.dart';

class Message3Screen extends StatefulWidget {
  const Message3Screen({super.key});

  @override
  State<Message3Screen> createState() => _Message3ScreenState();
}

class _Message3ScreenState extends State<Message3Screen> {
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
                Text(
                  "Statistics",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 30,
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
                    ConstanceData.v44,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "26",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Books",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                    ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(child: Image.asset(ConstanceData.v45)),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "244",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Hours",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                    ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(child: Image.asset(ConstanceData.v46)),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "DAY",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 12,
                        ),
                  ),
                  Text(
                    "2 WEEK",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 12,
                        ),
                  ),
                  Column(
                    children: [
                      Text(
                        "MONTH",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 20,
                        width: 10,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(1)),
                        ),
                      )
                    ],
                  ),
                  Text(
                    "3 MONTH",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 12,
                        ),
                  ),
                  Text(
                    "YEAR",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 12,
                        ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
