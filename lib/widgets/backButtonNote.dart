import 'package:flutter/material.dart';
import 'package:note_taker/controllers/add_note_controller.dart';
import '../constants/constant.dart';
import '../constants/theme.dart';
import 'package:get/get.dart';

class BackButtonNote extends StatelessWidget {
  const BackButtonNote({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNoteController>(
      builder: (addC) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: addC.isPress
            ? null
            : () {
                if (addC.isChanged()) {
                  Get.dialog(
                    AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      icon: const Icon(
                        Icons.edit_note_rounded,
                        size: 50,
                      ),
                      content: materialText("Ingin menyimpan perubahan ?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                            Get.back(result: false);
                          },
                          child: materialText(
                            "Buang",
                            style: labelTextStyle.copyWith(
                              color: primaryColor,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                            addC.addNoteService();
                          },
                          style: primaryButton,
                          child: materialText(
                            "Ya Simpan",
                            style: labelTextStyle.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  Get.back(result: false);
                }
              },
      ),
    );
  }
}
