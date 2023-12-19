import 'package:flutter/material.dart';

import '../../data_layer/models/home_response_model.dart';

class CollectionWidget extends StatelessWidget {
  final Collection? collection;
  final String? image;
  const CollectionWidget({Key? key, this.collection, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          image!,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              collection?.title ?? "",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
