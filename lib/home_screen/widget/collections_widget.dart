import 'package:flutter/material.dart';

import '../../data_layer/models/home_response_model.dart';

class CollectionWidget extends StatelessWidget {
  final Collection? collection;
  final String? image;
  const CollectionWidget({Key? key, this.collection, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Text(
            collection?.title ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.4,
      decoration:
          BoxDecoration(image: DecorationImage(image: AssetImage(image!))),
    );
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
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
