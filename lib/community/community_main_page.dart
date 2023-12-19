import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovebook/community/widget/all_post_widget.dart';
import 'package:lovebook/community/widget/my_post_widget.dart';
import 'package:lovebook/utils/scaffold/custom_scaffold.dart';

import '../data_layer/controller/communityController.dart';
import '../data_layer/manager/manager.dart';
import '../utils/dialog/snack_bars.dart';

class CommunityMainScreen extends ConsumerStatefulWidget {
  final AnimationController animationController;
  const CommunityMainScreen({Key? key, required this.animationController})
      : super(key: key);

  @override
  ConsumerState<CommunityMainScreen> createState() =>
      _CommunityMainScreenState();
}

class _CommunityMainScreenState extends ConsumerState<CommunityMainScreen>
    with TickerProviderStateMixin
    implements CommunityView {
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
  Widget build(BuildContext context) {
    ref.watch(communityManager).setView(this);
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
                  length: 2,
                  child: CustomScaffold(
                    // backgroundColor: Theme.of(context).primaryColor,
                    pageState: ref.watch(communityManager).pageState,
                    appBar: AppBar(
                      // backgroundColor: Theme.of(context).primaryColor,
                      iconTheme:
                          IconTheme.of(context).copyWith(color: Colors.white),
                      title: Text(
                        'Community',
                      ),
                      bottom: TabBar(
                        tabs: [
                          Tab(text: 'All Posts'),
                          Tab(text: 'My Post'),
                        ],
                      ),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(15),
                      child: TabBarView(
                        physics:
                            NeverScrollableScrollPhysics(), // Disable swiping
                        children: [AllPostWidget(), MyPostWidget()],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }

  @override
  onError(String message) {
    errorSnack(
      context,
      message,
    );
  }

  @override
  onSuccessful(String message) {
    successSnack(
      context,
      message,
    );
  }
}
