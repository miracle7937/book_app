import 'package:flutter/cupertino.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void errorSnack(BuildContext context, String? message) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.error(
      message: message ?? " 🥹🥹🥹🥹 error",
    ),
  );
}

void successSnack(BuildContext context, String? message) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.success(
      message: "😊😊😊😊😊😊 $message " ?? "😊😊😊😊😊😊",
    ),
  );
}
