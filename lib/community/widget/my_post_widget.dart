import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data_layer/controller/communityController.dart';
import '../../data_layer/manager/manager.dart';
import '../single_post_screen.dart';
import 'chat_view.dart';

class MyPostWidget extends ConsumerStatefulWidget {
  const MyPostWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<MyPostWidget> createState() => _MyPostWidgetState();
}

class _MyPostWidgetState extends ConsumerState<MyPostWidget> {
  bool isLoading = true;
  late CommunityController controller;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ref.watch(communityManager).getMyPost();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  selectAction(String action, String postID) async {
    switch (action) {
      case "delete":
        await ref
            .watch(communityManager)
            .deletePost(postID)
            .whenComplete(() => ref.watch(communityManager).refreshMyPost());
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    controller = ref.watch(communityManager);
    if (isLoading) {
      controller.getMyPost();
      isLoading = false;
    }
    return RefreshIndicator(
      onRefresh: () async {
        ref.watch(communityManager).refreshMyPost();
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount:
            controller.myPosts.isNotEmpty ? controller.myPosts.length + 1 : 0,
        itemBuilder: (BuildContext context, int index) {
          if (index == ref.read(communityManager).myPosts.length) {
            return _buildLoader();
          }
          return ChatViewWidget(
            selector: PopupMenuButton<String>(
              icon: Icon(Icons.more_vert), // Three-dot icon
              onSelected: (String result) {
                selectAction(result, controller.myPosts[index].id.toString());
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Text(
                    'Delete Post',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                // PopupMenuItem<String>(
                //   value: 'edit',
                //   child: Text('Edit Post'),
                // ),
              ],
            ),
            scrollController: _scrollController,
            index: index,
            allPost: ref.read(communityManager).myPosts[index],
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => SinglePostScreen(
                        scrollController: _scrollController,
                        index: index,
                        allPost: ref.read(communityManager).myPosts[index],
                      )));
            },
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
