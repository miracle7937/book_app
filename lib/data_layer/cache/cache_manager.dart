import 'dart:developer';

import 'cache_object.dart';

class CacheManager {
  Duration? durationToSave;

  Map<String, CacheObject> map = new Map();

  static CacheManager? _instance;

  static CacheManager getInstance() {
    if (_instance == null) {
      var newInstance = new CacheManager();
      _instance = newInstance;
    }
    return _instance!;
  }

  addToMap(String url, CacheObject cacheObject) {
    map.putIfAbsent(url, () => cacheObject);
    map.forEach((key, value) {
      log("Key =======${key}   Value ${value.cachedResponse}");
    });
  }

  CacheObject? checkIfCached(String url, Map<String, String?> headers) {
    if (map.containsKey(url)) {
      CacheObject object = map[url]!;
      var now = new DateTime.now();
      if (object.validUntil.isAfter(now)) {
        return object;
      } else {
        map.remove(url);
      }
    }
    return null;
  }

  invalidateCacheAndRestart() {
    //removes all the cachedItems
    map = new Map();
  }
}
