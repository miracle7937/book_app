import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:lovebook/utils/page_state.dart';

import '../models/audio_player_model.dart';
import '../models/book_preview_data.dart';
import '../models/home_response_model.dart';
import '../repository/home_repository.dart';

class HomeController extends ChangeNotifier {
  PageState pageState = PageState.loading;
  HomeView? _homeView;
  PreviewCallBack? _previewCallBack;
  HomeResponseModel? homeResponseModel;
  BookPreviewData? bookPreviewData;
  bool _isNotified = true;

  setViewPreview(v) {
    _previewCallBack = v;
  }

  setView(v) {
    _homeView = v;
  }

  init() {
    if (_isNotified == true) {
      log("==================================");
      getHomeData();
    }
    _isNotified = false;
  }

  getHomeData({bool refresh = false}) {
    pageState = PageState.loading;
    if (refresh) {
      notifyListeners();
    }
    HomeRepository.getHome().then((value) {
      homeResponseModel = value;
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v) {
      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  getViewBook(String bookID) {
    pageState = PageState.loading;
    HomeRepository.readBook(
      bookID,
    ).then((value) {
      bookPreviewData = value;
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v, i) {
      print(i);
      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  addFavoriteBook(int? bookID) {
    if (bookID == null) {
      return;
    }
    pageState = PageState.loading;
    notifyListeners();
    HomeRepository.addFavoriteBook(
      bookID.toString(),
    ).then((value) {
      if (value.status == true) {
        _previewCallBack?.onSuccess(value.message ?? "");
      } else {
        _previewCallBack?.onError(value.message ?? "");
        ;
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v, i) {
      pageState = PageState.loaded;
      notifyListeners();
      _previewCallBack?.onError(v.toString() ?? "");
    });
  }

  readBook(int? bookID) {
    if (bookID == null) {
      return;
    }
    pageState = PageState.loading;
    notifyListeners();
    HomeRepository.readPDFBook(
      bookID.toString(),
    ).then((value) {
      if (value.status == true) {
        _previewCallBack?.openPDF(value.data?.book?.first.pdf ?? "");
      } else {
        _previewCallBack?.onError("You can't read this book");
        ;
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v, i) {
      pageState = PageState.loaded;
      notifyListeners();
      _previewCallBack?.onError(v.toString() ?? "");
    });
  }

  playAudioBook(int? bookID) {
    if (bookID == null) {
      return;
    }
    pageState = PageState.loading;
    notifyListeners();
    HomeRepository.playAudioBook(
      bookID.toString(),
    ).then((value) {
      if (value.status == true) {
        _previewCallBack?.playAudio(value.data?.first);
      } else {
        _previewCallBack?.onError(
            "You can't play the audio book, if you have not subscribe please do");
        ;
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v, i) {
      pageState = PageState.loaded;
      notifyListeners();
      _previewCallBack?.onError(v.toString() ?? "");
    });
  }

  rateBook(int? bookID, {required int rating, required String comment}) {
    if (bookID == null) {
      return;
    }
    Map data = {"book_id": bookID, "rating": rating, "comment": comment};
    pageState = PageState.loading;
    notifyListeners();
    HomeRepository.rateBook(data).then((value) {
      if (value.status == true) {
        _previewCallBack?.onSuccess(value.message ?? "");
      } else {
        _previewCallBack?.onError(value.message ?? "");
        ;
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v, i) {
      pageState = PageState.loaded;
      notifyListeners();
      _previewCallBack?.onError(v.toString() ?? "");
    });
  }

  clear() {
    _isNotified = false;
  }
}

abstract class HomeView {
  onSuccess();
  onError();
}

abstract class PreviewCallBack {
  onSuccess(String message);
  onError(String message);
  openPDF(String message);
  playAudio(AudioData? audioData);
}
