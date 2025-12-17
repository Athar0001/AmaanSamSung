import 'dart:io';


abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// It's a wrapper around the InternetConnectionChecker class that exposes a single method called
/// isConnected

class NetworkInfoImpl implements NetworkInfo {

  NetworkInfoImpl();

  @override
  // Future<bool> get isConnected =>
  // checkConnection();
  // _connectionChecker.hasConnection;
  Future<bool> get isConnected async => true;

  Future<bool> checkConnection() async {
    var previousConnection = false;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        previousConnection = true;
      } else {
        previousConnection = false;
      }
    } on SocketException catch (_) {
      previousConnection = false;
    }

    return previousConnection;
  }
}
