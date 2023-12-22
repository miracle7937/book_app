import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../Widget/buttons.dart';
import '../utils/images.dart';

class StatusScreen extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  const StatusScreen({Key? key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Lottie.asset(
                BookImages.successJson,
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),
            // const Spacer(),
            Text(
              title ?? "",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.black,
                  ),
            ),
            const SizedBox(
              height: 5,
            ),
            MyButton(
              btnName: "OK",
              click: onTap,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
