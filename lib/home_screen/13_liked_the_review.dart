// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Constance/constance.dart';
import '../home_screen/14_all_review.dart';

class LikedTheReviewScreen extends StatefulWidget {
  const LikedTheReviewScreen({super.key});

  @override
  State<LikedTheReviewScreen> createState() => _LikedTheReviewScreenState();
}

class _LikedTheReviewScreenState extends State<LikedTheReviewScreen> {
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
                  "Liked the review",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                      ),
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
                  com(ConstanceData.s49, "Melanie Strong", "10 Reviews",
                      "8 followers"),
                  SizedBox(
                    height: 30,
                  ),
                  com(ConstanceData.s50, "Dan Risch", "100 Reviews",
                      "45 followers"),
                  SizedBox(
                    height: 30,
                  ),
                  com(ConstanceData.s51, "Philip & Amy", "2 Reviews",
                      "1 followers"),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        ConstanceData.s52,
                        height: 50,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Zhenya Rynzhuk",
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
                                "241 Reviews",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontSize: 10,
                                        color: Theme.of(context).disabledColor),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: 3,
                                backgroundColor:
                                    Theme.of(context).disabledColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "65 K followers",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontSize: 10,
                                        color: Theme.of(context).disabledColor),
                              ),
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 237, 237, 237),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Center(
                          child: Text(
                            "Following",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  com(ConstanceData.s53, "Alexandra Anderson", "1 Reviews", ""),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget com(String img, String tex1, String tex2, String tex3) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AllReviewScreen(),
          ),
        );
      },
      child: Row(
        children: [
          Image.asset(
            img,
            height: 50,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tex1,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 14,
                    ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    tex2,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 10, color: Theme.of(context).disabledColor),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 3,
                    backgroundColor: Theme.of(context).disabledColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    tex3,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 10, color: Theme.of(context).disabledColor),
                  ),
                ],
              )
            ],
          ),
          Spacer(),
          Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Center(
              child: Text(
                "Follow",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 14, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
