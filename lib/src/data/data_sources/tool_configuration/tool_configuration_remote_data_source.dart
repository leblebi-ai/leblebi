import 'package:zuraffa/zuraffa.dart';

import '../../../domain/entities/tool_configuration/tool_configuration.dart';
import 'tool_configuration_data_source.dart';

class ToolConfigurationRemoteDataSource
    with Loggable, FailureHandler
    implements ToolConfigurationDataSource {
  @override
  Future<ToolConfiguration> get(QueryParams<ToolConfiguration> params) async {
    throw UnimplementedError('Implement remote get');
  }

  @override
  Future<List<ToolConfiguration>> getList(
    ListQueryParams<ToolConfiguration> params,
  ) async {
    throw UnimplementedError('Implement remote getList');
  }

  @override
  Future<ToolConfiguration> update(
    UpdateParams<String, Partial<ToolConfiguration>> params,
  ) async {
    throw UnimplementedError('Implement remote update');
  }
}
