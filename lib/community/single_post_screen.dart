import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../community/widget/chat_view.dart';
import '../data_layer/manager/manager.dart';
import '../data_layer/models/post_comment_model.dart';
import '../data_layer/models/post_model_response.dart';
import '../profile/widget/select_image_view.dart';
import '../utils/dialog/coumminity_post_message_dialog.dart';
import '../utils/dialog/snack_bars.dart';
import '../utils/list_helper.dart';
import '../utils/local_storage_data.dart';
import '../utils/scaffold/custom_scaffold.dart';
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
  bool hidReportPost = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    LocalDataStorage.getUserData().then((value) {
      hidReportPost = value?.id == widget.allPost?.userId;
    });
  }

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
                              willRefreshComment: () {
                                // ref.read(communityManager).openPostComment(
                                //     widget.allPost!.id.toString());
                              },
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
                            .comment![index],
                        reportWidget: hidReportPost == false
                            ? multipleSelect(ref
                                .read(communityManager)
                                .postCommentModel!
                                .data!
                                .comment![index]
                                .id!)
                            : Container(),
                      ),
                    ],
                  );
                },
              )),
            ],
          ),
        ));
  }

  multipleSelect(int id) {
    return PopupMenuButton<int>(
      onSelected: (value) {
        if (value == 1) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CommentDialog(
                title: 'Report a Comment',
                onTap: (message) {
                  reportComment(message, id);
                },
                btnTitle: 'Report',
              );
            },
          );
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 1,
          child: Text('Report Post'),
        ),
      ],
    );
  }

  reportComment(String? message, int id) {
    if (isNotEmpty(message)) {
      ref
          .watch(communityManager)
          .reportComment(id.toString(), message!)
          .whenComplete(() {
        errorSnack(context,
            "Comment has been reported and is currently under review.");
      });
    }
  }
}

class ViewOfComment extends StatelessWidget {
  final Comment comment;
  final Widget reportWidget;
  const ViewOfComment(
      {Key? key, required this.comment, required this.reportWidget})
      : super(key: key);

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
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
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
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey),
                ),
                Row(
                  children: [Spacer(), reportWidget ?? Container()],
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Theme.of(context).appBarTheme.backgroundColor,
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
