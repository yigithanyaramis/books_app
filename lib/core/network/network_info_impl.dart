import 'package:books_app/core/network/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl();

  @override
  Future<bool> get isConnected async => Connectivity()
      .checkConnectivity()
      .then((x) => !x.contains(ConnectivityResult.none));
}
