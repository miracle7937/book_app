import 'package:flutter/material.dart';


import '../../data_layer/models/home_response_model.dart';
import '../../utils/custom_cache_image.dart';
import '../../utils/images.dart';
import '../../utils/string_helper.dart';

class BookOfTheWeek extends StatelessWidget {
  final Latest? latest;

  final VoidCallback? onTap;
  const BookOfTheWeek({Key? key, this.latest, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCacheImage(
                  height: 160,
                  image: latest?.images ?? "",
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  latest?.title ?? "",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 14,
                      ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            isNotEmpty(latest?.audio)
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(BookImages.mic),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
