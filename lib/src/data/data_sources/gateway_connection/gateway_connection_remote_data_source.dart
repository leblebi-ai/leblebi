import 'package:zuraffa/zuraffa.dart';

import '../remote/zeroclaw_rest_api.dart';

class GatewayConnectionRemoteDataSource with Loggable, FailureHandler {
  GatewayConnectionRemoteDataSource(this._api);

  final ZeroClawRestApi _api;

  Future<Map<String, dynamic>> pair(String url, String pairingCode) async {
    return _api.pair(url, pairingCode);
  }
}
