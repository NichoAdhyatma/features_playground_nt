import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TabIndexController extends GetxController {
  var index = 0.obs;
  String title = "Catatan Saya";
  FocusNode focusNode = FocusNode();

  void changeIndex(int val) {
    index.value = val;
    title = val == 0 ? 'Catatan Saya' : 'Pengaturan Akun';
    update();
  }
}