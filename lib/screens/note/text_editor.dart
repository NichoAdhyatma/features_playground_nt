import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:note_taker/constants/theme.dart';

class TextEditor extends StatelessWidget {
  TextEditor({super.key, required this.controller, required this.noteFocus});

  final QuillController controller;
  final FocusNode noteFocus;
  final scrollNote = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: QuillEditor(
                key: UniqueKey(),
                placeholder: 'Masukkan Catatan Disini',
                controller: controller,
                readOnly: false,
                focusNode: noteFocus,
                scrollController: scrollNote,
                scrollable: true,
                padding: const EdgeInsets.all(12),
                autoFocus: false,
                expands: true,
              ),
            ),
          ),
        ),
        QuillToolbar.basic(
          iconTheme: const QuillIconTheme(iconSelectedFillColor: primaryColor),
          controller: controller,
          toolbarIconSize: 22,
          color: Colors.grey[200],
          showColorButton: false,
          showAlignmentButtons: false,
          showBackgroundColorButton: false,
          showCenterAlignment: false,
          showFontFamily: false,
          showDividers: false,
          showClearFormat: false,
          showCodeBlock: false,
          showDirection: false,
          showHeaderStyle: false,
          showLink: false,
          showIndent: false,
          showRedo: false,
          showQuote: false,
          showFontSize: false,
          showJustifyAlignment: false,
          showLeftAlignment: false,
          showSearchButton: false,
          showUndo: false,
          showSmallButton: false,
          showRightAlignment: false,
          showInlineCode: false,
          multiRowsDisplay: false,
          showSubscript: false,
          showSuperscript: false,
        ),
      ],
    );
  }
}
