// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../Constance/constance.dart';

class SerchPhotoScreen extends StatefulWidget {
  const SerchPhotoScreen({super.key});

  @override
  State<SerchPhotoScreen> createState() => _SerchPhotoScreenState();
}

class _SerchPhotoScreenState extends State<SerchPhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset(
                    ConstanceData.m40,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.contain,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            ConstanceData.m41,
                            height: 20,
                          ),
                        ),
                        Text(
                          "MY FINDINGS",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 14, color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 160),
                child: Text(
                  "Point your camera at the cover or barcodes",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
