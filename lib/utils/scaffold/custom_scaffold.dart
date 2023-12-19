import 'package:flutter/material.dart';
import 'package:lovebook/utils/color.dart';
import 'package:lovebook/utils/page_state.dart';

class CustomScaffold extends StatelessWidget {
  final AppBar? appBar;
  final Widget body;
  final PageState? pageState;
  final Color? backgroundColor;
  const CustomScaffold(
      {Key? key,
      this.appBar,
      required this.body,
      this.pageState,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: Stack(
        children: [
          this.body,
          Visibility(
            visible: pageState == PageState.loading,
            child: Center(
              child: AbsorbPointer(
                absorbing: pageState == PageState.loading,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    color: Colors.grey.withOpacity(0.7),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColor.mainColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
