import 'package:flutter/cupertino.dart';

import '../../utils/page_state.dart';
import '../repository/home_repository.dart';

class SubscribeController extends ChangeNotifier {
  PageState pageState = PageState.loaded;
  late SubscribeView _view;
  setView(v) {
    _view = v;
  }

  getSubscribe(String vendor) {
    pageState = PageState.loading;
    notifyListeners();
    HomeRepository.subscribe(vendor).then((value) {
      if (value.status == true) {
        _view.onLaunchWebView(value.data ?? "");
      } else {
        _view.onError("payment process failed");
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((onError) {
      pageState = PageState.loaded;
      notifyListeners();
      _view.onError(onError.toString());
    });
  }

  payWithSavedCard(String amount, String? customer_id) {
    pageState = PageState.loading;
    notifyListeners();
    HomeRepository.paysSubscriptionWithSaveCard({
      "customer_id": customer_id,
      "amount": amount // or pass "stripe"
    }).then((value) {
      if (value.status == true) {
        _view.onSuccess(value.data ?? "");
      } else {
        _view.onError("payment process failed");
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((onError) {
      pageState = PageState.loaded;
      notifyListeners();
      _view.onError(onError.toString());
    });
  }
}

abstract class SubscribeView {
  void onLaunchWebView(String message);
  void onError(String message);
  void onSuccess(String message);
}
