// ignore_for_file: deprecated_member_use, library_private_types_in_public_api, avoid_unnecessary_containers, sized_box_for_whitespace, constant_identifier_names, prefer_const_constructors, avoid_single_cascade_in_expression_statements

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lovebook/Constance/constance.dart';
import 'package:lovebook/Constance/theme.dart';
import 'package:lovebook/Stock/Stock.dart';
import 'package:lovebook/home_screen/home_screen.dart';
import 'package:lovebook/message/message_screen.dart';
import 'package:lovebook/profile/profile_screem.dart';
import 'package:lovebook/utils/images.dart';
import 'package:lovebook/utils/music_player_util/music_controller.dart';

import '../community/community_main_page.dart';
import '../data_layer/manager/manager.dart';
import '../utils/music_player_util/music_custom_screen.dart';
import '../utils/slide_up_panel.dart';
import '../utils/themes/theme_manager.dart';

class PageScreen extends ConsumerStatefulWidget {
  const PageScreen({super.key});

  @override
  _PageScreenState createState() => _PageScreenState();
}

class _PageScreenState extends ConsumerState<PageScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Widget indexView;
  BottomBarType bottomBarType = BottomBarType.Home;
  late MusicController controller;
  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    indexView = HomeScreen(
      animationController: animationController,
    );
    animationController..forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PageScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      controller = ref.watch(musicManager);
      return Scaffold(
        key: controller.homeScaffoldkey,
        body: SlidingUpPanel(
          onPanelSlide: controller.panellistener,
          controller: controller.playerPanelController,
          maxHeight: MediaQuery.of(context).size.height,
          minHeight: controller.playerPanelMinHeight,
          panel: PlayerScreen(),
          body: Container(
            child: Scaffold(
              backgroundColor:
                  ref.watch(themeController).getTheme().backgroundColor,
              bottomNavigationBar: Container(
                  height: 58 + MediaQuery.of(context).padding.bottom,
                  child: getBottomBarUI(bottomBarType)),
              body: Column(
                children: [
                  // GlobalMusicIndicator(),
                  Expanded(child: indexView),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void tabClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      animationController.reverse().then((f) {
        if (tabType == BottomBarType.Home) {
          setState(() {
            indexView = HomeScreen(
              animationController: animationController,
            );
          });
        } else if (tabType == BottomBarType.stock) {
          setState(() {
            indexView = StockScreen(
              animationController: animationController,
            );
          });
        } else if (tabType == BottomBarType.Catalogue) {
          setState(() {
            indexView = CommunityMainScreen(
              animationController: animationController,
            );
          });
        } else if (tabType == BottomBarType.shelf) {
          setState(() {
            indexView = ShelfScreen(
              animationController: animationController,
            );
          });
        } else if (tabType == BottomBarType.Profile) {
          setState(() {
            indexView = ProfileScreem(
              animationController: animationController,
            );
          });
        }
      });
    }
  }

  Widget getBottomBarUI(BottomBarType tabType) {
    return Consumer(builder: (context, ref, child) {
      return Container(
        height: 70 + MediaQuery.of(context).padding.bottom,
        decoration: BoxDecoration(
          color: ref.watch(themeController).isLight
              ? Color(0xFFffffff)
              : HexColor("#111827"),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(5.0, 5.0),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            right: 24,
            left: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  tabClick(BottomBarType.Home);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Image.asset(
                      BookImages.homeIcon,
                      height: 24,
                      color: tabType == BottomBarType.Home
                          ? Theme.of(context).primaryColor
                          : HexColor("#b1b1ba"),
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                          fontSize: 12,
                          color: tabType == BottomBarType.Home
                              ? Theme.of(context).primaryColor
                              : HexColor("#b1b1ba")),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  tabClick(
                    BottomBarType.shelf,
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Image.asset(
                      BookImages.explore,
                      height: 24,
                      color: tabType == BottomBarType.shelf
                          ? Theme.of(context).primaryColor
                          : HexColor("#b1b1ba"),
                    ),
                    Text(
                      "Explore",
                      style: TextStyle(
                          fontSize: 12,
                          color: tabType == BottomBarType.shelf
                              ? Theme.of(context).primaryColor
                              : HexColor("#b1b1ba")),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  tabClick(
                    BottomBarType.Catalogue,
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Image.asset(
                      BookImages.community,
                      height: 24,
                      color: tabType == BottomBarType.Catalogue
                          ? Theme.of(context).primaryColor
                          : HexColor("#b1b1ba"),
                    ),
                    Text(
                      "Community",
                      style: TextStyle(
                          fontSize: 12,
                          color: tabType == BottomBarType.Catalogue
                              ? Theme.of(context).primaryColor
                              : HexColor("#b1b1ba")),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  tabClick(BottomBarType.Profile);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    SvgPicture.asset(
                      ConstanceData.sv56,
                      height: 24,
                      color: tabType == BottomBarType.Profile
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).disabledColor,
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 12,
                          color: tabType == BottomBarType.Profile
                              ? Theme.of(context).primaryColor
                              : HexColor("#b1b1ba")),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

enum BottomBarType {
  Home,
  shelf,
  stock,
  Catalogue,
  Profile,
}
