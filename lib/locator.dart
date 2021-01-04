
import 'package:sac/services/api.dart';
import 'package:get_it/get_it.dart';
import 'package:sac/services/authservice.dart';
import 'package:sac/services/firestore_service.dart';
import 'package:sac/services/navigation_service.dart';
import 'package:sac/services/dialog_service.dart';

GetIt locator = GetIt();
void setupLocator() {
  /*locator.registerLazySingleton(() => Api('Users'));*/
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());

}