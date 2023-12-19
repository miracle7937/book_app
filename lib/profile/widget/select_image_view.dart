import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/images.dart';
import '../../utils/string_helper.dart';

class SelectImageView extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final File? file;
  const SelectImageView(
      {Key? key, required this.onTap, this.file, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.grey.withOpacity(0.1)),
            child: ClipOval(
              child: file == null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.height * 0.07,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: Image.asset(
                          BookImages.all_user,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.height * 0.07,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Image.file(
                        file!,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          isEmpty(title)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 0, left: 0),
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                    Text(title)
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

class ProfileImageView extends StatelessWidget {
  final String? imageURL;

  const ProfileImageView({Key? key, this.imageURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Colors.grey.withOpacity(0.1)),
      child: ClipOval(
        child: isEmpty(imageURL)
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.height * 0.07,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Image.asset(
                    BookImages.all_user,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : SizedBox(
                width: MediaQuery.of(context).size.height * 0.07,
                height: MediaQuery.of(context).size.height * 0.07,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: imageURL ?? '',
                ),
              ),
      ),
    );
  }
}

class SmallProfileImageView extends StatelessWidget {
  final String? imageURL;

  const SmallProfileImageView({Key? key, this.imageURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Colors.grey.withOpacity(0.1)),
      child: ClipOval(
        child: isEmpty(imageURL)
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.height * 0.03,
                  height: MediaQuery.of(context).size.height * 0.03,
                  child: Image.asset(
                    BookImages.all_user,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : SizedBox(
                width: MediaQuery.of(context).size.height * 0.03,
                height: MediaQuery.of(context).size.height * 0.03,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: imageURL ?? '',
                ),
              ),
      ),
    );
  }
}
