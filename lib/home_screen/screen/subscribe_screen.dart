import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../Widget/linear_indicator.dart';
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
  bool isLoading = false;

  @override
  void initState() {
    getUserCard();
    super.initState();

    if (Platform.isIOS) {
      _initStore();
      //in app purchase
      final Stream<List<PurchaseDetails>> purchaseUpdates =
          InAppPurchase.instance.purchaseStream;
      _subscription =
          purchaseUpdates.listen((List<PurchaseDetails> purchaseDetailsList) {
        log("IM LIStening for product ${purchaseDetailsList.length}");
        _listenToPurchaseUpdated(purchaseDetailsList);
      }, onError: (error) {
        removeLoader();
        Fluttertoast.showToast(msg: 'Payment error:$error');
      }, onDone: () {
        removeLoader();
        Fluttertoast.showToast(msg: 'Payment completed');
      });
    }
  }

  removeLoader() {
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _initStore() async {
    if (Platform.isIOS) {
      await FlutterInappPurchase.instance.initialize();
      FlutterInappPurchase.instance.clearTransactionIOS();
    }
    final bool isAvailable = await InAppPurchase.instance.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
      });
      return;
    }
    UserData? userData = await LocalDataStorage.getUserData();
    Set<String> _kProductIds = {userData?.inAppIosPurchase?.first ?? ""};
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(_kProductIds);
    if (response.notFoundIDs.isNotEmpty) {
      errorSnack(context, "Product can't be found");
    }
    log("==================> product List ${response.productDetails}");
    setState(() {
      _products = response.productDetails;
      _isAvailable = isAvailable;
    });
  }

  void _buyProduct(ProductDetails productDetails) {
    setState(() {
      isLoading = true;
    });
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);
    InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.error) {
        print("Purchase Error: ${purchaseDetails.error}");
        print("Error Code: ${purchaseDetails.error?.code}");
        print("Error Message: ${purchaseDetails.error?.message}");
        removeLoader();
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: 'Error Purchase Status');
        return;
      }

      if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        Fluttertoast.showToast(msg: 'Payment successfully completed');
        removeLoader();
        await HomeRepository.checkTransactionSuccessful(
            {"email": userData?.email, "payid": "", "is_Stripe": false});
        Navigator.pop(context, true);
      }
      if (purchaseDetails.pendingCompletePurchase) {
        Fluttertoast.showToast(msg: 'Transaction Pending');
        removeLoader();
        await InAppPurchase.instance.completePurchase(purchaseDetails);
      }
      removeLoader();
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
      body: Column(
        children: [
          BookLinearProgressBar(
            isloading: isLoading,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      if (Platform.isIOS) {
                        _showDeleteConfirmationDialog(context, () {
                          _buyProduct(_products.first);
                          Navigator.pop(context);
                        });
                        //in app purchase

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
                            UserData? user =
                                await LocalDataStorage.getUserData();
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
                          onTap: () => ref
                              .watch(subscribeManager)
                              .getSubscribe("pay_pal"),
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
        ],
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

  void _showDeleteConfirmationDialog(BuildContext context, VoidCallback onTap) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Confirm'),
          content: Text('Are you sure you want to subscribe?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text('YES', style: TextStyle(color: AppColor.mainColor)),
              onPressed: onTap,
            ),
          ],
        );
      },
    );
  }
}
