import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constant.dart';
import '../models/user_model.dart';
import '../screens/layouts/home_page.dart';
import '../services/auth_service.dart';

class RegisterScreenController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final AuthService authService = AuthService();
  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isSecure = true;

  setIsSecure() {
    isSecure = !isSecure;
    update();
  }

  setIsLoading(bool val) {
    isLoading = val;
    update();
  }

  void register() async {
    nameFocus.unfocus();
    emailFocus.unfocus();
    passwordFocus.unfocus();

    if (formKey.currentState!.validate()) {
      setIsLoading(true);
      authService
          .register(name.text, email.text, password.text)
          .then((response) {
        if (response.error != null) {
          showSnackBar("Gagal masuk", response.error!, "error");
        } else {
          authService
              .setUserIdWithToken(response.data as User)
              .then((_) => Get.offAllNamed(HomePage.routeName));
        }
      }).whenComplete(() {
        setIsLoading(false);
      });
    }
  }
}
