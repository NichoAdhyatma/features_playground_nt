import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:note_taker/constants/api_auth.dart';
import 'package:note_taker/constants/constant.dart';
import 'package:note_taker/constants/theme.dart';
import 'package:note_taker/controllers/edit_note_controller.dart';
import 'package:note_taker/screens/note/text_editor.dart';
import 'package:get/get.dart';
import 'package:note_taker/services/tracker_service.dart';
import 'package:share_plus/share_plus.dart';
import '../../widgets/backButtonEdit.dart';

class EditNoteScreen extends StatelessWidget {
  const EditNoteScreen({Key? key}) : super(key: key);
  static const routeName = "/edit-note";

  @override
  Widget build(BuildContext context) {
    final editScreenC = Get.put(EditNoteController());

    return GetBuilder<EditNoteController>(
      initState: (_) => editScreenC.getAllArguments(
        Get.arguments['id'],
        Get.arguments['title'],
        Get.arguments['note'],
      ),
      builder: (editC) => Scaffold(
        appBar: AppBar(
          leading: const BackButtonEdit(),
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                var url = '$shareNoteUrl${Get.arguments['id']}';
                final box = context.findRenderObject() as RenderBox?;
                await Clipboard.setData(
                  ClipboardData(text: url),
                );
                await Share.share(
                  'Catatan yang dibagikan denganmu \n\n$url ',
                  sharePositionOrigin:
                      box!.localToGlobal(Offset.zero) & box.size,
                );
              },
              icon: const Icon(Icons.share),
            ),
            Obx(
              () => IconButton(
                onPressed: editScreenC.isEdited.value
                    ? () {
                        TrackerService().track("update-note");
                        editC.updateNoteService();
                      }
                    : null,
                icon: const Icon(
                  Icons.done_rounded,
                ),
              ),
            )
          ],
          title: materialText("Edit Catatan"),
        ),
        body: editC.isPress
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
                onWillPop: showExitPopup,
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 10, left: 36, right: 36),
                      child: TextField(
                        focusNode: editC.titleFocus,
                        onChanged: (_) => editC.changeNoteNotifier(),
                        controller: editC.titleController,
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
                              "${editC.chatCount.value} Karakter",
                              style: labelTextStyle.copyWith(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextEditor(
                        controller: editC.quillController,
                        noteFocus: editC.focusNode,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
