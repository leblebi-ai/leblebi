import 'package:get_it/get_it.dart';

import 'datasources/index.dart';
import 'repositories/index.dart';
import 'usecases/index.dart';

export 'datasources/index.dart';
export 'repositories/index.dart';
export 'usecases/index.dart';

void setupDependencies(GetIt getIt) {
  registerAllUseCases(getIt);
  registerAllDataSources(getIt);
  registerAllRepositories(getIt);
}
