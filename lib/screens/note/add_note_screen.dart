import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:note_taker/constants/constant.dart';
import 'package:note_taker/controllers/add_note_controller.dart';
import 'package:note_taker/screens/note/text_editor.dart';
import 'package:get/get.dart';
import 'package:note_taker/widgets/backButtonNote.dart';

import '../../constants/theme.dart';
import '../../services/tracker_service.dart';

class AddNoteScreen extends GetView<AddNoteController> {
  const AddNoteScreen({Key? key}) : super(key: key);
  static const routeName = "/add-note";

  @override
  Widget build(BuildContext context) {
    final addC = Get.put(AddNoteController());

    return GetBuilder<AddNoteController>(
      initState: (_) => addC.quillOnChange(),
      builder: (addC) => Scaffold(
        appBar: AppBar(
          leading: const BackButtonNote(),
          title: materialText('Tambah Catatan'),
          actions: [
            Obx(
              () => IconButton(
                onPressed: addC.isEdited.value
                    ? () {
                        (TrackerService()).track("create-note");
                        addC.addNoteService();
                      }
                    : null,
                icon: const Icon(Icons.done_rounded),
              ),
            )
          ],
        ),
        body: addC.isPress
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingAnimationWidget.inkDrop(
                      color: primaryColor,
                      size: 50,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Menyimpan Catatan...",
                      style: labelTextStyle.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            : WillPopScope(
                onWillPop: showExitPopupAdd,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 10, left: 36, right: 36),
                      child: TextField(
                        autofocus: true,
                        controller: addC.title,
                        focusNode: addC.titleFocusNode,
                        onChanged: (_) => addC.setIsEdited(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 24),
                        decoration: const InputDecoration.collapsed(
                          hintText: "Masukkan Judul",
                          hintStyle: TextStyle(fontSize: 24),
                        ),
                        minLines: 1,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 36,
                      ),
                      height: 17,
                      child: Row(
                        children: [
                          Text(
                            DateFormat.yMMMMd("ID_id").add_Hm().format(
                                  DateTime.now(),
                                ),
                            style: labelTextStyle.copyWith(fontSize: 12),
                          ),
                          VerticalDivider(
                            indent: 2,
                            thickness: 1,
                            color: Colors.black87.withOpacity(0.7),
                          ),
                          Obx(
                            () => Text(
                              "${addC.chatCount.value} Karakter",
                              style: labelTextStyle.copyWith(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextEditor(
                        controller: addC.quillController,
                        noteFocus: addC.quillFocusNode,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
