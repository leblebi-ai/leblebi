import 'package:flutter/material.dart';
import '../../domain/entities/gateway_connection/gateway_connection.dart';
import '../../domain/usecases/connect_gateway_usecase.dart';

class SetupViewModel extends ChangeNotifier {
  SetupViewModel(this._connectGatewayUseCase);

  final ConnectGatewayUseCase _connectGatewayUseCase;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  GatewayConnection? _connection;
  GatewayConnection? get connection => _connection;

  Future<bool> connect(String url, String pairingCode) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final params = ConnectGatewayParams(url: url, pairingCode: pairingCode);
      // Use execute with params. UseCase execute takes params and cancelToken
      _connection = await _connectGatewayUseCase.execute(params, null);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('SetupViewModel: $e');
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
