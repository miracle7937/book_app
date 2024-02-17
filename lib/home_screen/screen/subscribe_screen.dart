import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data_layer/controller/subscribe_controller.dart';
import '../../data_layer/manager/manager.dart';
import '../../data_layer/models/user_response.dart';
import '../../utils/color.dart';
import '../../utils/dialog/snack_bars.dart';
import '../../utils/images.dart';
import '../../utils/list_helper.dart';
import '../../utils/local_storage_data.dart';
import '../../utils/scaffold/custom_scaffold.dart';
import '../../utils/stripe_payment.dart';
import 'web_view_payment_screen.dart';

class SubscribeScreen extends ConsumerStatefulWidget {
  const SubscribeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends ConsumerState<SubscribeScreen>
    implements SubscribeView {
  UserData? userData;
  @override
  void initState() {
    getUserCard();
    super.initState();
  }

  getUserCard() async {
    userData = await LocalDataStorage.getUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(subscribeManager)..setView(this);
    return CustomScaffold(
      pageState: ref.watch(subscribeManager).pageState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            premiumACCESSWidget(),
            SizedBox(
              height: 20,
            ),
            !isListEmpty(userData?.savedCard)
                ? SizedBox(
                    height: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pay with saved Cards"),
                        Expanded(
                          child: ListView.builder(
                            itemCount: userData?.savedCard?.length ?? 0,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: InkWell(
                                    onTap: () {
                                      print(userData
                                          ?.savedCard![index]!.customerId);
                                      ref
                                          .watch(subscribeManager)
                                          .payWithSavedCard(
                                              "25",
                                              userData?.savedCard![index]!
                                                  .customerId!);
                                    },
                                    child: savedWidget(
                                      image: BookImages.card_payment,
                                      title: userData?.savedCard![index]!.name,
                                      subTitle2:
                                          "EXP   -${userData?.savedCard![index]!.expMonth}/ ${userData?.savedCard![index]!.expYear}",
                                      subTitle:
                                          "**** **** **** ${userData?.savedCard![index]!.last4}",
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(),
            SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () async {
                  Plan? plans = await LocalDataStorage.getPlan();
                  UserData? user = await LocalDataStorage.getUserData();
                  StripeService().stripeMakePayment((value) {
                    Navigator.pop(context, value);
                  },
                      email: user?.email ?? "",
                      amount: double.parse(plans?.amount ?? "1.0")
                          .toInt()
                          .toString());
                },
                // onTap: () => ref.watch(subscribeManager).getSubscribe("stripe"),
                child: subscribeWidget(
                    image: BookImages.card_payment,
                    title: "Pay with Debit/Credit Card",
                    subTitle:
                        "Instantly subscribe your account with Debit or credit card")),
            SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () =>
                    ref.watch(subscribeManager).getSubscribe("pay_pal"),
                child: subscribeWidget(
                    image: BookImages.pay_pal,
                    title: "Paypal Payment",
                    subTitle: "Instantly subscribe your account with Paypal")),
          ],
        ),
      ),
    );
  }

  Widget savedWidget({
    String? title,
    String? subTitle,
    String? subTitle2,
    String? image,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.mainColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image!),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      subTitle ?? "",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                    ),
                  ),
                  Text(
                    subTitle2 ?? "",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                  ),
                ],
              ),
              Spacer(),
            ],
          )),
    );
  }

  Widget subscribeWidget({
    String? title,
    String? subTitle,
    String? image,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.mainColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image!),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    subTitle ?? "",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 10),
                  ),
                ],
              ),
              Spacer(),
            ],
          )),
    );
  }

  Widget premiumACCESSWidget() {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.mainColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(BookImages.premium_access),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Premium Access",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    "1 Month Subscription",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                  ),
                  Text(
                    "Full access to all features on Side Campus",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 10),
                  ),
                ],
              ),
              Spacer(),
              FutureBuilder<Plan?>(
                  future: LocalDataStorage.getPlan(),
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                        Text(
                          "\$${snapshot.data?.amount}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ],
                    );
                  }),
              SizedBox(
                width: 10,
              )
            ],
          )),
    );
  }

  @override
  void onError(String message) {
    errorSnack(context, message);
  }

  @override
  void onLaunchWebView(String url) async {
    bool? status = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => SubscriptionPage(
                  url: url,
                )));

    if (status == true) {
      Navigator.pop(context, true);
    }
  }

  @override
  void onSuccess(String message) {
    successSnack(context, message);
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pop(context);
    });
  }
}
