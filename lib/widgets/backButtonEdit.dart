import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/constant.dart';
import '../constants/theme.dart';
import '../controllers/edit_note_controller.dart';
import '../controllers/note_controller.dart';

class BackButtonEdit extends StatelessWidget {
  const BackButtonEdit({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final noteC = Get.find<NoteController>();

    return GetBuilder<EditNoteController>(
      builder: (editC) => IconButton(
        onPressed: editC.isPress
            ? null
            : () {
                if (noteC.isSaved == false) {
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
                            noteC.setIsSave(true);
                            Get.back();
                            Get.back(result: false);
                          },
                          child: materialText("Buang",
                              style: labelTextStyle.copyWith(
                                color: primaryColor,
                              )),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                            editC.updateNoteService();
                          },
                          style: primaryButton,
                          child: materialText("Ya Simpan",
                              style: labelTextStyle.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  );
                } else {
                  Get.back(result: false);
                }
              },
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }
}
