import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../data_layer/manager/manager.dart';
import '../color.dart';
import '../slide_up_panel.dart';
import 'music_controller.dart';

class PlayerScreen extends ConsumerWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    MusicController playerController = ref.watch(musicManager);
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: SlidingUpPanel(
          minHeight: 0,
          maxHeight: size.height,
          isDraggable: true,
          collapsed: Container(
            color: Theme.of(context).bottomSheetTheme.modalBarrierColor,
            // child: Column(
            //   children: [
            //     SizedBox(
            //       height: 65,
            //       child: Center(
            //           child: Icon(
            //         color: Theme.of(context).textTheme.titleMedium!.color,
            //         Icons.keyboard_arrow_up_rounded,
            //         size: 40,
            //       )),
            //     ),
            //   ],
            // )
          ),
          panelBuilder: (ScrollController sc, onReorderStart, onReorderEnd) {
            return Container();
          },
          body: Container(
            color: AppColor.mainColor,
            child: Stack(
              children: [
                SizedBox.expand(
                    child: CachedNetworkImage(
                  memCacheHeight: 200,
                  imageUrl: playerController.imageOFAudio ?? "",
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )),

                //Player Top content
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Spacer(),
                          Row(
                            children: [
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Swipe To View Player",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            iconSize: 12,
                            onPressed: () {
                              playerController.closePlayerModal();
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height < 750 ? 80 : 120,
                      ),
                      Expanded(child: Container()),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProgressBar(
                        baseBarColor:
                            Theme.of(context).sliderTheme.inactiveTrackColor,
                        bufferedBarColor:
                            Theme.of(context).sliderTheme.activeTrackColor,
                        progressBarColor:
                            Theme.of(context).sliderTheme.valueIndicatorColor,
                        thumbColor: Theme.of(context).sliderTheme.thumbColor,
                        timeLabelTextStyle: TextStyle(color: Colors.white),
                        progress: playerController.progressBarStatus.current,
                        total: Duration(minutes: 3, seconds: 05),
                        buffered: playerController.progressBarStatus.buffered,
                        onSeek: playerController.seek,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _previousButton(playerController, context),
                          CircleAvatar(radius: 35, child: _playButton()),
                          _nextButton(playerController, context),
                        ],
                      ),
                      SizedBox(
                        height: 90 + bottomPadding,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _playButton() {
    return Consumer(builder: (controller, ref, child) {
      MusicController controller = ref.watch(musicManager);
      final buttonState = controller.buttonState;
      if (buttonState == PlayButtonState.paused) {
        return IconButton(
          icon: const Icon(Icons.play_arrow_rounded),
          iconSize: 40.0,
          onPressed: controller.play,
        );
      } else if (buttonState == PlayButtonState.playing ||
          buttonState == PlayButtonState.loading) {
        return IconButton(
          icon: const Icon(Icons.pause_rounded),
          iconSize: 40.0,
          onPressed: controller.pause,
        );
      } else {
        return IconButton(
          icon: const Icon(Icons.play_arrow_rounded),
          iconSize: 40.0,
          onPressed: () {},
        );
      }
    });
  }

  Widget _previousButton(
      MusicController playerController, BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.skip_previous_rounded,
        color: Theme.of(context).textTheme.titleMedium!.color,
      ),
      iconSize: 30,
      onPressed: playerController.backward,
    );
  }
}

Widget _nextButton(MusicController playerController, BuildContext context) {
  return IconButton(
      icon: Icon(
        Icons.skip_next_rounded,
        color: Theme.of(context).textTheme.titleMedium!.color,
      ),
      iconSize: 30,
      onPressed: playerController.fastForward);
}
