import 'package:get/get.dart';
import 'package:note_taker/screens/intro_screen/intro_screen.dart';
import 'package:note_taker/screens/layouts/home_page.dart';
import '../services/auth_service.dart';

class AuthUserController extends GetxController {
  var token = '';

  void getUserToken() async {
    token = await AuthService().getToken();

    token.isEmpty ? Get.offAllNamed(IntroScreen.routeName) : Get.offAllNamed(HomePage.routeName) ;

    update();
  }
}
