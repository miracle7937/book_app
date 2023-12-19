import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../utils/page_state.dart';
import '../models/search_book_response.dart';
import '../repository/home_repository.dart';

class SearchBookController extends ChangeNotifier {
  PageState pageState = PageState.loaded;
  SearchBookResponse? searchBookResponse;
  SearchBookResponse? searchBookResponseCategories;
  Timer? _debounceTimer;
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  Future<void> getBooksByCategory(String? category,
      {bool refresh = false}) async {
    if (category == null) {
      return;
    }
    pageState = PageState.loading;
    if (refresh) {
      notifyListeners();
    }
    HomeRepository.searchBookByCategories(category).then((value) {
      if (value.status == true) {
        print("Book fetched");
        searchBookResponseCategories = value;
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((onError) {
      log(onError);
      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  Future<void> _fetchData(String query) async {
    pageState = PageState.loading;
    notifyListeners();
    HomeRepository.searchBook(query).then((value) {
      if (value.status == true) {
        print("Book fetched");
        searchBookResponse = value;
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((onError) {
      log(onError);
      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    if (_debounceTimer != null && _debounceTimer!.isActive) {
      _debounceTimer!.cancel();
    }
    _debounceTimer = Timer(Duration(milliseconds: 700), () {
      _fetchData(query);
    });
  }
}
