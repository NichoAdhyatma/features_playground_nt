import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_taker/controllers/main_screen_controller.dart';

import '../constants/constant.dart';
import '../constants/theme.dart';
import '../controllers/note_controller.dart';
import '../controllers/tab_controller.dart';
import '../models/note_model.dart';
import '../screens/note/edit_note_screen.dart';
import '../services/tracker_service.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    required this.quillController,
    required this.index,
  });

  final NoteModel note;
  final QuillController quillController;
  final int index;

  @override
  Widget build(BuildContext context) {
    final tabC = Get.find<TabIndexController>();
    final noteC = Get.find<NoteController>();
    final mainC = Get.find<MainScreenController>();
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () async {
        tabC.focusNode.unfocus();
        (TrackerService()).track('edit-note');
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        var result = await Get.toNamed(EditNoteScreen.routeName, arguments: {
          'id': note.id,
          'title': note.title,
          'note': note.content
        });

        if (result != null && result) {
          showSnackBar("Sukses !", "Catatan berhasil di ubah", "success");
        }
        mainC.clearSearch();
        noteC.fetchData();
      },
      child: Dismissible(
        key: UniqueKey(),
        direction: index % 2 == 0
            ? DismissDirection.endToStart
            : DismissDirection.startToEnd,
        confirmDismiss: (direction) async {
          tabC.focusNode.unfocus();
          return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              icon: const Icon(
                Icons.delete_rounded,
                size: 40,
              ),
              content: materialText('Ingin menghapus catatan ini ?'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              actions: <Widget>[
                TextButton(
                  child: materialText('Jangan', style: boldPrimaryLabel),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    mainC.clearSearch();
                    noteC.destroyNote(note.id);
                    Navigator.pop(context);
                  },
                  style: primaryButton,
                  child: materialText(
                    'Iya hapus',
                    style: boldPrimaryLabel.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
        child: Container(
          height: size.height * 0.3,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 2,
              color: primaryColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          materialText(
                            note.title,
                            style: titleTextStyle.copyWith(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          materialText(quillController.document.toPlainText(),
                              style: labelTextStyle,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () async {
                            tabC.focusNode.unfocus();
                            (TrackerService()).track('delete-note');
                            return showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                icon: const Icon(
                                  Icons.delete_rounded,
                                  size: 40,
                                ),
                                content: materialText(
                                  'Ingin menghapus catatan ini ?',
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: materialText('Jangan',
                                        style: boldPrimaryLabel),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      // showDialog() returns false
                                    },
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      mainC.clearSearch();
                                      noteC.destroyNote(note.id);
                                      Navigator.pop(context);
                                      // showDialog() returns true
                                    },
                                    style: primaryButton,
                                    child: materialText('Iya hapus',
                                        style: boldPrimaryLabel.copyWith(
                                            color: Colors.white)),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: materialText(
                            DateFormat.yMMMd("id_ID")
                                .add_Hm()
                                .format(note.updatedAt),
                            style: labelTextStyle.copyWith(
                                color: darkBlue.withOpacity(0.65),
                                fontWeight: FontWeight.w600,
                                fontSize: 11),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
