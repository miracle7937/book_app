class CacheObject {
  DateTime validUntil;
  dynamic cachedResponse;
  String? country;
  String? token;

  CacheObject(
    this.validUntil,
    this.cachedResponse,
    this.country,
    this.token,
  );
}
