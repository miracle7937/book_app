// ignore_for_file: prefer_const_constructors, deprecated_member_use, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lovebook/Constance/constance.dart';
import 'package:lovebook/utils/constant_string.dart';

import '../data_layer/models/book_preview_data.dart';
import '../profile/widget/select_image_view.dart';

class BestReviewScreen extends StatefulWidget {
  final List<Review>? review;
  const BestReviewScreen({super.key, this.review});

  @override
  State<BestReviewScreen> createState() => _BestReviewScreenState();
}

class _BestReviewScreenState extends State<BestReviewScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.review);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: 18,
            right: 18,
            top: MediaQuery.of(context).padding.top + 16,
            bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
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
                Text(
                  "Best review",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                      ),
                ),
                SizedBox()
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: widget.review?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    print(index);
                    return _reviewWidget(widget.review![index]);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _reviewWidget(Review review) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallProfileImageView(
                imageURL: review.userProfilePics ?? "",
              ),
              // CachedNetworkImage(
              //     height: 30, imageUrl: review.userProfilePics ?? ""),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.userName ?? "",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 16,
                        ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    review.comment ?? "",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16, color: Theme.of(context).disabledColor),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        ConstantString().getDateTime(review.createdAt),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 14,
                            color: Theme.of(context).disabledColor),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        ConstanceData.s27,
                        height: 20,
                      ),
                      Text(
                        "${review.rating}",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 14,
                            color: Theme.of(context).disabledColor),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
