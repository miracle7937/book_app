import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../data_layer/repository/home_repository.dart';

class StripeService {
  Map<String, dynamic>? paymentIntent;

  Future inAppPurchase() async {}

  Future<void> stripeMakePayment(Function(bool) onRefresh,
      {required String email, required String amount}) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                billingDetails: BillingDetails(email: email),
                paymentIntentClientSecret: paymentIntent!['client_secret'],
                style: ThemeMode.light,
                merchantDisplayName: 'LoveBook'),
          )
          .then((value) {});

      displayPaymentSheet(onRefresh, email: email, payid: paymentIntent?["id"]);
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  displayPaymentSheet(Function(bool) onRefresh,
      {required String email, required String payid}) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      await HomeRepository.checkTransactionSuccessful(
          {"email": email, "payid": payid, "is_Stripe": true});
      Fluttertoast.showToast(msg: 'Payment successfully completed');

      onRefresh(true);
    } on Exception catch (e) {
      if (e is StripeException) {
        Fluttertoast.showToast(
            msg: 'Error from Stripe: ${e.error.localizedMessage}');
      } else {
        Fluttertoast.showToast(msg: 'Unforeseen error: ${e}');
      }
      onRefresh(false);
    }
  }

//create Payment
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['StripeSecretKey']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      log("============> ${response.body}");
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

//calculate Amount
  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }
}
