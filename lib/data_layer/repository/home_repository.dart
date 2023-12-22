
import '../api_route/api_route.dart';
import '../models/audio_player_model.dart';
import '../models/book_preview_data.dart';
import '../models/generic_reponse.dart';
import '../models/home_response_model.dart';
import '../models/read_book_model.dart';
import '../models/search_book_response.dart';
import '../models/subscribe_model.dart';
import '../request.dart';

class HomeRepository {
  static Future<HomeResponseModel> getHome() async {
    final service =
        await ServerRequest().postData(path: ApiRoute.home, body: {});
    return HomeResponseModel.fromJson(service.data);
  }

  static Future<BookPreviewData> readBook(String bookID) async {
    final service = await ServerRequest().postData(
        path: ApiRoute.view_book, body: {"book_id": bookID}, cache: false);
    return BookPreviewData.fromJson(service.data);
  }

  static Future<GenericResponse> addFavoriteBook(String bookID) async {
    final service = await ServerRequest().postData(
        path: ApiRoute.addFavorite, body: {"book_id": bookID}, cache: false);
    return GenericResponse.fromJson(service.data);
  }

  static Future<ReadBookModel> readPDFBook(String bookID) async {
    final service = await ServerRequest().postData(
        path: ApiRoute.readBook, body: {"book_id": bookID}, cache: false);
    return ReadBookModel.fromJson(service.data);
  }

  static Future<AudioModelResponse> playAudioBook(String bookID) async {
    final service = await ServerRequest().postData(
        path: ApiRoute.playAudio, body: {"book_id": bookID}, cache: false);
    return AudioModelResponse.fromJson(service.data);
  }

  static Future<SearchBookResponse> searchBook(String query) async {
    final service = await ServerRequest()
        .postData(path: ApiRoute.searchBook, body: {"keyword": query});
    return SearchBookResponse.fromJson(service.data);
  }

  static Future<SearchBookResponse> searchBookByCategories(
      String category) async {
    final service = await ServerRequest().postData(
      path: ApiRoute.getByCategory,
      body: {"category": category},
    );
    return SearchBookResponse.fromJson(service.data);
  }

  static Future<GenericResponse> rateBook(Map data) async {
    final service = await ServerRequest()
        .postData(path: ApiRoute.addRating, body: data, cache: false);
    return GenericResponse.fromJson(service.data);
  }

  static Future<SubscribeModel> subscribe(String data) async {
    final service = await ServerRequest().postData(
        path: ApiRoute.subscribe, body: {"vendor": data}, cache: false);
    return SubscribeModel.fromJson(service.data);
  }

  static Future<SubscribeModel> paysSubscriptionWithSaveCard(Map data) async {
    final service = await ServerRequest().postData(
        path: ApiRoute.subscribe_savedCards, body: data, cache: false);
    return SubscribeModel.fromJson(service.data);
  }
}
