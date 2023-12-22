// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import '../Constance/constance.dart';
import '../Constance/theme.dart';
import '../home_screen/22_filter.dart';

class Recommendation3Screen extends StatefulWidget {
  const Recommendation3Screen({super.key});

  @override
  State<Recommendation3Screen> createState() => _Recommendation3ScreenState();
}

class _Recommendation3ScreenState extends State<Recommendation3Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: 18,
            right: 18,
            top: MediaQuery.of(context).padding.top + 16,
            bottom: MediaQuery.of(context).padding.bottom),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        ConstanceData.s1,
                        height: 20,
                      ),
                    ),
                    Text(
                      "Recommendations",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Image.asset(
                      ConstanceData.m23,
                      height: 20,
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
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          com(ConstanceData.m2, "FROM HELL", "Alan Moore",
                              "\$ 30", "34"),
                          SizedBox(
                            width: 10,
                          ),
                          com(ConstanceData.m20, "Wonders Will \nNever Cease",
                              "Robert Irwin", "\$ 14", "15.40"),
                          SizedBox(
                            width: 10,
                          ),
                          com(ConstanceData.m21, "Jacoby", "Willam Ritter",
                              "\$ 6.98", "7.68"),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          com(ConstanceData.m22, "Ghostly \nEchoes",
                              "Willam Ritter", "\$ 6.98", "7.68"),
                          SizedBox(
                            width: 10,
                          ),
                          com(ConstanceData.m24, "Warlight: \nA novel",
                              "Michael \nOndaatje", "\$ 20", "22"),
                          SizedBox(
                            width: 10,
                          ),
                          com(ConstanceData.m25, "Shadow and \nBone",
                              "Leigh Bardugo", "\$ 16", "17.60"),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          com(ConstanceData.m26, "Caraval",
                              "Stephanie \nGarber", "\$10", "11"),
                          SizedBox(
                            width: 10,
                          ),
                          com(ConstanceData.m27, "Everless", "Sara Holland",
                              "\$ 12", "13.20"),
                          SizedBox(
                            width: 10,
                          ),
                          com(
                              ConstanceData.m28,
                              "My Lady \nJane",
                              "Cynthia Hand, \nBrodi Ashton,\nJodi Meadows",
                              "\$ 7",
                              "7.70"),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FilterScreen(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget com(String img, String tex1, String tex2, String tex3, String tex4) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          img,
          height: 155,
          fit: BoxFit.contain,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          tex1,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 14,
              ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          tex2,
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
              tex3,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).disabledColor),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              tex4,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  decoration: TextDecoration.lineThrough,
                  fontSize: 14,
                  color: Theme.of(context).disabledColor),
            ),
          ],
        )
      ],
    );
  }
}
