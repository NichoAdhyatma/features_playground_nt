import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_taker/constants/tutorial.dart';
import 'package:note_taker/controllers/main_screen_controller.dart';
import 'package:note_taker/widgets/search_bar.dart';

import '../../constants/theme.dart';
import 'package:get/get.dart';
import '../../widgets/note_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        //quick note
        const SearchBarWidget(),
        //your note
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "Catatan kamu",
                    style: titleTextStyle.copyWith(
                      color: primaryColor,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Get.dialog(
                        AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          title: Text(
                            "Tata cara penggunaan aplikasi Note Taker",
                            textAlign: TextAlign.center,
                            style: titleTextStyle.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: tutorialText,
                          ),
                        ),
                        transitionDuration: const Duration(milliseconds: 250),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(
                      Icons.question_mark_outlined,
                      size: 20,
                    ),
                  )
                ],
              ),
              Text(
                DateFormat.yMMMMEEEEd("id_ID").format(DateTime.now()),
                style: boldPrimaryLabel,
              ),
            ],
          ),
        ),

        GetBuilder<MainScreenController>(
          builder: (mainC) => mainC.search.text.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Hasil pencarian : ${mainC.search.text}",
                    style: labelTextStyle.copyWith(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                )
              : const SizedBox.shrink(),
        ),

        const NoteGrid(),
      ],
    );
  }
}
