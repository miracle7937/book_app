// ignore_for_file: deprecated_member_use, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Constance/constance.dart';
import '../Constance/theme.dart';

class TheDivineComedyScreen extends StatefulWidget {
  const TheDivineComedyScreen({super.key});

  @override
  State<TheDivineComedyScreen> createState() => _TheDivineComedyScreenState();
}

class _TheDivineComedyScreenState extends State<TheDivineComedyScreen> {
  int pageNumber = 0;

  final PageController _pageController = PageController();
  bool isdark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(
            left: 18,
            right: 18,
            top: MediaQuery.of(context).padding.top + 16,
            bottom: MediaQuery.of(context).padding.bottom),
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
                "Dante Alighieri ",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 12, color: Theme.of(context).disabledColor),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              _pageController.jumpToPage(0);
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                "READING",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        color: pageNumber == 0
                                                            ? HexColor(
                                                                "#323232")
                                                            : Theme.of(context)
                                                                .disabledColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                height: 3,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: pageNumber == 0
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              _pageController.jumpToPage(1);
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                "CONTROL",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        color: pageNumber == 1
                                                            ? HexColor(
                                                                "#323232")
                                                            : Theme.of(context)
                                                                .disabledColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                height: 3,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: pageNumber == 1
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              _pageController.jumpToPage(2);
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                "CONTENTS",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        color: pageNumber == 2
                                                            ? HexColor(
                                                                "#323232")
                                                            : Theme.of(context)
                                                                .disabledColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                height: 3,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: pageNumber == 2
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Expanded(
                                      child: PageView(
                                        controller: _pageController,
                                        physics: BouncingScrollPhysics(),
                                        onPageChanged: (value) {
                                          setState(() {
                                            pageNumber = value;
                                          });
                                        },
                                        children: [
                                          //****************** *
                                          ListView(
                                            padding: EdgeInsets.zero,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Aa",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                fontSize: 40,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "Gotham",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                              fontSize: 14,
                                                            ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Image.asset(
                                                        ConstanceData.v19,
                                                        height: 10,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Container(
                                                        height: 40,
                                                        width: 80,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: Theme.of(
                                                                    context)
                                                                .dividerColor,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                              "-",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                            ),
                                                            Text(
                                                              "+",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          ConstanceData.v2,
                                                          height: 50,
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Image.asset(
                                                          ConstanceData.v5,
                                                          height: 30,
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Image.asset(
                                                          ConstanceData.v8,
                                                          height: 50,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          ConstanceData.v3,
                                                          height: 50,
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Image.asset(
                                                          ConstanceData.v6,
                                                          height: 30,
                                                        ),
                                                        SizedBox(
                                                          height: 25,
                                                        ),
                                                        Image.asset(
                                                          ConstanceData.v9,
                                                          height: 30,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          ConstanceData.v4,
                                                          height: 50,
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Image.asset(
                                                          ConstanceData.v7,
                                                          height: 30,
                                                        ),
                                                        SizedBox(
                                                          height: 25,
                                                        ),
                                                        Image.asset(
                                                          ConstanceData.v10,
                                                          height: 30,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Image.asset(
                                                ConstanceData.v11,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                fit: BoxFit.contain,
                                              )
                                            ],
                                          ),
                                          // *******************
                                          ListView(
                                            padding: EdgeInsets.zero,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          ConstanceData.v12,
                                                          height: 30,
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "Leaf",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyLarge!
                                                              .copyWith(
                                                                  fontSize: 12,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .disabledColor),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          ConstanceData.v13,
                                                          height: 30,
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "Swipe",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyLarge!
                                                              .copyWith(
                                                                  fontSize: 12,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .disabledColor),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          ConstanceData.v14,
                                                          height: 30,
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "Scroll",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyLarge!
                                                              .copyWith(
                                                                  fontSize: 12,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .disabledColor),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          ConstanceData.v15,
                                                          height: 30,
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "Tap",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyLarge!
                                                              .copyWith(
                                                                  fontSize: 12,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .disabledColor),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 50,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    ConstanceData.v16,
                                                    height: 50,
                                                  ),
                                                  SizedBox(
                                                    width: 40,
                                                  ),
                                                  Image.asset(
                                                    ConstanceData.v17,
                                                    height: 50,
                                                  ),
                                                  SizedBox(
                                                    width: 40,
                                                  ),
                                                  Image.asset(
                                                    ConstanceData.v18,
                                                    height: 50,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Flipping the volume button",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                          fontSize: 14,
                                                        ),
                                                  ),
                                                  CupertinoSwitch(
                                                    value: isdark,
                                                    activeColor:
                                                        HexColor("#4D7EFF"),
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        isdark = value!;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Word wrap",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                          fontSize: 14,
                                                        ),
                                                  ),
                                                  CupertinoSwitch(
                                                    value: isdark,
                                                    activeColor:
                                                        HexColor("#4D7EFF"),
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        isdark = value!;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          // *******************
                                          ListView(
                                            padding: EdgeInsets.zero,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "PURGATORIO",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                            fontSize: 16,
                                                            color: Theme.of(
                                                                    context)
                                                                .disabledColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  Text(
                                                    "PARADISE",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "2%",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontSize: 12,
                                                        color: Theme.of(context)
                                                            .disabledColor),
                                              ),
                                              SizedBox(
                                                height: 40,
                                              ),
                                              Text(
                                                "CANTO I",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Text(
                                                "CANTO II",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "CANTO III",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "CANTO Iv",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "CANTO v",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      fontSize: 14,
                                                      color: Theme.of(context)
                                                          .disabledColor,
                                                    ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "CANTO Iv",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      fontSize: 12,
                                                      color: Theme.of(context)
                                                          .dividerColor,
                                                    ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.isLightTheme
                                  ? Colors.white
                                  : Colors.black,
                              border: Border.all(color: HexColor("#EBEBF0")),
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(25.0),
                                topRight: const Radius.circular(25.0),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: SvgPicture.asset(
                  ConstanceData.sv38,
                  height: 20,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "The Divine Comedy",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 18,
                ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "PARADISE",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 14,
                ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "CANTO I",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (builder) {
                  return ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(40),
                        topRight: const Radius.circular(40)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: ListView(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "ENGLISH",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Image.asset(
                                        ConstanceData.v20,
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        "РУССКИЙ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    "Этот самый большой из его светлых приемов, был я, Свидетель того, что нужно связать снова Превосходит силу того, кто приходит оттуда;",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontSize: 16,
                                            color:
                                                Theme.of(context).disabledColor,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "SAVE AS NOTE",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Text(
              "His glory, by whose might all things are mov'd,Pierces the universe, and in one partSheds more resplendence, elsewhere less.  In heav'n,That largeliest of his light partakes, was I,Witness of tings, which to relate againSurpasseth power of him who comes from thence;For that, so near approaching its desireOur intellect is to such depth absorb'd,That memory cannot follow.  Nathless all,That in my thoughts I of that sacred realmCould store, shall now be matter of my song. Benign Apollo! this last labour aid,And make me such a vessel of thy worth,As thy own laurel claims of me belov'd.Thus far hath one of steep Parnassus' browsSuffic'd me; henceforth there is need of bothFor my remaining enterprise Do thouEnter into my bosom, and there breatheSo, as when Marsyas by thy hand was dragg'dForth from his limbs unsheath'd.  O power divine!If thou to me of shine impart so much,That of that happy realm the shadow'd formTrac'd in my thoughts I may set forth to view,Thou shalt behold me of thy favour'd treeCome to the foot, and crown myself with leaves;For to that honour thou, and my high themeWill fit me.  If but seldom, mighty Sire!To grace his triumph gathers thence a wreathCaesar or bard (more shame for human willsDeprav'd) joy to the Delphic god must springFrom the Pierian foliage, when one breastIs with such thirst inspir'd.  From a small sparkGreat flame hath risen: after me perchanceOthers with better voice may pray, and gainFrom the Cirrhaean city answer kind. Through diver passages, the world's bright lampRises to mortals, but through that which joinsFour circles with the threefold cross, in bestCourse, and in happiest constellation setHe comes, and to the worldly wax best givesIts temper and impression.  Morning there,Here eve was by almost such passage made;And whiteness had o'erspread that hemisphere,Blackness the other part; when to the leftI saw Beatrice turn'd, and on the sunGazing, as never eagle fix'd his ken.As from the first a second beam is wontTo issue, and reflected upwards rise,E'en as a pilgrim bent on his return,So of her act, that through the eyesight pass'dInto my fancy, mine was form'd; and straight,Beyond our mortal wont, I fix'd mine eyesUpon the sun.  Much is allowed us there,That here exceeds our pow'r; thanks to the placeMade for the dwelling of the human kind",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 12,
                  ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "The Divine Comedy",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).disabledColor),
              ),
              Text(
                "1/120",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).disabledColor),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
