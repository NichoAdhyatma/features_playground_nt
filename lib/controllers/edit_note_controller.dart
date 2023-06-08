import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:note_taker/controllers/timer_service.dart';
import 'note_controller.dart';

class EditNoteController extends GetxController {
  bool isPress = false;
  int? id;
  String? title;
  String? note;
  var timeS = Get.put(TimerService());
  QuillController quillController = QuillController.basic();
  NoteController noteC = Get.find<NoteController>();
  var chatCount = 0.obs;

  final TextEditingController titleController =
      TextEditingController(text: Get.arguments['title']);
  FocusNode focusNode = FocusNode();
  FocusNode titleFocus = FocusNode();
  var isEdited = false.obs;

  void reset() {
    timeS.timer?.cancel();
    timeS.timer = null;
  }

  bool isChanged() {
    return (jsonEncode(quillController.document.toDelta().toJson()) != note) ||
        (title != titleController.text);
  }

  void setIsEdited() {
    isEdited.value = isChanged();
  }

  void countChar() {
    var text = quillController.document.toPlainText().trim();
    chatCount.value = text.length;
  }

  void updateNote(Timer timer) {
    var content = jsonEncode(quillController.document.toDelta().toJson());
    var title = titleController.text;

    noteC.autoSaveNote(
      title,
      content,
      id!,
    );

    reset();
  }

  void start() {
    if (timeS.timer != null) return;
    timeS.timer = Timer.periodic(const Duration(seconds: 10), updateNote);
  }

  void changeNoteNotifier() {
    setIsEdited();
    countChar();
    if (isChanged()) {
      noteC.setIsSave(false);
      reset();
      start();
    } else {
      noteC.setIsSave(true);
    }
  }

  void setEditC(bool value) {
    isPress = value;
    update();
  }

  void updateNoteService() {
    focusNode.unfocus();
    titleFocus.unfocus();
    setEditC(true);
    var content = jsonEncode(quillController.document.toDelta().toJson());
    var title = titleController.text;

    if (isChanged()) {
      noteC
          .updateNote(
            title,
            content,
            id!,
          )
          .whenComplete(
            () => setEditC(false),
          );
    } else {
      setEditC(false);
      Get.back(result: false);
    }
  }

  void getAllArguments(int id, String title, String note) {
    this.id = id;
    this.title = title;
    this.note = note;
    quillController.document = Document.fromJson(
      jsonDecode(note),
    );

    countChar();

    quillController.addListener(() {
      changeNoteNotifier();
    });

    update();
  }
}
