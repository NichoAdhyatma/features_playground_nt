import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_taker/services/auth_service.dart';

import '../constants/constant.dart';
import '../models/user_model.dart';
import '../screens/layouts/home_page.dart';

class LoginScreenController extends GetxController {
  var authService = AuthService();
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  bool isSecure = true;
  bool isLoading = false;

  setIsSecure() {
    isSecure = !isSecure;
    update();
  }

  setIsLoading(bool val) {
    isLoading = val;
    update();
  }

  void login() async {
    if (formKey.currentState!.validate()) {
     setIsLoading(true);
      authService.login(email.text, password.text).then((response) {
        if (response.error != null) {
          showSnackBar("Gagal masuk", response.error!, "error");
        } else {
          authService
              .setUserIdWithToken(response.data as User)
              .whenComplete(() => Get.offAllNamed(HomePage.routeName));
        }
      }).whenComplete(() {
        setIsLoading(false);
      });
    }
  }
}
