import 'package:get/get.dart';
import 'package:grocery_app_2022/authentication/auth_toggle.dart';
import 'package:grocery_app_2022/pages/roles_toggle.dart';
import 'package:grocery_app_2022/screens/admin/upload_product_screen.dart';
import 'package:grocery_app_2022/screens/user/home_screen.dart';
import 'package:grocery_app_2022/screens/user/profile/help_support.dart';
import 'package:grocery_app_2022/screens/user/profile/settings.dart.dart';
import 'package:grocery_app_2022/screens/user/profile/user_details.dart';

appRoutes() => [
      GetPage(
        name: '/homeScreen',
        page: () => HomeScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/rolesToggle',
        page: () => RolesToggle(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/authToggle',
        page: () => AuthToggle(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/uploadProductScreen',
        page: () => UploadProductScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/settings',
        page: () => Settings(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/userDetails',
        page: () => UserDetails(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/helpSupport',
        page: () => HelpSupport(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}
