import 'package:flutter/material.dart';
import 'package:note_taker/controllers/auth_screen_controller.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  static const routeName = "/auth";

  @override
  Widget build(BuildContext context) {
    var authC = Get.put(AuthUserController());

    return GetBuilder<AuthUserController>(
      init: authC,
      initState: (_) => authC.getUserToken(),
      builder: (controller) => const CircularProgressIndicator(),
    );
  }
}
