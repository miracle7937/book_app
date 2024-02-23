import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../data_layer/controller/subscribe_controller.dart';
import '../../data_layer/manager/manager.dart';
import '../../data_layer/models/user_response.dart';
import '../../data_layer/repository/home_repository.dart';
import '../../utils/color.dart';
import '../../utils/dialog/snack_bars.dart';
import '../../utils/images.dart';
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
  List<ProductDetails> _products = [];
  bool _isAvailable = false;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  @override
  void initState() {
    getUserCard();
    super.initState();

    if (Platform.isIOS) {
      //in app purchase
      final Stream<List<PurchaseDetails>> purchaseUpdates =
          InAppPurchase.instance.purchaseStream;
      _subscription =
          purchaseUpdates.listen((List<PurchaseDetails> purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      }, onError: (error) {
        Fluttertoast.showToast(msg: 'Payment error:$error');
      }, onDone: () {
        Fluttertoast.showToast(msg: 'Payment completed');
      });
      _initStore();
    }
  }

  Future<void> _initStore() async {
    final bool isAvailable = await InAppPurchase.instance.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
      });
      return;
    }
    const Set<String> _kProductIds = {'02'};
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(_kProductIds);
    if (response.notFoundIDs.isNotEmpty) {
      errorSnack(context, "Product can't be found");
    }
    final purchaseParam =
        PurchaseParam(productDetails: response.productDetails.first);
    await InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
    setState(() {
      _products = response.productDetails;
      _isAvailable = isAvailable;
    });
  }

  void _buyProduct(ProductDetails productDetails) {
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);
    InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        Fluttertoast.showToast(msg: 'Payment successfully completed');
        await HomeRepository.checkTransactionSuccessful(
            {"email": userData?.email, "payid": "", "is_Stripe": false});
      }
      if (purchaseDetails.pendingCompletePurchase) {
        Fluttertoast.showToast(msg: 'Transaction Pending');
        await InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    });
  }

  getUserCard() async {
    userData = await LocalDataStorage.getUserData();
    setState(() {});
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
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
            InkWell(
                onTap: () {
                  if (Platform.isIOS) {
                    //in app purchase
                    _buyProduct(_products.first);
                    return;
                  }
                },
                child: premiumACCESSWidget()),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 10,
            ),
            if (Platform.isAndroid)
              Column(
                children: [
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
                          subTitle:
                              "Instantly subscribe your account with Paypal")),
                ],
              )
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
