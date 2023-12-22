import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';


import '../../utils/local_storage_data.dart';
import '../../utils/page_state.dart';
import '../../utils/string_helper.dart';
import '../models/contact_us_model.dart';
import '../models/legal_terms_model.dart';
import '../models/user_response.dart';
import '../repository/profile_repository.dart';
import '../request.dart';

class ProfileController extends ChangeNotifier {
  PageState pageState = PageState.loading;
  File? fileImage;
  String? firstName, lastName;

  UserUpdateView? _view;
  ContactUseView? _contactUse;
  ManageCardView? _manageCardView;

  ContactUsModel? contactUsModel;
  LegalTermsModel? legalTermsModel;

  setView(v) {
    _view = v;
  }

  setContactUs(v) {
    _contactUse = v;
  }

  setManageView(v) {
    _manageCardView = v;
  }

  selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 40);
    if (image != null) {
      fileImage = File(image.path);
    }
    notifyListeners();
  }

  contactUs() {
    pageState = PageState.loading;
    RepoRepository.getContactUs().then((value) {
      if (value.status == true) {
        _contactUse?.onSuccess("");
        contactUsModel = value;
      } else {
        _contactUse?.onError("");
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v, i) {
      print(i);
      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  deleteCard(int? cardID) {
    if (cardID == null) {
      return;
    }
    pageState = PageState.loading;
    notifyListeners();
    RepoRepository.deleteCard(cardID.toString()).then((value) async {
      if (value.status == true) {
        UserResponse user = await RepoRepository.getUser();
        if (user.status == true) {
          LocalDataStorage.saveUserData(user.data);
          _manageCardView?.onSuccess(value.message ?? "");
        }
      } else {
        _manageCardView?.onError(value.message ?? "");
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v, i) {
      print(i);
      pageState = PageState.loaded;
      notifyListeners();
      _manageCardView?.onError(v.toString());
    });
  }

  getLegalTerms() {
    pageState = PageState.loading;
    RepoRepository.getLegalTerms().then((value) {
      if (value.status == true) {
        legalTermsModel = value;
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v, i) {
      print(i);
      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  updateUser() {
    if (fileImage == null) {
      _view?.onError("Please select image");
      return;
    }

    if (isEmpty(firstName) && isEmpty(lastName)) {
      {
        _view?.onError("Please fill the form");
        return;
      }
    }

    pageState = PageState.loading;
    RepoRepository.uploadUser({"first_name": firstName, "last_name": lastName},
        [FileKeyValue('photo', fileImage)]).then((value) {
      if (value.status == true) {
        _view?.onSuccess(value.message ?? "");
      } else {
        _view?.onError(value.message ?? "");
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v, i) {
      print(i);
      pageState = PageState.loaded;
      notifyListeners();
    });
  }
}

abstract class UserUpdateView {
  onSuccess(String message);
  onError(String error);
}

abstract class ContactUseView {
  onSuccess(String message);
  onError(String error);
}

abstract class ManageCardView {
  onSuccess(String message);
  onError(String error);
}
