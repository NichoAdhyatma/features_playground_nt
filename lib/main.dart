import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:note_taker/bindings/initial_binding.dart';
import 'package:note_taker/constants/app_pages.dart';
import 'package:note_taker/constants/theme.dart';
import 'package:flutter/services.dart';

import 'package:note_taker/screens/auth/auth_screen.dart';

import 'package:note_taker/services/tracker_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var trackerService = TrackerService();
  await dotenv.load(fileName: ".env");
  await initializeDateFormatting('id_ID', null);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  trackerService.track("on-open-app", withDeviceInfo: true);

  runApp(const NoteTaker());

  trackerService.track("on-load-app", withDeviceInfo: true);
}

class NoteTaker extends StatelessWidget {
  const NoteTaker({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Note Taker",
      debugShowCheckedModeBanner: false,
      theme: themeData,
      initialRoute: AuthScreen.routeName,
      initialBinding: InitialBinding(),
      getPages: appPages,
    );
  }
}
