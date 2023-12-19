import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../home_screen/widget/shimmer_widget.dart';

class CustomCacheImage extends StatelessWidget {
  final String image;
  final double height;

  const CustomCacheImage({Key? key, required this.image, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      imageUrl: image ?? "",
      placeholder: (context, url) => ShimmerWidget(
        height: height,
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
