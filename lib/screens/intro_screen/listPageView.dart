import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<PageViewModel> listPageView = [
  PageViewModel(
    title: "Selamat datang di Note Taker",
    body: "Aplikasi Pencatatan yang simpel dan mudah di gunakan",
    image: Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/note-image-2.png"),
          ),
        ),
      ),
    ),
  ),
  PageViewModel(
    title: "Tingkatkan Produktivitas !",
    body: "Buat catatan setiap hari, dimanapun, kapanpun.",
    image: Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
        width: Get.width,
        height: Get.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/image-note-1.png"),
          ),
        ),
      ),
    ),
  ),
  PageViewModel(
    title: "Ayo Mulai Mencatat !",
    body: "Buat Catatan Pertama mu di Note Taker",
    image: Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/image-note-3.png"),
          ),
        ),
      ),
    ),
  ),
];
