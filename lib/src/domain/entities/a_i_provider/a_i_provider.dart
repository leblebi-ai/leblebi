import 'package:zorphy_annotation/zorphy_annotation.dart';
import '../enums/index.dart';
import '../api_endpoints/api_endpoints.dart';

part 'a_i_provider.zorphy.dart';
part 'a_i_provider.g.dart';

/// AIProvider entity
@Zorphy(generateJson: true, generateCompareTo: true, generateFilter: true)
abstract class $AIProvider {
  AIProviderType get type;
  String get name;
  String get version;
  List<String> get supportedProtocols;
  String get authMechanism;
  $ApiEndpoints get endpoints;
}
