import 'package:zuraffa/zuraffa.dart';

import '../../entities/tool_configuration/tool_configuration.dart';
import '../../repositories/tool_configuration_repository.dart';

class GetToolConfigurationUseCase
    extends UseCase<ToolConfiguration, QueryParams<ToolConfiguration>> {
  GetToolConfigurationUseCase(this._repository);

  final ToolConfigurationRepository _repository;

  @override
  Future<ToolConfiguration> execute(
    QueryParams<ToolConfiguration> params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.get(params);
  }
}
