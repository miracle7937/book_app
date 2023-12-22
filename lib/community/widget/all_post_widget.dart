import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data_layer/controller/communityController.dart';
import '../../data_layer/manager/manager.dart';
import '../single_post_screen.dart';
import 'chat_view.dart';
import 'community_message_widget.dart';

class AllPostWidget extends ConsumerStatefulWidget {
  const AllPostWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<AllPostWidget> createState() => _AllPostWidgetState();
}

class _AllPostWidgetState extends ConsumerState<AllPostWidget> {
  ScrollController _scrollController = ScrollController();
  late CommunityController controller;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ref.watch(communityManager).getAllPost(controller.batchIndex);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    controller = ref.watch(communityManager);
    if (isLoading) {
      controller.getAllPost(controller.batchIndex);
      isLoading = false;
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.watch(communityManager).refresh();
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount:
            controller.posts.isNotEmpty ? controller.posts.length + 1 : 0,
        itemBuilder: (context, index) {
          if (index == ref.read(communityManager).posts.length) {
            return _buildLoader();
          }
          return Column(
            children: [
              index == 0
                  ? Column(
                      children: [
                        CommunityMessageWidget(),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  : Container(),
              ChatViewWidget(
                scrollController: _scrollController,
                index: index,
                allPost: ref.read(communityManager).posts[index],
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (builder) => SinglePostScreen(
                            scrollController: _scrollController,
                            index: index,
                            allPost: ref.read(communityManager).posts[index],
                          )));
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoader() {
    return Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: Colors.red,
      ),
    );
  }
}
