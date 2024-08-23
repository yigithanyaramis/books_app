import 'package:hive/hive.dart';

final class AppHive<T> {
  late Box<dynamic> _box;

  Future<void> init(String boxName) async {
    _box = await Hive.openBox<dynamic>(boxName);
  }

  Future<void> cacheData({
    required String key,
    required T value,
  }) async {
    await _box.put(key, value);
  }

  T? getData({required String key}) {
    final data = _box.get(key);
    if (data != null) {
      return data as T?;
    }
    return null;
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
