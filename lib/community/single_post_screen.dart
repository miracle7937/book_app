import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:lovebook/community/widget/chat_view.dart';
import 'package:lovebook/utils/scaffold/custom_scaffold.dart';

import '../data_layer/manager/manager.dart';
import '../data_layer/models/post_comment_model.dart';
import '../data_layer/models/post_model_response.dart';
import '../profile/widget/select_image_view.dart';
import '../utils/list_helper.dart';
import '../utils/string_helper.dart';

class SinglePostScreen extends ConsumerStatefulWidget {
  final AllPost? allPost;
  final int index;
  final ScrollController scrollController;
  const SinglePostScreen(
      {Key? key,
      this.allPost,
      required this.index,
      required this.scrollController})
      : super(key: key);

  @override
  ConsumerState<SinglePostScreen> createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends ConsumerState<SinglePostScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      ref.read(communityManager).openPostComment(widget.allPost!.id.toString());
      isLoading = false;
    }
    return CustomScaffold(
        pageState: ref.watch(communityManager).pageState,
        appBar: AppBar(
          iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
          title: Text(
            'Community',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              isListEmpty(ref
                      .read(communityManager)
                      .postCommentModel
                      ?.data
                      ?.comment)
                  ? ChatViewWidget(
                      scrollController: ScrollController(),
                      index: 1,
                      allPost: ref
                          .read(communityManager)
                          .postCommentModel
                          ?.data
                          ?.allPost
                          ?.first,
                    )
                  : Container(),
              Expanded(
                  child: ListView.builder(
                itemCount: ref
                        .read(communityManager)
                        .postCommentModel
                        ?.data
                        ?.comment
                        ?.length ??
                    0,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      index == 0
                          ? ChatViewWidget(
                              scrollController: ScrollController(),
                              index: 1,
                              allPost: ref
                                  .read(communityManager)
                                  .postCommentModel
                                  ?.data
                                  ?.allPost
                                  ?.first,
                              willRefresh: () {
                                //refresh it
                                ref.read(communityManager).openPostComment(
                                    widget.allPost!.id.toString());
                              },
                            )
                          : Container(),
                      ViewOfComment(
                          comment: ref
                              .read(communityManager)
                              .postCommentModel!
                              .data!
                              .comment![index]),
                    ],
                  );
                },
              )),
            ],
          ),
        ));
  }
}

class ViewOfComment extends StatelessWidget {
  final Comment comment;
  const ViewOfComment({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SmallProfileImageView(
                      imageURL: comment.userImage ?? "",
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.userName ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          getDateTime(comment.createdAt),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  comment.comment ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Shadow color with alpha
                spreadRadius: 0,
                blurRadius: 8, // Blur radius
                offset: Offset(0, 4), // Vertical offset for bottom shadow
              )
            ],
          )),
    );
  }

  String getDateTime(String? date) {
    if (isEmpty(date)) {
      return "N/A";
    }
    DateTime targetDate = DateTime.parse(date!);
    return GetTimeAgo.parse(targetDate, locale: 'us');
  }
}
