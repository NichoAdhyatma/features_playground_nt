import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note_taker/models/user_model.dart';
import 'package:note_taker/services/auth_service.dart';

import '../constants/api_auth.dart';
import '../constants/constant.dart';
import '../screens/auth/login_screen.dart';

class SettingAccountController extends GetxController {
  final name = TextEditingController();
  final email = TextEditingController();
  final focusNode = FocusNode();
  bool isFetch = true;
  bool isLoading = false;
  bool isPress = false;
  bool isChange = false;

  void setIsPress(bool val) {
    isPress = val;
    update();
  }

  void setIsChange() {
    isChange = isEdited();
    update();
  }

  void getUser() async {
    isChange = false;
    isFetch = true;
    var response = await AuthService().getUser();
    if (response.error == null) {
      User responseUser = response.data as User;
      name.text = responseUser.name!;
      email.text = responseUser.email!;
      isFetch = false;
      setIsChange();
      update();
    } else {
      showSnackBar("Pesan", response.error!, "error");
    }
  }

  bool isEdited() {
    if (name.text.trim() != authUser?.name?.trim() && name.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  void updateUser(TextEditingController name) {
    if (isEdited()) {
      setIsPress(true);
      (AuthService()).updateUser(name.text).then((response) {
        setIsChange();
        setIsPress(false);
        if (response.error == null) {
          showSnackBar("Sukses !", "Nama mu berhasil di ubah", "success");
        } else {
          showSnackBar("Pesan", response.error!, 'warning');
        }
      });
    } else if (name.text.isEmpty) {
      showSnackBar("Pesan", "Waduh namanya jangan dikosongin", "warning");
    } else {
      showSnackBar("Pesan", "Kamu tidak melakukan perubahan apapun", "warning");
    }
  }

  void logout() {
    isLoading = true;

    (AuthService()).logout();
    Future.delayed(const Duration(milliseconds: 1500))
        .then((_) => Get.offAllNamed(LoginScreen.routeName))
        .whenComplete(() => isLoading = false);

    update();
  }
}
