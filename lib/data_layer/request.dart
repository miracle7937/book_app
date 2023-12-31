import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/local_storage_data.dart';
import '../utils/navigation_service.dart';
import 'cache/cache_manager.dart';
import 'cache/cache_object.dart';

Future<Map<String, String>> getHeader() async {
  var token = await LocalDataStorage.getToken() ?? "";
  log("APP Token  $token");
  var header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
  return header;
}

const IS_PRODUCTION = kReleaseMode;

class ServerRequest {
  String? deviceId;

  void logToSlack(http.Response? response, {String? exception}) async {}

  Future<HttpResponse> getData({
    String? path,
  }) async {
    var header = await getHeader();
    var url = Uri.parse(path!);
    var response;
    try {
      response = await http.get(url, headers: header);
      var data = jsonDecode(response.body);
      log("$data  route: $path  status: ${response.statusCode}");

      if (response.statusCode == 401) {
        Navigator.of(NavigationService.navigatorKey.currentContext!)
            .pushNamedAndRemoveUntil(
          '/signInScreen',
          (route) => false,
        );
        //  return  TimeoutException('process time out');
        // return;
        throw HttpException({
          "message": data["message"] ?? 'Sessions expired',
        });
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return HttpData(data);
      } else {
        logToSlack(response);
        return HttpData(data);
      }
    } catch (e) {
      logToSlack(response, exception: e.toString());
      debugPrint('exception post ${e.toString()}');
      if (e is HttpException) {
        throw HttpException({"message": e.toString(), "error": true});
      }

      if (e is SocketException) {
        throw HttpException(
            {"message": 'No Internet connection', "error": true});
      }
      if (e is FormatException) {
        throw HttpException({"message": ' Bad response format', "error": true});
      }
      if (e is HandshakeException) {
        throw HttpException({"message": 'Handshake exception', "error": true});
      }
      if (e is TimeoutException) {
        throw HttpException(
            {"message": 'This process has been timed out', "error": true});
      }
      throw HttpException(
          {"message": 'Something wrong happened', "error": true});
    }
  }

  Future<HttpResponse> postData(
      {String? path, Map? body, List<Map>? bodyII, bool cache = false}) async {
    log("${path}    ${body.toString()}");

    var header = await getHeader();
    CacheManager cacheManager = CacheManager.getInstance();
    CacheObject? cacheObject = cacheManager.checkIfCached(path!, header);
    print(
        "${cacheManager.map["https://sidecampus.bplux.store/api/view-book"]} ================");
    var response;
    try {
      var url = Uri.parse(path);
      if (cache == true && cacheManager.map[path] != null) {
        print(
            "=======================> LOCAL BODY <===============================");
        print("===================MIMI ${cacheObject?.cachedResponse}");
        return HttpData(cacheObject?.cachedResponse);
      } else {
        response = await http
            .post(
          url,
          body: json.encode(body ?? bodyII),
          headers: header,
        )
            .timeout(
          const Duration(seconds: 20),
          onTimeout: () {
            throw TimeoutException('process time out');
          },
        );
        print(
            "=======================> HTTP BODY <===============================");
      }

      var data = jsonDecode(response.body);
      log("${response.statusCode} status code");
      log("${response.body}");
      if (response.statusCode == 401) {
        // Navigator.of(NavigationService.navigatorKey.currentContext!)
        //     .pushNamedAndRemoveUntil(
        //   '/signInScreen',
        //   (route) => false,
        // );
        throw HttpException({
          "message": data["message"] ?? 'Sessions expired',
        });
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.headers['content-type'] == 'application/json' &&
            cache == true) {
          var now = new DateTime.now();
          var validUntil = now.add(new Duration(minutes: 30));
          CacheObject cacheObject = CacheObject(
              validUntil,
              json.decode(utf8.decode(response.bodyBytes)),
              header['Content-Type'],
              header['Authorization']);

          print(
              "=======================> ADDED BODY <===============================");
          cacheManager.addToMap(path, cacheObject);
        }

        return HttpData(data);
      } else {
        logToSlack(response, exception: null);
        return HttpException({
          "message": data["message"] ?? 'something wrong happened',
          "error": true
        });
      }
    } catch (e) {
      logToSlack(null, exception: e.toString());

      debugPrint('exception post ${e.toString()}');
      if (e is HttpException) {
        throw HttpException({"message": e.toString(), "error": true});
      }

      if (e is SocketException) {
        throw HttpException(
            {"message": 'No Internet connection', "error": true});
      }
      if (e is FormatException) {
        throw HttpException({"message": 'Bad response format', "error": true});
      }
      if (e is HandshakeException) {
        throw HttpException({"message": 'Handshake exception', "error": true});
      }
      if (e is TimeoutException) {
        throw HttpException(
            {"message": 'This process has been timed out', "error": true});
      }
      throw HttpException(
          {"message": 'Something wrong happened', "error": true});
    }
  }

  Future putData(BuildContext context,
      {String? path, Map? body, List<Map>? bodyII}) async {
    var header = await getHeader();
    log(path.toString());

    try {
      var url = Uri.parse(path!);

      var response = await http.put(url,
          body: json.encode(body ?? bodyII), headers: header);
      debugPrint(body.toString());

      var data = jsonDecode(response.body);

      // print("$data  route: $path");
      log(response.statusCode.toString());

      if (response.statusCode == 401) {
        Navigator.of(NavigationService.navigatorKey.currentContext!)
            .pushNamedAndRemoveUntil(
          '/signInScreen',
          (route) => false,
        );
        throw HttpException({
          "message": 'Sessions expired',
        });
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return HttpData(data);
      } else {
        return HttpData(data);
      }
    } catch (e) {
      return HttpException(
          {"message": 'something wrong happened', "error": true});
    }
  }

  Future uploadNoFile(
    BuildContext context, {
    String? path,
    Map? body,
  }) async {
    final header = await getHeader();
    var postUri = Uri.parse('$path');
    var request = http.MultipartRequest(
      "POST",
      postUri,
    );
    request.headers.addAll(header);

    body!.forEach((key, value) {
      // print('$key $value');
      request.fields['$key'] = value.toString();
    });

    var response = await request.send();

    var data = jsonDecode(await response.stream.bytesToString());

    debugPrint(response.toString());
    if (response.statusCode == 401) {}
    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint('successful');
      return HttpData(data["data"]);
      // return true;
    } else {
      debugPrint('fails');
      return HttpException(null);
    }
  }
  //

  Future uploadFile(
      {String? path, Map? body, List<FileKeyValue>? fileKeyValue}) async {
    final header = await getHeader();
    log("BODY: $body");
    log("File: $fileKeyValue");
    var postUri = Uri.parse('$path');
    log(postUri.path);
    var request = http.MultipartRequest(
      "POST",
      postUri,
    );
    if (fileKeyValue != null) {
      for (var value in fileKeyValue) {
        request.files.add(
            await http.MultipartFile.fromPath(value.key!, value.file!.path));
      }
    }

    request.headers.addAll(header);

    body!.forEach((key, value) {
      request.fields['$key'] = value.toString();
    });

    var response = await request.send();
    log("MIMI ${response.statusCode}");
    http.Response v = await http.Response.fromStream(response);
    var data = json.decode(v.body);
    log("MIMI2 $data");
    // var data = json.decode(await response.stream.bytesToString());
    // print("MIMI3 $data}");

    if (response.statusCode == 401) {
      Navigator.of(NavigationService.navigatorKey.currentContext!)
          .pushNamedAndRemoveUntil(
        '/signInScreen',
        (route) => false,
      );
      throw HttpException({"message": 'Sessions expired', "error": true});
    }
    log(data.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('successful');
      return HttpData(data);
      // return true;
    } else {
      log('fails');
      throw HttpException(data);
    }
  }

  Future<HttpResponse> deleteData(
    BuildContext context, {
    String? path,
  }) async {
    var header = await getHeader();

    try {
      var url = Uri.parse('$path');

      var response = await http.delete(url, headers: header);
      var data = jsonDecode(response.body);
      debugPrint("$data  route: $path");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return HttpData(data);
      } else {
        return HttpData(data);
      }
    } catch (e) {
      debugPrint('exception get $e');
      return HttpException('something wrong happened');
    }
  }
}

class FileKeyValue {
  final String? key;
  final File? file;
  FileKeyValue(this.key, this.file);
}

abstract class HttpResponse {
  dynamic data;
}

class HttpException extends HttpResponse {
  final data;

  HttpException(this.data);
  get getMessage => data["message"];

  @override
  toString() => data["message"];
}

class HttpData extends HttpResponse {
  final data;
  HttpData(this.data);
}
