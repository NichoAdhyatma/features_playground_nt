import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_taker/controllers/main_screen_controller.dart';

import '../controllers/tab_controller.dart';
import '../services/tracker_service.dart';

class BottomNavBar extends GetView<TabIndexController> {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mainC = Get.find<MainScreenController>();
    return BottomAppBar(
      elevation: 10,
      shape: const CircularNotchedRectangle(),
      clipBehavior: Clip.hardEdge,
      notchMargin: 5,
      child: GetX<TabIndexController>(
        init: Get.find<TabIndexController>(),
        builder: (TabIndexController controller) {
          return BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            currentIndex: controller.index.value,
            onTap: (value) {
              mainC.search.clear();
              if (value == 1) {
                (TrackerService()).track('view-user-profile');
              } else if (value == 0) {
                (TrackerService()).track('view-my-note');
              }
              controller.changeIndex(value);
            },
            iconSize: 30,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline_outlined,
                ),
                label: 'Akun',
              ),
            ],
          );
        },
      ),
    );
  }
}