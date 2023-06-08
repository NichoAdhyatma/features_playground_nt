import 'package:get/get.dart';
import 'package:note_taker/controllers/main_screen_controller.dart';
import 'package:note_taker/controllers/note_controller.dart';
import 'package:note_taker/controllers/tab_controller.dart';

import '../controllers/setting_account_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TabIndexController());
    Get.lazyPut(() => SettingAccountController());
    Get.lazyPut(() => MainScreenController());
    Get.lazyPut(() => NoteController());
  }
}
