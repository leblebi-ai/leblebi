import 'package:zuraffa/zuraffa.dart';

import '../../domain/entities/tool_configuration/tool_configuration.dart';
import '../../domain/repositories/tool_configuration_repository.dart';
import '../data_sources/tool_configuration/tool_configuration_data_source.dart';

class DataToolConfigurationRepository
    with Loggable, FailureHandler
    implements ToolConfigurationRepository {
  DataToolConfigurationRepository(this._dataSource);

  final ToolConfigurationDataSource _dataSource;

  @override
  Future<ToolConfiguration> get(QueryParams<ToolConfiguration> params) {
    return _dataSource.get(params);
  }

  @override
  Future<List<ToolConfiguration>> getList(
    ListQueryParams<ToolConfiguration> params,
  ) {
    return _dataSource.getList(params);
  }

  @override
  Future<ToolConfiguration> update(
    UpdateParams<String, Partial<ToolConfiguration>> params,
  ) {
    return _dataSource.update(params);
  }
}
