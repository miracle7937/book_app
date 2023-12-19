// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lovebook/Constance/constance.dart';
import 'package:lovebook/Constance/theme.dart';
import 'package:lovebook/home_screen/20_recommendations_2.dart';

import '22_filter.dart';

class Recommendation1Screen extends StatefulWidget {
  const Recommendation1Screen({super.key});

  @override
  State<Recommendation1Screen> createState() => _Recommendation1ScreenState();
}

class _Recommendation1ScreenState extends State<Recommendation1Screen> {
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
                Text(
                  "Recommendations",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Recommendations2Screen(),
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
              height: 5,
            ),
            Text(
              "82 books",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 12, color: Theme.of(context).disabledColor),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 400,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            ConstanceData.m20,
                            height: 300,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Wonders Will Never Cease",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Robert Irwine",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "\$ 14",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).disabledColor),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "15.40",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 14,
                                        color: Theme.of(context).dividerColor),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            ConstanceData.m21,
                            height: 300,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Jacoby",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Willam Ritter",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "\$ 6.98",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).disabledColor),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "7.68",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 14,
                                        color: Theme.of(context).dividerColor),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            ConstanceData.m22,
                            height: 300,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Ghostly Echoes",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Willam Ritter",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "\$ 6.98",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).disabledColor),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "7.68",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 14,
                                        color: Theme.of(context).disabledColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FilterScreen(),
                  ),
                );
              },
              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: AppTheme.isLightTheme
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Center(
                  child: Text(
                    "FILTER",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
