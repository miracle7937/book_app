import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data_layer/models/home_response_model.dart';

import '../../utils/themes/theme_manager.dart';

class PopularWidget extends ConsumerWidget {
  final PopularModel? popularModel;
  const PopularWidget({Key? key, this.popularModel}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width * 0.9,
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
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: popularModel?.images ?? "",
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    popularModel?.title ?? "",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 14,
                        ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    popularModel?.author ?? "",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 10, color: Theme.of(context).disabledColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    popularModel?.description ?? "",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 10, color: Theme.of(context).disabledColor),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
