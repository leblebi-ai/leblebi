import 'package:get_it/get_it.dart';

import 'workspace_repository_di.dart';
import 'conversation_repository_di.dart';
import 'gateway_connection_repository_di.dart';
import 'tool_configuration_repository_di.dart';

void registerAllRepositories(GetIt getIt) {
  registerWorkspaceRepository(getIt);

  registerConversationRepository(getIt);

  registerGatewayConnectionRepository(getIt);

  registerToolConfigurationRepository(getIt);
}
