import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flick_video_player/flick_video_player.dart';
// import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

import '../../data_layer/manager/manager.dart';
import '../../data_layer/models/post_model_response.dart';
import '../../profile/widget/select_image_view.dart';
import '../../utils/dialog/coumminity_post_message_dialog.dart';
import '../../utils/file_format_checker.dart';
import '../../utils/images.dart';
import '../../utils/string_helper.dart';
import '../../utils/themes/theme_manager.dart';

class ChatViewWidget extends ConsumerStatefulWidget {
  final AllPost? allPost;
  final int index;
  final ScrollController scrollController;
  final VoidCallback? onTap;
  final Widget? selector;
  final VoidCallback? willRefresh, willRefreshComment;
  final bool forSingleView;
  const ChatViewWidget(
      {Key? key,
      this.allPost,
      required this.index,
      this.selector,
      this.onTap,
      required this.scrollController,
      this.willRefresh,
      this.willRefreshComment,
      this.forSingleView = false})
      : super(key: key);

  @override
  ConsumerState<ChatViewWidget> createState() => _ChatViewWidgetState();
}

class _ChatViewWidgetState extends ConsumerState<ChatViewWidget> {
  late int like;
  late int comment;
  bool isLike = false;
  String getDateTime(String? date) {
    if (isEmpty(date)) {
      return "N/A";
    }
    DateTime targetDate = DateTime.parse(date!);
    return GetTimeAgo.parse(targetDate, locale: 'us');
  }

  postComment(String? message) {
    if (isNotEmpty(message)) {
      setState(() {
        comment++;
      });
      ref
          .watch(communityManager)
          .comment(widget.allPost!.id.toString(), message!)
          .whenComplete(() {
        if (widget.willRefresh != null) {
          widget.willRefresh!();
          if (widget.forSingleView) {
            widget.willRefreshComment!();
          }
        }
      });
    }
  }

  likeTogglePost() {
    if (isLike == false) {
      ref
          .watch(communityManager)
          .likePost(widget.allPost!.id.toString())
          .whenComplete(() {
        setState(() {
          like = like + 1;
          isLike = true;
        });
      });
    } else {
      ref
          .watch(communityManager)
          .disLikePost(widget.allPost!.id.toString())
          .whenComplete(() {
        setState(() {
          like = like - 1;
          isLike = false;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    like = widget.allPost?.likes ?? 0;
    comment = widget.allPost?.comment ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SmallProfileImageView(
                        imageURL: widget.allPost?.userImage ?? "",
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.allPost?.userName ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            getDateTime(widget.allPost?.createdAt),
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
                      Spacer(),
                      widget.selector == null ? Container() : widget.selector!
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  getUI(FileFormatChecker.checkFileType(widget.allPost?.media),
                      widget.allPost?.media),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.allPost?.message ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => likeTogglePost(),
                        child: Image.asset(
                          BookImages.like,
                          scale: 0.9,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(like.toString()),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return PostCommentDialog(
                                onTap: (message) {
                                  postComment(message);
                                },
                              );
                            },
                          );
                        },
                        child: Image.asset(
                          BookImages.comment,
                          scale: 0.9,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(comment.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: ref.watch(themeController).isLight
                  ? Colors.white
                  : Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.black.withOpacity(0.1), // Shadow color with alpha
                  spreadRadius: 0,
                  blurRadius: 8, // Blur radius
                  offset: Offset(0, 4), // Vertical offset for bottom shadow
                )
              ],
            )),
      ),
    );
  }

  Widget getUI(FileFormat format, String? file) {
    // return VisibleListItem(index: widget.index, scrollController: widget.scrollController,);
    print(format);
    if (file == null) {
      return Container();
    }
    switch (format) {
      case FileFormat.video:
        return _MediaVideo(
          scrollController: widget.scrollController,
          index: widget.index,
          filePath: file,
        );
      case FileFormat.image:
        return ImageView(
          filePath: file,
        );
      case FileFormat.audio:
        return _AudioPlayer(
          fileUrl: file,
          index: widget.index,
          scrollController: widget.scrollController,
        );
      case FileFormat.none:
        return Container();
    }
  }
}

class _MediaVideo extends StatefulWidget {
  final String filePath;
  final int index;
  final ScrollController scrollController;
  const _MediaVideo(
      {Key? key,
      this.filePath = "",
      required this.index,
      required this.scrollController})
      : super(key: key);

  @override
  State<_MediaVideo> createState() => _MediaVideoState();
}

class _MediaVideoState extends State<_MediaVideo> {
  // late VideoPlayerController _controller;
  // late ChewieController _chewieController;
  late VideoPlayerController controller;
  late FlickManager flickManager;
  bool _isVisible = false;

  void _checkIfWidgetIsVisible() async {
    print("Scrollable ===========================");
    if (_isVideoVisible()) {
      if (!_isVisible) {
        log('Video ${widget.index} is now visible!');
      }
    } else {
      if (_isVisible) {
        //     flickManager.flickControlManager?.pause();
        // _chewieController.pause();

        log('Video ${widget.index} is now out of view!');
      }
    }
  }

  bool _isVideoVisible() {
    print("Video Visibility");
    if (!controller.value.isPlaying) {
      return false;
    }

    if (!widget.scrollController.position.maxScrollExtent.isFinite) {
      return false;
    }

    final double itemExtent =
        widget.scrollController.position.maxScrollExtent / 50;
    final double itemOffset = widget.index * itemExtent;
    final double itemEnd = itemOffset + itemExtent;

    final double containerStart = widget.scrollController.offset;
    final double containerEnd =
        containerStart + widget.scrollController.position.viewportDimension;

    return !(itemEnd < containerStart || itemOffset > containerEnd);
  }

  @override
  void initState() {
    super.initState();
    // controller = VideoPlayerController.networkUrl(
    //   Uri.parse(
    //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    // );

    controller = VideoPlayerController.networkUrl(Uri.parse(widget.filePath));

    flickManager =
        FlickManager(videoPlayerController: controller, autoPlay: false);

    controller.addListener(() {
      if (!_isVideoVisible()) {
        // controller.pause();
      }
    });
    widget.scrollController.addListener(_checkIfWidgetIsVisible);
  }

  @override
  void dispose() {
    super.dispose();
    // controller.dispose();
    // flickManager.dispose();
    // _chewieController.dispose();
    widget.scrollController.removeListener(_checkIfWidgetIsVisible);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,

      child: Column(
        children: [
          Center(
            child: AspectRatio(
                aspectRatio: 16 / 11,
                child: FlickVideoPlayer(flickManager: flickManager)),
          ),
        ],
      ),
      // child: Center(
      //     child: Chewie(
      //   controller: _chewieController,
      // )),
    );
  }
}

class ImageView extends StatelessWidget {
  final String filePath;
  const ImageView({Key? key, this.filePath = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: PhotoView(
        backgroundDecoration: BoxDecoration(color: Colors.white),
        imageProvider: NetworkImage(
          filePath,
        ),
      ),
    );
  }
}

class _AudioPlayer extends StatefulWidget {
  final String fileUrl;
  final int index;
  final ScrollController scrollController;
  const _AudioPlayer(
      {Key? key,
      this.fileUrl = "",
      required this.index,
      required this.scrollController})
      : super(key: key);

  @override
  State<_AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<_AudioPlayer> {
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  double _progress = 0.0;
  double maxDuration = 0.0;

  bool _isVisible = false;

  @override
  void dispose() {
    widget.scrollController.removeListener(_checkIfWidgetIsVisible);
    _audioPlayer.dispose();
    super.dispose();
  }

  void _checkIfWidgetIsVisible() async {
    if (_isWidgetVisible()) {
      if (!_isVisible) {
        log('Audio ${widget.index} is now visible!');
      }
    } else {
      if (_isVisible) {
        await _audioPlayer.pause();
        setState(() {
          _isVisible = false;
          log('Audio ${widget.index} is now out of view!');
        });
      }
    }
  }

  bool _isWidgetVisible() {
    log('Audio VISIBILITY');
    if (!widget.scrollController.position.maxScrollExtent.isFinite) {
      return false;
    }

    final double itemExtent =
        widget.scrollController.position.maxScrollExtent / 50;
    final double itemOffset = widget.index * itemExtent;
    final double itemEnd = itemOffset + itemExtent;

    final double containerStart = widget.scrollController.offset;
    final double containerEnd =
        containerStart + widget.scrollController.position.viewportDimension;

    return !(itemEnd < containerStart || itemOffset > containerEnd);
  }

  @override
  void initState() {
    super.initState();

    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        setState(() {
          isPlaying = false;
        });
      }
    });

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _progress = duration.inSeconds.toDouble();
      });
    });

    _audioPlayer.getDuration().then((value) {
      maxDuration = value?.inMicroseconds.toDouble() ?? 0;
    });
    // _audioPlayer.play(UrlSource(widget.fileUrl));
    widget.scrollController.addListener(_checkIfWidgetIsVisible);
  }

  Future<void> _playPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(UrlSource(widget.fileUrl));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Lottie.asset(BookImages.voiceNote, animate: isPlaying),
        ),
        Align(
          alignment: Alignment.center,
          child: IconButton(
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.grey,
            ),
            iconSize: 30,
            onPressed: _playPause,
          ),
        ),
      ],
    );
  }
}

class VisibleListItem extends StatefulWidget {
  final int index;
  final ScrollController scrollController;

  VisibleListItem({required this.index, required this.scrollController});

  @override
  _VisibleListItemState createState() => _VisibleListItemState();
}

class _VisibleListItemState extends State<VisibleListItem> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_checkIfWidgetIsVisible);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_checkIfWidgetIsVisible);
    super.dispose();
  }

  void _checkIfWidgetIsVisible() {
    if (_isListItemVisible()) {
      if (!_isVisible) {
        setState(() {
          _isVisible = true;
          // Notify that the widget is now visible
          print('Item ${widget.index} is now visible!');
        });
      }
    } else {
      if (_isVisible) {
        setState(() {
          _isVisible = false;
          // Notify that the widget is now out of view
          print('Item ${widget.index} is now out of view!');
        });
      }
    }
  }

  bool _isListItemVisible() {
    if (!widget.scrollController.position.maxScrollExtent.isFinite) {
      return false;
    }

    final double itemExtent =
        widget.scrollController.position.maxScrollExtent / 50;
    final double itemOffset = widget.index * itemExtent;
    final double itemEnd = itemOffset + itemExtent;

    final double containerStart = widget.scrollController.offset;
    final double containerEnd =
        containerStart + widget.scrollController.position.viewportDimension;

    return !(itemEnd < containerStart || itemOffset > containerEnd);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Item ${widget.index}'),
      subtitle: _isVisible ? Text('Visible') : Text('Not Visible'),
    );
  }
}
