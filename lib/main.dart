import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:navid_app/data/datasources/remote/client.dart';
import 'package:navid_app/presentation/controllers/setting_controller.dart';
import 'package:navid_app/presentation/navigation/navid_app.dart';
import 'package:navid_app/presentation/pages/bindings/main_binding.dart';
import 'package:navid_app/utils/messages.dart';
import 'package:navid_app/utils/theme.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  bool isUS = true;
  @override
  Widget build(BuildContext context) {
    Client.init();
    GetStorage box = GetStorage();
    if(box.hasData('isUS'))
      isUS = box.read('isUS');
    return
      Obx(()=>GetMaterialApp(
        theme: Themes().light,
        darkTheme: Themes().dark,
        themeMode: Themes().theme,
        translations: Messages(),
        // locale: isUS?Locale('en','GB'):Locale('fa','IR'),
        // fallbackLocale: Locale('en', 'GB'),
        debugShowCheckedModeBanner: false,
        initialRoute: NavidAppRoutes.splashPage,
        getPages: NavidApp.pages,
        initialBinding: MainBinding(),

        // localizationsDelegates: GlobalMaterialLocalizations.delegates,
        // supportedLocales: [
        //   const Locale('en', 'UK'), // American English
        //  ],
        )
      );
  }
}