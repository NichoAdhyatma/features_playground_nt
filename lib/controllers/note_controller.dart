import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_taker/models/note_model.dart';
import '../constants/constant.dart';
import '../services/note_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NoteController extends GetxController {
  final List<NoteModel> noteData = [];
  List<NoteModel> displayNote = [];
  var isFetch = false.obs;
  bool isSaved = true;

  void fetchData() {
    isFetch.value = true;

    (NoteService()).getAll().then((response) {
      if (response.error == null) {
        getDataFromDb(response.data as List<dynamic>);
      } else {
        showSnackBar("Pesan", response.error!, "error");
      }
      isFetch.value = false;
    });
  }

  void setIsSave(bool val) {
    isSaved = val;
    update();
  }

  Future<void> simpanNote(String title, String body) async {
    await (NoteService()).store(title, body).then(
      (response) {
        if (response.error == null) {
          Get.back(result: true);
        } else {
          showSnackBar("Pesan", response.error!, "error");
        }
      },
    );
  }

  void clearSearch() {
    displayNote = noteData;
    update();
  }

  void updateList(String value) {
    displayNote = noteData
        .where(
          (element) =>
              element.title.toLowerCase().contains(value.toLowerCase()) ||
              element.content.toLowerCase().contains(
                    value.toLowerCase(),
                  ),
        )
        .toList();

    update();
  }

  void dateList(DateTime value) {
    displayNote = noteData.where((element) {
      if (element.createdAt.day.compareTo(value.day) == 0 &&
          element.createdAt.month.compareTo(value.month) == 0 &&
          element.createdAt.year.compareTo(value.year) == 0) {
        return true;
      }
      return false;
    }).toList();

    update();
  }

  void getDataFromDb(List<dynamic> notes) async {
    noteData.clear();
    for (var element in notes) {
      noteData.add(NoteModel.fromJson(element));
    }

    displayNote = noteData;
    update();
  }

  Future<void> destroyNote(int id) async {
    NoteService().destroy(id).then((response) {
      if (response.error == null) {
        fetchData();
        showSnackBar("Sukses !", "Catatan berhasil dihapus", 'success');
      } else {
        showSnackBar("Pesan", response.error!, "error");
      }
    });
  }

  void autoSaveNote(String title, String content, int id) {
    NoteService().update(id, title, content).then((response) {
      if (response.error == null) {
        setIsSave(true);
        Fluttertoast.showToast(
          msg: "✅ Catatan berhasil tersimpan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green[600],
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        showSnackBar(
          "Gagal",
          response.error!,
          "error",
        );
      }
    });
  }

  Future<void> updateNote(
    String title,
    String content,
    int id,
  ) async {
    await NoteService().update(id, title, content).then((response) {
      if (response.error == null) {
        setIsSave(true);
        Get.back(result: true);
      } else {
        showSnackBar("Pesan", response.error!, "error");
      }
    });
  }
}
