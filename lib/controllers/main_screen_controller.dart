import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MainScreenController extends GetxController {
  DateTime selectDate = DateTime.now();
  bool isSelect = false;
  var search = TextEditingController();
  bool isSubmit = false;

  void clearSearch() {
    search.clear();
    update();
  }

  void synchronize() {
    update();
  }

  void setSelectData(DateTime value) {
      setIsSelect(true);
      selectDate = value;

      update();
  }

  void setIsSelect(bool value) {
    isSelect = value;
    update();
  }


}
