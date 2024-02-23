import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Constance/constance.dart';
import '../../Constance/theme.dart';
import '../../Widget/rating_stars.dart';
import '../../data_layer/controller/home_controller.dart';
import '../../data_layer/manager/manager.dart';
import '../../data_layer/models/audio_player_model.dart';
import '../../data_layer/models/book_preview_data.dart';
import '../../home_screen/screen/pdf_reader_screen.dart';
import '../../utils/constant_string.dart';
import '../../utils/dialog/rating_modal.dart';
import '../../utils/dialog/snack_bars.dart';
import '../../utils/images.dart';
import '../../utils/list_helper.dart';
import '../../utils/scaffold/custom_scaffold.dart';
import '../../utils/string_helper.dart';
import '../../utils/themes/theme_manager.dart';
import '../11_best_review.dart';

class FromHellScreen extends ConsumerStatefulWidget {
  const FromHellScreen({super.key, this.bookID});
  final int? bookID;

  @override
  ConsumerState<FromHellScreen> createState() => _FromHellScreenState();
}

class _FromHellScreenState extends ConsumerState<FromHellScreen>
    implements PreviewCallBack {
  HomeController? homeController;

  bool initiate = true;

  @override
  void dispose() {
    super.dispose();
    initiate = true;
  }

  @override
  Widget build(BuildContext context) {
    homeController = ref.watch(homeControllerManager)?..setViewPreview(this);
    if (initiate) {
      homeController
          ?.getViewBook(widget.bookID == null ? "1" : widget.bookID.toString());
      initiate = false;
    }

    return CustomScaffold(
      pageState: homeController?.pageState,
      body: Padding(
        padding: EdgeInsets.only(
            left: 18,
            right: 18,
            top: MediaQuery.of(context).padding.top + 16,
            bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    ConstanceData.sv1,
                    height: 15,
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
                  CachedNetworkImage(
                    height: 200,
                    imageUrl: homeController
                            ?.bookPreviewData?.data?.book?.first.image ??
                        "",
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Text(
                          homeController
                                  ?.bookPreviewData?.data?.book?.first.title ??
                              "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.9,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        homeController
                                ?.bookPreviewData?.data?.book?.first.author ??
                            "",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 14, color: HexColor("#4D7EFF")),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () =>
                        showRatingBookModal(context, (comment, rating) {
                      homeController?.rateBook(widget.bookID,
                          rating: rating, comment: comment);
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 246, 246, 246),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: RatingStar(
                            initialRating: homeController?.bookPreviewData?.data
                                    ?.book?.first.rating ??
                                0,
                            iconSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(BookImages.readBook),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          homeController
                                  ?.bookPreviewData?.data?.book?.first.reads
                                  .toString() ??
                              "",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 14, color: HexColor("#4D7EFF")),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    homeController
                            ?.bookPreviewData?.data?.book?.first.description ??
                        "",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 12, color: Theme.of(context).disabledColor),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              homeController?.readBook(homeController
                                  ?.bookPreviewData?.data?.book?.first.id);
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    BookImages.readerIcon,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Read Now",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              homeController?.addFavoriteBook(homeController
                                  ?.bookPreviewData?.data?.book?.first.id);
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: ref.watch(themeController).isLight
                                        ? Color.fromARGB(255, 231, 231, 231)
                                        : Colors.transparent,
                                    blurRadius: 6.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(0.0, 0.0),
                                  )
                                ],
                                color: Theme.of(context).cardColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ConstanceData.s29,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Add to favourite",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 14,
                                        ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  isNotEmpty(homeController
                          ?.bookPreviewData?.data?.book?.first.audio)
                      ? InkWell(
                          onTap: () {
                            homeController?.playAudioBook(homeController
                                ?.bookPreviewData?.data?.book?.first.id);
                          },
                          // onTap: () => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (_) => AudioPlayerScreen(
                          //               book: homeController?.bookPreviewData
                          //                   ?.data?.book?.first,
                          //             ))),
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: ref.watch(themeController).isLight
                                      ? Color.fromARGB(255, 231, 231, 231)
                                      : Colors.transparent,
                                  blurRadius: 6.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(0.0, 0.0),
                                )
                              ],
                              color: Colors.orange,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  BookImages.audioPlayer,
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Play Audio",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: 14, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )
                      : Column(),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Best review",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BestReviewScreen(
                                review: homeController
                                    ?.bookPreviewData?.data?.review,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "ALL",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 14, color: HexColor("#4D7EFF")),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Builder(builder: (context) {
                    List<Review>? review =
                        homeController?.bookPreviewData?.data?.review;
                    if (isListEmpty(review)) {
                      return Container();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: ref.watch(themeController).isLight
                                  ? Color.fromARGB(255, 231, 231, 231)
                                  : Colors.transparent,
                              blurRadius: 6.0,
                              spreadRadius: 2.0,
                              offset: Offset(0.0, 0.0),
                            )
                          ],
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CachedNetworkImage(
                                      height: 30,
                                      imageUrl:
                                          review?.first.userProfilePics ?? ""),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        review?.first.userName ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: 12,
                                            ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            ConstantString().getDateTime(
                                              review?.first.createdAt ?? "",
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .disabledColor),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Image.asset(
                                            ConstanceData.s27,
                                            height: 20,
                                          ),
                                          Text(
                                            "${review?.first.rating}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .disabledColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("${review?.first.comment}"),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "More by ${homeController?.bookPreviewData?.data?.book?.first.author}",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 230,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: (homeController
                                  ?.bookPreviewData?.data?.similarByAuthor ??
                              [])
                          .map((e) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => FromHellScreen(
                                        bookID: e.id,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          height: 160,
                                          imageUrl: e.images ?? "",
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          e.title ?? "",
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
                                      width: 15,
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  onError(String message) {
    errorSnack(context, message);
  }

  @override
  onSuccess(String message) {
    successSnack(context, message);
  }

  @override
  openPDF(String pdf) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PDFPreview(
                  pdf: pdf,
                )));
  }

  @override
  playAudio(AudioData? audioData) {
    print(audioData?.toJson());
    ref.watch(musicManager).openPlayerModal(audioData);
    Navigator.pop(context);
  }
}
