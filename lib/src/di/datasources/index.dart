import 'package:get_it/get_it.dart';

import 'workspace_remote_data_source_di.dart';
import 'conversation_remote_data_source_di.dart';
import 'gateway_connection_remote_data_source_di.dart';
import 'tool_configuration_remote_data_source_di.dart';

void registerAllDataSources(GetIt getIt) {
  registerWorkspaceRemoteDataSource(getIt);

  registerConversationRemoteDataSource(getIt);

  registerGatewayConnectionRemoteDataSource(getIt);

  registerToolConfigurationRemoteDataSource(getIt);
}
