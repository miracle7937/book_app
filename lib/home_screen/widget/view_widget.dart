import 'package:flutter/material.dart';
import 'package:lovebook/data_layer/models/home_response_model.dart';
import 'package:lovebook/utils/custom_cache_image.dart';

class ViewedWidget extends StatelessWidget {
  final Viewd viewd;
  const ViewedWidget({Key? key, required this.viewd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCacheImage(
            height: 160,
            image: viewd.images ?? "",
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            viewd.title ?? "",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 14,
                ),
          ),
        ],
      ),
    );
  }
}
