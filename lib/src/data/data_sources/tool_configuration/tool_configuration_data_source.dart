import 'package:zuraffa/zuraffa.dart';

import '../../../domain/entities/tool_configuration/tool_configuration.dart';

abstract class ToolConfigurationDataSource with Loggable, FailureHandler {
  Future<ToolConfiguration> get(QueryParams<ToolConfiguration> params);
  Future<List<ToolConfiguration>> getList(
    ListQueryParams<ToolConfiguration> params,
  );
  Future<ToolConfiguration> update(
    UpdateParams<String, Partial<ToolConfiguration>> params,
  );
}
