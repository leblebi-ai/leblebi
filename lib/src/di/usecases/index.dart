import 'package:get_it/get_it.dart';

import 'create_workspace_usecase_di.dart';
import 'delete_workspace_usecase_di.dart';
import 'get_workspace_list_usecase_di.dart';
import 'get_workspace_usecase_di.dart';
import 'update_workspace_usecase_di.dart';
import 'delete_conversation_usecase_di.dart';
import 'get_conversation_usecase_di.dart';
import 'get_conversation_list_usecase_di.dart';
import 'create_conversation_usecase_di.dart';
import 'create_gateway_connection_usecase_di.dart';
import 'delete_gateway_connection_usecase_di.dart';
import 'get_gateway_connection_usecase_di.dart';
import 'update_gateway_connection_usecase_di.dart';
import 'get_gateway_connection_list_usecase_di.dart';
import 'update_tool_configuration_usecase_di.dart';
import 'get_tool_configuration_list_usecase_di.dart';
import 'get_tool_configuration_usecase_di.dart';
import 'connect_gateway_usecase_di.dart';
import 'send_message_usecase_di.dart';
import 'get_message_list_usecase_di.dart';
import 'create_message_usecase_di.dart';

void registerAllUseCases(GetIt getIt) {
  registerGetWorkspaceListUseCase(getIt);
  registerGetWorkspaceUseCase(getIt);
  registerCreateWorkspaceUseCase(getIt);
  registerDeleteWorkspaceUseCase(getIt);
  registerUpdateWorkspaceUseCase(getIt);

  registerDeleteConversationUseCase(getIt);

  registerGetConversationUseCase(getIt);

  registerGetConversationListUseCase(getIt);

  registerCreateConversationUseCase(getIt);

  registerCreateGatewayConnectionUseCase(getIt);

  registerDeleteGatewayConnectionUseCase(getIt);

  registerGetGatewayConnectionUseCase(getIt);

  registerUpdateGatewayConnectionUseCase(getIt);

  registerGetGatewayConnectionListUseCase(getIt);

  registerUpdateToolConfigurationUseCase(getIt);

  registerGetToolConfigurationListUseCase(getIt);

  registerGetToolConfigurationUseCase(getIt);

  registerConnectGatewayUseCase(getIt);
  registerSendMessageUseCase(getIt);
  registerGetMessageListUseCase(getIt);
  registerCreateMessageUseCase(getIt);
}
