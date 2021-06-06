import 'package:get/get.dart';
import 'package:navid_app/presentation/pages/bindings/change_password_binding.dart';
import 'package:navid_app/presentation/pages/bindings/contact_us_binding.dart';
import 'package:navid_app/presentation/pages/bindings/dahsboard_binding.dart';
import 'package:navid_app/presentation/pages/bindings/detail_order_binding.dart';
import 'package:navid_app/presentation/pages/bindings/eps_nomination_binding.dart';
import 'package:navid_app/presentation/pages/bindings/history_binding.dart';
import 'package:navid_app/presentation/pages/bindings/home_binding.dart';
import 'package:navid_app/presentation/pages/bindings/login_binding.dart';
import 'package:navid_app/presentation/pages/bindings/main_binding.dart';
import 'package:navid_app/presentation/pages/bindings/my_dependents_binding.dart';
import 'package:navid_app/presentation/pages/bindings/register_binding.dart';
import 'package:navid_app/presentation/pages/bindings/prescription_binding.dart';
import 'package:navid_app/presentation/pages/bindings/reset_password_binding.dart';
import 'package:navid_app/presentation/pages/bindings/setting_binding.dart';
import 'package:navid_app/presentation/pages/bindings/splash_binding.dart';
import 'package:navid_app/presentation/pages/change_password_page.dart';
import 'package:navid_app/presentation/pages/contact_us_page.dart';
import 'package:navid_app/presentation/pages/dashboard_page.dart';
import 'package:navid_app/presentation/pages/eps_nomination_page.dart';
import 'package:navid_app/presentation/pages/home_page.dart';
import 'package:navid_app/presentation/pages/login_page.dart';
import 'package:navid_app/presentation/pages/my_dependents_page.dart';
import 'package:navid_app/presentation/pages/detail_order_page.dart';
import 'package:navid_app/presentation/pages/register_page.dart';
import 'package:navid_app/presentation/pages/history_page.dart';
import 'package:navid_app/presentation/pages/prescription_page.dart';
import 'package:navid_app/presentation/pages/reset_password_page.dart';
import 'package:navid_app/presentation/pages/settings_page.dart';
import 'package:navid_app/presentation/pages/splash_page.dart';

class NavidAppRoutes{
  static final String splashPage = "/splashPage";
  static final String registerPage = "/registerPage";
  static final String loginPage = "/loginPage";
  static final String settingPage = "/settingPage";
  static final String homePage = "/homePage";
  static final String dashboardPage = "/dashboardPage";
  static final String epsNominationPage = "/epsNominationPage";
  static final String prescriptionPage = "/prescriptionPage";
  static final String myDependentsPage = "/myDependentsPage";
  static final String changePassword = "/changePassword";
  static final String historyPage = "/historyPage";
  static final String addDependentPage = "/addDependentPage";
  static final String detailOrderPage = "/detailOrderPage";
  static final String resetPasswordPage = "/resetPasswordPage";
  static final String contactUsPage = "/contactUsPage";
}

class NavidApp{
  static final pages = [
    GetPage(name: NavidAppRoutes.loginPage, page: ()=> LoginPage(),bindings: [MainBinding(),LoginBinding()]),
    GetPage(name: NavidAppRoutes.splashPage, page: ()=> SplashPage(),bindings: [MainBinding(),SplashBinding()]),
    GetPage(name: NavidAppRoutes.homePage, page: ()=> HomePage(),bindings: [MainBinding(),HomeBinding(),DashboardBinding()]),
    GetPage(name: NavidAppRoutes.registerPage, page: ()=> RegisterPage(),bindings: [MainBinding(),RegisterBinding()]),
    GetPage(name: NavidAppRoutes.epsNominationPage, page: ()=> EpsNominationPage(),bindings: [MainBinding(),EpsNominationBinding()]),
    GetPage(name: NavidAppRoutes.dashboardPage, page: ()=> DashBoardPage(),bindings: [MainBinding(),DashboardBinding()]),
    GetPage(name: NavidAppRoutes.prescriptionPage, page: ()=> PrescriptionPage(),bindings: [MainBinding(),PrescriptionBinding()]),
    GetPage(name: NavidAppRoutes.historyPage, page: ()=> HistoryPage(),bindings: [MainBinding(),HistoryBinding()]),
    GetPage(name: NavidAppRoutes.myDependentsPage, page: ()=> MyDependentsPage(),bindings: [MainBinding(),MyDependentsBinding()]),
    GetPage(name: NavidAppRoutes.detailOrderPage, page: ()=> DetailOrderPage(),bindings: [MainBinding(),DetailOrderBinding()]),
    GetPage(name: NavidAppRoutes.settingPage, page: ()=> SettingsPage(),bindings:[MainBinding(),SettingBinding()]),
    GetPage(name: NavidAppRoutes.resetPasswordPage, page: ()=> ResetPasswordPage(),bindings:[MainBinding(),ResetPasswordBinding()]),
    GetPage(name: NavidAppRoutes.changePassword, page: ()=> ChangePasswordPage(),bindings: [MainBinding(),ChangePasswordBinding()]),
    GetPage(name: NavidAppRoutes.contactUsPage, page: ()=> ContactUsPage(),bindings: [MainBinding(),ContactUsBinding()]),
  ];
}