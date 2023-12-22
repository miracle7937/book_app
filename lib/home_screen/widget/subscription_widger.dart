import 'package:flutter/material.dart';


import '../../data_layer/models/home_response_model.dart';
import '../../utils/color.dart';
import '../../utils/images.dart';

class SubscriptionWidget extends StatefulWidget {
  final MyPlan? myPlan;
  final VoidCallback? ontap;
  const SubscriptionWidget({Key? key, this.ontap, this.myPlan})
      : super(key: key);

  @override
  State<SubscriptionWidget> createState() => _SubscriptionWidgetState();
}

class _SubscriptionWidgetState extends State<SubscriptionWidget> {
  late DateTime subscribeAt;
  late DateTime expiresAt;
  double? percentageRemaining;
  @override
  void initState() {
    super.initState();
    print(widget.myPlan?.toJson());
    if (widget.myPlan != null) {
      init();
    }
  }

  double convertDateTime(double? intValue) {
    if (intValue == null) {
      return 0;
    } else if (intValue < 0 || intValue == 0) {
      return 0;
    } else {
      return intValue;
    }
  }

  init() {
    subscribeAt = DateTime.parse(widget.myPlan!.subscribeAt!);
    expiresAt = DateTime.parse(widget.myPlan!.expiresAt!);
    DateTime currentDate = DateTime.now();
    //
    int totalDays = expiresAt.difference(subscribeAt).inDays;
    int remainingDays = expiresAt.difference(currentDate).inDays;
    percentageRemaining = ((totalDays - remainingDays) / totalDays);

    print(subscribeAt.toString());
    print(expiresAt.toString());
    print(totalDays.toString());
    print(remainingDays.toString());
    print(percentageRemaining.toString());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.myPlan == null) {
      return subscribeWidget();
    }

    if (widget.myPlan?.status == 0) {
      return subscribeWidget();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(BookImages.subscriptionIcon),
              SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Premium Plan Running",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    LinearProgressIndicator(
                      color: Colors.lime,
                      value: convertDateTime(percentageRemaining),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.myPlan?.subscribeAt ?? "",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          widget.myPlan?.expiresAt ?? "",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Spacer(),
              Visibility(
                visible: widget.myPlan?.status != 1,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "My Subscription",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: AppColor.mainColor,
                      borderRadius: BorderRadius.circular(5)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget subscribeWidget() {
    return InkWell(
      onTap: widget.ontap,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(BookImages.subscriptionIcon),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Tap to subScribe",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            )),
      ),
    );
  }
}
