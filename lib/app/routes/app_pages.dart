import 'package:get/get.dart';

import 'package:twitter_clone/app/modules/Index/bindings/index_binding.dart';
import 'package:twitter_clone/app/modules/Index/views/index_view.dart';
import 'package:twitter_clone/app/modules/Login/bindings/login_binding.dart';
import 'package:twitter_clone/app/modules/Login/views/login_view.dart';
import 'package:twitter_clone/app/modules/Signup/bindings/signup_binding.dart';
import 'package:twitter_clone/app/modules/Signup/views/signup_view.dart';
import 'package:twitter_clone/app/modules/home/bindings/home_binding.dart';
import 'package:twitter_clone/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INDEX;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.INDEX,
      page: () => IndexView(),
      binding: IndexBinding(),
    ),
  ];
}
