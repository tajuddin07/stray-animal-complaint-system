
import 'package:sac/services/api.dart';
import 'package:get_it/get_it.dart';
import 'package:sac/viewModel/CRUDModel.dart';
GetIt locator = GetIt();
void setupLocator() {
  locator.registerLazySingleton(() => Api('Users'));
  locator.registerLazySingleton(() => CRUDModel()) ;
}