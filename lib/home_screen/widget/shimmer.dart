import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/color.dart';

class ShimmerView extends StatelessWidget {
  final double height;
  const ShimmerView({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.1),
        highlightColor: AppColor.mainColor,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
