import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_taker/controllers/main_screen_controller.dart';
import 'package:note_taker/controllers/note_controller.dart';
import 'package:note_taker/controllers/tab_controller.dart';
import '../constants/constant.dart';
import '../constants/theme.dart';
import '../screens/note/add_note_screen.dart';
import '../services/tracker_service.dart';

class FloatingButtonWidget extends GetView<TabIndexController> {
  const FloatingButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var tabC = Get.find<TabIndexController>();
    var mainC = Get.find<MainScreenController>();
    final noteC = Get.find<NoteController>();

    return Visibility(
      visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 5),
            shape: BoxShape.circle),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: primaryColor,
          onPressed: () async {
            (TrackerService()).track('add-note');
            tabC.focusNode.unfocus();
            Get.closeAllSnackbars();
            tabC.index.value = 0;
            var result = await Get.toNamed(AddNoteScreen.routeName);
            if (result != null && result) {
              showSnackBar("Sukses !", "Catatan tersimpan", "success");
            }

            mainC.clearSearch();
            noteC.fetchData();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
