import 'package:zuraffa/zuraffa.dart';

import '../../entities/tool_configuration/tool_configuration.dart';
import '../../repositories/tool_configuration_repository.dart';

class GetToolConfigurationListUseCase
    extends
        UseCase<List<ToolConfiguration>, ListQueryParams<ToolConfiguration>> {
  GetToolConfigurationListUseCase(this._repository);

  final ToolConfigurationRepository _repository;

  @override
  Future<List<ToolConfiguration>> execute(
    ListQueryParams<ToolConfiguration> params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.getList(params);
  }
}
