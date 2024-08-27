final class ServerException implements Exception {
  ServerException([this.message]);
  final String? message;

  @override
  String toString() {
    return message == null ? 'ServerException' : 'ServerException: $message';
  }
}

final class CacheException implements Exception {
  CacheException([this.message]);
  final String? message;

  @override
  String toString() {
    return message == null ? 'CacheException' : 'CacheException: $message';
  }
}
