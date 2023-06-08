import 'dart:async';
import 'package:get/get.dart';

class TimerService extends GetxController{
  Timer? timer;

  Duration get currentDuration => _currentDuration;
  final Duration _currentDuration = Duration.zero;

  bool get isRunning => timer != null;

  @override
  void onClose() {
    timer?.cancel();
    timer = null;
    super.onClose();
  }

}