// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sidecampus/utils/images.dart';

import '../Widget/rating_stars.dart';
import '../data_layer/manager/manager.dart';
import '../data_layer/models/search_book_response.dart';
import '../home_screen/screen/9_FROM_HELL.dart';
import '../home_screen/widget/shimmer_widget.dart';
import '../utils/list_helper.dart';
import '../utils/scaffold/custom_scaffold.dart';

class ShelfScreen extends ConsumerStatefulWidget {
  final AnimationController animationController;
  final int? index;

  const ShelfScreen({super.key, required this.animationController, this.index});

  @override
  ConsumerState<ShelfScreen> createState() => _ShelfScreenState();
}

class _ShelfScreenState extends ConsumerState<ShelfScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late ScrollController controller;

  bool isLoading = true;
  var sliderImageHieght = 0.0;
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 0), vsync: this);
    widget.animationController.forward();
    controller = ScrollController(initialScrollOffset: 0.0);
    controller.addListener(() {
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

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    isLoading = true;
    _animationController.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sliderImageHieght = MediaQuery.of(context).size.width * 1.3;
    if (isLoading) {
      ref.watch(searchBookManager).getBooksByCategory(ref
              .watch(homeControllerManager)
              .homeResponseModel
              ?.data
              ?.collection
              ?.first
              .title ??
          "");
      isLoading = false;
    }

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
                child: DefaultTabController(
                  initialIndex: widget.index ?? 0,
                  length: ref
                          .watch(homeControllerManager)
                          .homeResponseModel
                          ?.data
                          ?.collection
                          ?.length ??
                      0,
                  child: CustomScaffold(
                    pageState: ref.watch(searchBookManager).pageState,
                    body: Padding(
                      padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: MediaQuery.of(context).padding.top + 16,
                          bottom: MediaQuery.of(context).padding.bottom),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Bookshelf",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                            ],
                          ),
                          TabBar(
                            onTap: (int v) {
                              ref.watch(searchBookManager).getBooksByCategory(
                                  ref
                                      .watch(homeControllerManager)
                                      .homeResponseModel
                                      ?.data
                                      ?.collection![v]
                                      .title,
                                  refresh: true);
                            },
                            isScrollable: true,
                            tabs: (ref
                                        .watch(homeControllerManager)
                                        .homeResponseModel
                                        ?.data
                                        ?.collection ??
                                    [])
                                .map((e) => Tab(
                                      text: e.title.toString(),
                                    ))
                                .toList(),
                          ),
                          !isListEmpty(ref
                                  .watch(searchBookManager)
                                  .searchBookResponseCategories
                                  ?.data)
                              ? Expanded(
                                  child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 8.0,
                                          mainAxisSpacing: 8.0,
                                          childAspectRatio: (150.0 / 220.0)),
                                  itemCount: ref
                                          .watch(searchBookManager)
                                          .searchBookResponseCategories
                                          ?.data
                                          ?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    // return Text("ok");
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => FromHellScreen(
                                              bookID: ref
                                                  .watch(searchBookManager)
                                                  .searchBookResponseCategories
                                                  ?.data?[index]
                                                  .id,
                                            ),
                                          ),
                                        );
                                      },
                                      child: _View(
                                        fullBookData: ref
                                            .watch(searchBookManager)
                                            .searchBookResponseCategories!
                                            .data![index],
                                      ),
                                    );
                                  },
                                ))
                              : Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.35,
                                      ),
                                      SizedBox(
                                          height: 30,
                                          child: Image.asset(
                                              BookImages.empty_list)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Empty bookshelf")
                                    ],
                                  ),
                                ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                )));
      },
    );
  }
}

class _View extends StatelessWidget {
  final FullBookData fullBookData;
  const _View({Key? key, required this.fullBookData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: fullBookData.images ?? "",
              placeholder: (context, url) => ShimmerWidget(
                height: 150,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            fullBookData.title ?? "",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 12,
                ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            fullBookData.author ?? "",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 10, color: Theme.of(context).disabledColor),
          ),
          SizedBox(
            height: 5,
          ),
          RatingStar(
            iconSize: 12,
          )
        ],
      ),
    );
  }
}
