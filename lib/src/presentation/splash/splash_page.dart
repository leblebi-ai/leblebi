import 'package:flutter/material.dart';
import 'package:zuraffa/zuraffa.dart';

import '../../di/service_locator.dart';
import '../../domain/usecases/gateway_connection/get_gateway_connection_list_usecase.dart';
import '../../domain/entities/gateway_connection/gateway_connection.dart';
import '../setup/setup_page.dart';
import '../chat/chat_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  Future<void> _checkConnection() async {
    // Wait a bit for splash effect
    await Future.delayed(const Duration(seconds: 1));

    try {
      final useCase = getIt<GetGatewayConnectionListUseCase>();
      final connections = await useCase.execute(
        ListQueryParams<GatewayConnection>(),
        null,
      );

      if (mounted) {
        if (connections.isNotEmpty) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const ChatPage()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const SetupPage()),
          );
        }
      }
    } catch (e) {
      // If error (e.g. Hive not ready or something), go to Setup
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const SetupPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
