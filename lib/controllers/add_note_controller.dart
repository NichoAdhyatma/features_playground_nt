import 'dart:convert';

import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:note_taker/controllers/note_controller.dart';

class AddNoteController extends GetxController {
  final TextEditingController title = TextEditingController();
  final TextEditingController body = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final QuillController quillController = QuillController.basic();
  final FocusNode quillFocusNode = FocusNode();
  final FocusNode titleFocusNode = FocusNode();
  final noteC = Get.find<NoteController>();
  var isEdited = false.obs;
  bool isPress = false;
  var chatCount = 0.obs;

  void setIsPress(value) {
    isPress = value;
    update();
  }

  void setIsEdited() {
    isEdited.value = isChanged();
  }

  void countChar() {
    var text = quillController.document.toPlainText().trim();
    chatCount.value = text.length;
  }

  bool isChanged() {
    var text = quillController.document.toPlainText().trim();
    return title.text.trim().isNotEmpty || text.isNotEmpty;
  }

  void quillOnChange() {
    quillController.addListener(() {
      setIsEdited();
      countChar();
    });
  }

  void addNoteService() {
    titleFocusNode.unfocus();
    quillFocusNode.unfocus();
    setIsPress(true);

    if (isChanged()) {
      noteC
          .simpanNote(
        title.text,
        jsonEncode(
          quillController.document.toDelta().toJson(),
        ),
      )
          .whenComplete(
        () {
          setIsPress(false);
        },
      );
    } else {
      Get.back(result: false);
    }
  }
}
