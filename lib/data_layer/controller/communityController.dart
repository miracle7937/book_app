import 'package:flutter/cupertino.dart';
import 'package:lovebook/data_layer/models/generic_reponse.dart';

import '../../utils/page_state.dart';
import '../../utils/string_helper.dart';
import '../models/post_comment_model.dart';
import '../models/post_model_response.dart';
import '../repository/community_repository.dart';

class CommunityController extends ChangeNotifier {
  PageState pageState = PageState.loaded;
  int batchIndex = 1;
  int totalPageSize = 0;
  bool stopGetAllPost = false;

  List<AllPost> posts = [];
  List<AllPost> myPosts = [];

  late CommunityView communityView;

  PostCommentModel? postCommentModel;
  setView(v) {
    communityView = v;
  }

  refresh() {
    batchIndex = 1;
    totalPageSize = 0;
    posts.clear();
    pageState = PageState.loading;
    notifyListeners();
    CommunityRepository.getALLPost(batchIndex).then((value) {
      if (value.status == true && value.posts?.allPost != null) {
        posts.addAll(value.posts!.allPost!);
        totalPageSize = value.posts!.totalCount!;
        batchIndex =
            value.posts!.allPost!.isEmpty ? batchIndex : batchIndex + 1;
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((onError, i) {
      pageState = PageState.loaded;
      notifyListeners();
      print(onError.toString());
      print(i);
    });
  }

  getAllPost(int pageKey) {
    if (stopGetAllPost) {
      return;
    }

    CommunityRepository.getALLPost(pageKey).then((value) {
      if (value.status == true && value.posts?.allPost != null) {
        posts.addAll(value.posts!.allPost!);
        totalPageSize = value.posts!.totalCount!;
        batchIndex =
            value.posts!.allPost!.isEmpty ? batchIndex : batchIndex + 1;
      }
      notifyListeners();
    }).catchError((onError, i) {
      print(onError.toString());
      print(i);
    });
  }

  int myPostBatchIndex = 1;
  int myPostTotalPageSize = 0;
  getMyPost() {
    pageState = PageState.loading;
    CommunityRepository.getMyPost(myPostBatchIndex).then((value) {
      if (value.status == true && value.posts?.myPosts != null) {
        myPosts.addAll(value.posts!.myPosts!);

        myPostTotalPageSize = value.posts!.totalCount!;
        myPostBatchIndex =
            value.posts!.myPosts!.isEmpty ? batchIndex : batchIndex + 1;
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((onError, i) {
      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  refreshMyPost() {
    myPostBatchIndex = 1;
    myPostTotalPageSize = 0;
    myPosts.clear();
    pageState = PageState.loading;
    notifyListeners();
    CommunityRepository.getMyPost(myPostBatchIndex).then((value) {
      if (value.status == true && value.posts?.myPosts != null) {
        myPosts.addAll(value.posts!.myPosts!);

        myPostTotalPageSize = value.posts!.totalCount!;
        myPostBatchIndex =
            value.posts!.myPosts!.isEmpty ? batchIndex : batchIndex + 1;
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((onError, i) {
      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  Future postWithNoMedia(String message) async {
    pageState = PageState.loading;
    notifyListeners();
    CommunityRepository.postWithNoMedia(message).then((value) {
      if (value.status == true) {
        communityView.onSuccessful(value.message ?? "");
      } else {
        communityView.onError(value.message ?? "");
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((onError, i) {
      pageState = PageState.error;
    });
  }

  Future likePost(String id) async {
    pageState = PageState.loading;
    notifyListeners();
    CommunityRepository.likePost(id).then((value) {
      if (value.status == true) {
        communityView.onSuccessful(value.message ?? "");
      } else {
        communityView.onError(value.message ?? "");
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((onError, i) {
      pageState = PageState.error;
    });
  }

  Future disLikePost(String id) async {
    pageState = PageState.loading;
    notifyListeners();
    CommunityRepository.unLikePost(id).then((value) {
      if (value.status == true) {
        communityView.onSuccessful(value.message ?? "");
      } else {
        communityView.onError(value.message ?? "");
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((onError, i) {
      pageState = PageState.error;
    });
  }

  Future comment(String id, String message) async {
    pageState = PageState.loading;
    notifyListeners();

    try {
      GenericResponse value =
          await CommunityRepository.postComment(id, message);
      if (value.status == true) {
        print("Comment successful");
        communityView.onSuccessful(value.message ?? "");
      } else {
        communityView.onError(value.message ?? "");
      }
      pageState = PageState.loaded;
      notifyListeners();
    } catch (v, i) {
      pageState = PageState.loaded;
      notifyListeners();
    }
  }

  Future openPostComment(String? id) async {
    if (isEmpty(id)) {
      return;
    }
    pageState = PageState.loading;
    CommunityRepository.openPost(id).then((value) {
      if (value.status == true) {
        print('======================Success');
        postCommentModel = value;
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((onError, i) {
      print(i);
      print('======================Error');

      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  Future deletePost(String id) async {
    pageState = PageState.loading;
    notifyListeners();
    CommunityRepository.deletePost(id).then((value) {
      if (value.status == true) {
        communityView.onSuccessful(value.message ?? "");
      } else {
        communityView.onError(value.message ?? "");
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((onError, i) {
      pageState = PageState.error;
    });
  }
}

abstract class CommunityView {
  onSuccessful(String message);
  onError(String message);
}
