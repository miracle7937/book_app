import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  const ShimmerWidget({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500]!,
      highlightColor: Colors.grey[300]!,
      enabled: true,
      direction: ShimmerDirection.ltr,
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width * 0.9,
        color: Colors.white,
      ),
    );
  }
}
