// video_upload_state.dart

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';


import '../../utils/local_storage_data.dart';
import '../../utils/string_helper.dart';
import '../api_route/api_route.dart';
import '../models/generic_reponse.dart';

class VideoUploadNotifier extends ChangeNotifier {
  double state = 0.0;
  OnVideoUpload? _onVideoUpload;
  setVideoView(c) {
    _onVideoUpload = c;
  }

  Future<void> uploadVideo(String? videoPath, String message) async {
    try {
      log("Request===============>");
      var token = await LocalDataStorage.getToken() ?? "";
      final dio = Dio();
      final formData = <String, dynamic>{
        // 'file': await MultipartFile.fromFile(videoPath!, filename: 'video.mp4'),
        'message': message,
      };

      if (isNotEmpty(videoPath)) {
        formData["file"] =
            await MultipartFile.fromFile(videoPath!, filename: 'video.mp4');
      }

      final response = await dio.post(ApiRoute.postContent,
          data: FormData.fromMap(formData),
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'multipart/form-data',
            },
          ), onSendProgress: (sent, total) {
        state = sent / total;
        notifyListeners();
        print(sent);
      });
      GenericResponse genericResponse = GenericResponse.fromJson(response.data);

      if (genericResponse.status == true) {
        _onVideoUpload?.onSuccessful(genericResponse.message ?? "");
      } else {
        _onVideoUpload?.onError(genericResponse.message ?? "");
      }
      print(response.data);

      state = 0.0;
    } catch (i, c) {
      _onVideoUpload?.onError(i.toString() ?? "");
    }
  }
}

abstract class OnVideoUpload {
  onSuccessful(String message);
  onError(String message);
}
