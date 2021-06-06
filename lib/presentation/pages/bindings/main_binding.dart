import 'package:get/get.dart';
import 'package:navid_app/data/datasources/local/navid_app_local_data_source.dart';
import 'package:navid_app/data/datasources/remote/navid_app_remote_data_source.dart';
import 'package:navid_app/data/repository/navid_app_repository_impl.dart';
import 'package:navid_app/domain/repository/navid_app_repository.dart';
import 'package:navid_app/domain/usecases/init/get_status_use_case.dart';
import 'package:navid_app/domain/usecases/setting/get_font_size_use_case.dart';
import 'package:navid_app/domain/usecases/setting/get_mode_use_case.dart';
import 'package:navid_app/domain/usecases/setting/set_font_size_use_case.dart';
import 'package:navid_app/domain/usecases/setting/set_mode_use_case.dart';
import 'package:navid_app/domain/usecases/user/get_user_info_use_case.dart';
import 'package:navid_app/domain/usecases/user/login_use_case.dart';
import 'package:navid_app/domain/usecases/user/logout_use_case.dart';
import 'package:navid_app/presentation/controllers/main_controller.dart';
import 'package:navid_app/presentation/controllers/user_controller.dart';

class MainBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<NavidAppRemoteDataSource>(NavidAppRemoteDatasourceImpl());
    Get.put<NavidAppLocalDataSource>(NavidAppLocalDataSourceImpl());
    Get.put<NavidAppRepository>(NavidAppRepositoryImpl(
      localDataSource: Get.find(),
      remoteDataSource: Get.find()
    ));
    Get.lazyPut<GetUserInfoUseCase>(() => GetUserInfoUseCase(
        repository: Get.find()
    ));
    Get.put<GetFontSizeUseCase>(GetFontSizeUseCase(
        repository: Get.find()
    ));
    Get.put<SetFontSizeUseCase>(SetFontSizeUseCase(
        repository: Get.find()
    ));
    Get.put<GetModeUseCase>(GetModeUseCase(
        repository: Get.find()
    ));
    Get.put<SetModeUseCase>(SetModeUseCase(
        repository: Get.find()
    ));
    Get.put<GetStatusUseCase>(GetStatusUseCase(
      repository: Get.find()
    ));
    Get.put<LogOutUseCase>(LogOutUseCase(
        repository: Get.find()
    ));
    Get.put<MainController>(MainController());
  }


}