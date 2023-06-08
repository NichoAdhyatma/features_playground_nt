import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

import 'package:note_taker/controllers/tab_controller.dart';
import 'package:note_taker/screens/profile/setting_account.dart';
import 'package:note_taker/widgets/app_bar.dart';
import 'package:note_taker/widgets/floating_action_widget.dart';
import '../../constants/theme.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../home/main_screen.dart';

import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = "/main";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var tabC = Get.find<TabIndexController>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.1),
        child: GetBuilder<TabIndexController>(
          init: Get.find<TabIndexController>(),
          builder: (controller) {
            return MyAppbar(title: controller.title);
          },
        ),
      ),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          duration: const Duration(seconds: 1),
          content: Text(
            "Tekan sekali lagi untuk keluar aplikasi",
            style: labelTextStyle.copyWith(color: Colors.white),
          ),
          backgroundColor: darkBlue,
        ),
        child: Obx(
          () => tabC.index.value == 0
              ? const MainScreen()
              : const SettingAccount(),
        ),
      ),
      floatingActionButton: const FloatingButtonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
