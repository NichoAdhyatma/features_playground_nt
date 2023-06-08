import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:note_taker/constants/theme.dart';
import 'package:note_taker/controllers/note_controller.dart';

import '../constants/constant.dart';
import 'package:get/get.dart';

import 'note_card.dart';

class NoteGrid extends StatelessWidget {
  const NoteGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final noteC = Get.find<NoteController>();

    return GetX<NoteController>(
      initState: (_) => noteC.fetchData(),
      builder: (noteC) => noteC.isFetch.value
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.twistingDots(
                    leftDotColor: primaryColor,
                    rightDotColor: secondayColor,
                    size: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  materialText(
                    "Mengambil Data Catatan...",
                    style: labelTextStyle.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : noteC.noteData.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        materialText(
                          "Belum ada catatan yang kamu buat",
                          style: labelTextStyle.copyWith(color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                )
              : GetBuilder<NoteController>(
                  builder: (noteC) => GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 6,
                    ),
                    itemCount: noteC.displayNote.length,
                    itemBuilder: (context, index) {
                      var note = noteC.displayNote[index];
                      final QuillController quillController = QuillController(
                        document: Document.fromJson(
                          jsonDecode(
                            note.content,
                          ),
                        ),
                        selection: const TextSelection.collapsed(offset: 0),
                      );
                      return NoteCard(
                        note: note,
                        quillController: quillController,
                        index: index,
                      );
                    },
                  ),
                ),
    );
  }
}
