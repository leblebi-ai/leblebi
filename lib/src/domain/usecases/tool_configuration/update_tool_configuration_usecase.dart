import 'package:zuraffa/zuraffa.dart';

import '../../entities/tool_configuration/tool_configuration.dart';
import '../../repositories/tool_configuration_repository.dart';

class UpdateToolConfigurationUseCase
    extends
        UseCase<
          ToolConfiguration,
          UpdateParams<String, Partial<ToolConfiguration>>
        > {
  UpdateToolConfigurationUseCase(this._repository);

  final ToolConfigurationRepository _repository;

  @override
  Future<ToolConfiguration> execute(
    UpdateParams<String, Partial<ToolConfiguration>> params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.update(params);
  }
}
