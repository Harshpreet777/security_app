import 'package:firebase_demo3/core/services/storage_service.dart';
import 'package:firebase_demo3/core/viewmodels/login_view_model.dart';
import 'package:firebase_demo3/core/viewmodels/sign_up_view_model.dart';
import 'package:firebase_demo3/core/viewmodels/update_profile_view_model.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
setUpLocator() {
  locator.registerLazySingleton(() => SignUpViewModel());
  locator.registerLazySingleton(() => UpdateProfileViewModel());
  locator.registerLazySingleton(() => StorageService());
  locator.registerLazySingleton(() => LoginViewModel());
}
