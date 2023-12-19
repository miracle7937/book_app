import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lovebook/Constance/constance.dart';
import 'package:lovebook/data_layer/models/home_response_model.dart';
import 'package:lovebook/home_screen/screen/25_search.dart';
import 'package:lovebook/home_screen/screen/9_FROM_HELL.dart';
import 'package:lovebook/home_screen/screen/subscribe_screen.dart';
import 'package:lovebook/home_screen/widget/Popular_widget.dart';
import 'package:lovebook/home_screen/widget/book_of_the_week.dart';
import 'package:lovebook/home_screen/widget/collections_widget.dart';
import 'package:lovebook/home_screen/widget/shimmer.dart';
import 'package:lovebook/home_screen/widget/subscription_widger.dart';
import 'package:lovebook/home_screen/widget/view_widget.dart';
import 'package:lovebook/utils/images.dart';
import 'package:lovebook/utils/page_state.dart';

import '../data_layer/controller/home_controller.dart';
import '../data_layer/manager/manager.dart';
import '../message/message_screen.dart';
import '../utils/custom_cache_image.dart';
import '../utils/list_helper.dart';
import '../utils/native_launcher.dart';
import '../utils/scaffold/custom_scaffold.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final AnimationController animationController;

  const HomeScreen({super.key, required this.animationController});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late ScrollController controller;
  bool isLoadingSliderDetail = false;
  var sliderImageHieght = 0.0;
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 0), vsync: this);
    widget.animationController.forward();
    controller = ScrollController(initialScrollOffset: 0.0);

    controller.addListener(() {
      // ignore: unnecessary_null_comparison
      if (context != null) {
        if (controller.offset < 0) {
          _animationController.animateTo(0.0);
        } else if (controller.offset > 0.0 &&
            controller.offset < sliderImageHieght) {
          if (controller.offset < ((sliderImageHieght / 1.5))) {
            _animationController
                .animateTo((controller.offset / sliderImageHieght));
          } else {
            _animationController
                .animateTo((sliderImageHieght / 1.5) / sliderImageHieght);
          }
        }
      }
    });
    loadingSliderDetail();
    super.initState();
  }

  loadingSliderDetail() async {
    setState(() {
      isLoadingSliderDetail = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      isLoadingSliderDetail = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isdark = false;
  int index = 0;
  HomeController? homeController;
  @override
  Widget build(BuildContext context) {
    sliderImageHieght = MediaQuery.of(context).size.width * 1.3;
    homeController = ref.watch(homeControllerManager);
    homeController?.init();

    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animationController,
          child: Transform(
            transform: new Matrix4.translationValues(
              0.0,
              40 * (1.0 - widget.animationController.value),
              0.0,
            ),
            child: CustomScaffold(
              pageState: PageState.loaded,
              backgroundColor: Colors.grey.withOpacity(0.2),
              body: Padding(
                padding: EdgeInsets.only(
                  left: 18,
                  right: 18,
                  top: MediaQuery.of(context).padding.top + 16,
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discovery",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                        SizedBox(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SerchScreen(),
                              ),
                            );
                          },
                          child: SvgPicture.asset(
                            ConstanceData.sv3,
                            height: 20,
                          ),
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
                          homeController?.pageState == PageState.loading
                              ? ShimmerView(
                                  height: 100,
                                )
                              : !isListEmpty(homeController
                                      ?.homeResponseModel?.data?.slider)
                                  ? ExpandableCarousel(
                                      options: CarouselOptions(
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        viewportFraction: 0.9,
                                        aspectRatio: 2.0,
                                      ),
                                      items: (homeController?.homeResponseModel
                                                  ?.data?.slider ??
                                              [])
                                          .map((sliderValue) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return InkWell(
                                              onTap: () {
                                                launchContactMethod(
                                                    ContactMethod.url,
                                                    sliderValue.url);
                                              },
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5.0),
                                                  child: CustomCacheImage(
                                                    image: sliderValue.images ??
                                                        "",
                                                    height: 180,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }).toList(),
                                    )
                                  : Container(),
                          SizedBox(
                            height: 20,
                          ),
                          SubscriptionWidget(
                            ontap: () async {
                              bool? status = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SubscribeScreen()));

                              if (status == true) {
                                log("Refresh home=============>");
                                homeController?.getHomeData(refresh: true);
                              }
                            },
                            myPlan: homeController
                                ?.homeResponseModel?.data?.myPlan?.first,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Category",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          homeController?.pageState == PageState.loading
                              ? ShimmerView(
                                  height: 100,
                                )
                              : SizedBox(
                                  height: 100,
                                  child: ListView.builder(
                                    itemCount: homeController?.homeResponseModel
                                            ?.data?.collection?.length ??
                                        0,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (_, index) => InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    ShelfScreen(
                                                      animationController:
                                                          _animationController,
                                                      index: index,
                                                    )));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CollectionWidget(
                                          image: BookImages().getCollection(),
                                          collection: homeController
                                              ?.homeResponseModel
                                              ?.data
                                              ?.collection?[index],
                                        ),
                                      ),
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
                                "Latest",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          homeController?.pageState == PageState.loading
                              ? ShimmerView(
                                  height: 220,
                                )
                              : SizedBox(
                                  height: 220,
                                  child: ListView.builder(
                                    itemCount: homeController?.homeResponseModel
                                            ?.data?.latest?.length ??
                                        0,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (_, index) {
                                      Latest? latest = homeController
                                          ?.homeResponseModel
                                          ?.data
                                          ?.latest?[index];
                                      return BookOfTheWeek(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => FromHellScreen(
                                                bookID: latest?.id,
                                              ),
                                            ),
                                          );
                                        },
                                        latest: latest,
                                      );
                                    },
                                  ),
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Popular",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          homeController?.pageState == PageState.loading
                              ? ShimmerView(
                                  height: 160,
                                )
                              : SizedBox(
                                  height: 160,
                                  child: ListView.builder(
                                    itemCount: homeController?.homeResponseModel
                                            ?.data?.popular?.length ??
                                        0,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (_, index) => InkWell(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => FromHellScreen(
                                            bookID: homeController
                                                ?.homeResponseModel
                                                ?.data
                                                ?.popular?[index]
                                                .id,
                                          ),
                                        ),
                                      ),
                                      child: PopularWidget(
                                        popularModel: homeController
                                            ?.homeResponseModel
                                            ?.data
                                            ?.popular?[index],
                                      ),
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
                                "Viewed",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          !isListEmpty(homeController
                                  ?.homeResponseModel?.data?.viewd)
                              ? SizedBox(
                                  height: 280,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: (homeController?.homeResponseModel
                                                    ?.data?.viewd ??
                                                [])
                                            .map((e) => InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            FromHellScreen(
                                                          bookID: e.id,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: ViewedWidget(
                                                    viewd: e,
                                                  ),
                                                ))
                                            .toList() ??
                                        [],
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
