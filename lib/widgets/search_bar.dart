import 'package:flutter/material.dart';
import 'package:note_taker/constants/theme.dart';
import 'package:note_taker/controllers/main_screen_controller.dart';
import 'package:note_taker/controllers/note_controller.dart';
import 'package:note_taker/controllers/tab_controller.dart';
import 'package:note_taker/widgets/clipper.dart';
import 'package:get/get.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainC = Get.find<MainScreenController>();
    final tabC = Get.find<TabIndexController>();
    final size = MediaQuery.of(context).size;

    return ClipPath(
      clipper: MyClipper(),
      child: Stack(
        children: [
          Container(
            height: size.height * 0.15,
            width: size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primaryColor,
                  secondayColor,
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: GetBuilder<NoteController>(
                    builder: (noteC) => TextField(
                      onChanged: (value) {
                        noteC.updateList(value);
                        mainC.synchronize();
                      },
                      focusNode: tabC.focusNode,
                      autofocus: false,
                      controller: mainC.search,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        border: InputBorder.none,
                        hintText: "Cari Catatan",
                        suffixIcon: mainC.search.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  mainC.clearSearch();
                                  noteC.updateList(mainC.search.text);
                                },
                                icon:
                                    const Icon(Icons.highlight_remove_rounded),
                              )
                            : IconButton(
                                onPressed: () {
                                  noteC.updateList(mainC.search.text);
                                },
                                icon: const Icon(Icons.search),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
