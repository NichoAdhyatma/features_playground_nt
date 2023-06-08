import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_taker/constants/theme.dart';

List<Widget> tutorialText = [
  const Text(
    "1. Menambah Catatan : Kamu bisa menekan Tombol ",
  ),
  const Icon(
    Icons.add_circle,
    color: primaryColor,
  ),
  const SizedBox(
    height: 10,
  ),
  const Text(
    "2. Mengedit Catatan : Kamu bisa mengedit catatan dengan tap pada catatan kamu ",
  ),
  const SizedBox(
    height: 10,
  ),
  const Text(
    "3. Menghapus Catatan : Kamu bisa menekan icon ",
  ),
  const Icon(
    Icons.delete_outline,
    color: Colors.red,
  ),
  const Text(
    "Atau dengan menggeser catatan ke kanan atau ke kiri",
  ),
  const SizedBox(
    height: 10,
  ),
  Container(
    alignment: Alignment.center,
    child: ElevatedButton(
        style: primaryButton,
        onPressed: () {
          Get.back();
        },
        child: const Text("Saya Mengerti")),
  )
];
