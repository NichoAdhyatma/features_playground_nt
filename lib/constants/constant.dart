import 'package:flutter/material.dart';
import 'package:note_taker/controllers/add_note_controller.dart';
import 'package:note_taker/controllers/edit_note_controller.dart';
import 'theme.dart';
import 'package:get/get.dart';

void showSnackBar(String title, String message, String type) {
  Get.closeAllSnackbars();

  if (type == 'success') {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green[600],
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 300),
      shouldIconPulse: true,
      colorText: Colors.white,
      icon: const Icon(
        Icons.done_rounded,
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(12),
    );
  } else if (type == 'warning') {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.yellow[600],
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 300),
      shouldIconPulse: true,
      colorText: darkBlue,
      icon: const Icon(
        Icons.warning,
        color: darkBlue,
      ),
      margin: const EdgeInsets.all(12),
    );
  } else if (type == 'error') {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red[500],
      animationDuration: const Duration(milliseconds: 300),
      colorText: Colors.white,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(12),
    );
  } else {
    Get.snackbar(
      title,
      message,
      barBlur: 0.0,
      backgroundColor: Colors.green,
      backgroundGradient:
          const LinearGradient(colors: [Color(0xFF3494E6), Color(0xFFEC6EAD)]),
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 300),
      shouldIconPulse: true,
      colorText: Colors.white,
      icon: const Icon(
        Icons.done_rounded,
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(12),
    );
  }
}

Future<bool> showExitPopup() async {
  final editScreenC = Get.find<EditNoteController>();

  return await Get.dialog(
        AlertDialog(
          icon: const Icon(
            Icons.exit_to_app_rounded,
            size: 40,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: materialText("Ingin Keluar halaman edit catatan?"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(result: false);
              },
              child: materialText("Tidak",
                  style: labelTextStyle.copyWith(
                    color: primaryColor,
                  )),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back(result: false);
                editScreenC.updateNoteService();
              },
              style: primaryButton,
              child: materialText(
                "Keluar",
                style: labelTextStyle.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ) ??
      false; //if showDialouge had returned null, then return false
}

Future<bool> showExitPopupAdd() async {
  final addC = Get.find<AddNoteController>();

  return await Get.dialog(
        AlertDialog(
          icon: const Icon(
            Icons.exit_to_app_rounded,
            size: 40,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: materialText("Ingin keluar halaman tambah catatan?"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(result: false);
              },
              child: materialText("Tidak",
                  style: labelTextStyle.copyWith(
                    color: primaryColor,
                  )),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back(result: false);
                addC.addNoteService();
              },
              style: primaryButton,
              child: materialText(
                "Keluar",
                style: labelTextStyle.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ) ??
      false; //if showDialouge had returned null, then return false
}

String unauthorized = 'Belum terautentikasi';
String serverError = 'Server error';
String somethingWrong = 'Something wrong';

Widget materialText(String text,
    {TextStyle? style, TextOverflow? overflow, int? maxLines}) {
  return Text(
    text,
    style: style,
    overflow: overflow,
    maxLines: maxLines,
  );
}
