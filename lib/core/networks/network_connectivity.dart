abstract class NetworkConnectivity {
  Future<bool> get isConnected;
}

class NetworkConnectivityImpl implements NetworkConnectivity {
  NetworkConnectivityImpl();

  @override
  Future<bool> get isConnected => Future.value(true);
}
