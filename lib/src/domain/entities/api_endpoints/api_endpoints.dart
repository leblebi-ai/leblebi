import 'package:zorphy_annotation/zorphy_annotation.dart';

part 'api_endpoints.zorphy.dart';
part 'api_endpoints.g.dart';

/// ApiEndpoints entity
@Zorphy(generateJson: true, generateCompareTo: true, generateFilter: true)
abstract class $ApiEndpoints {
  String get health;
  String get pair;
  String get webhook;
}
