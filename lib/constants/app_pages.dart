import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:note_taker/screens/intro_screen/intro_screen.dart';

import '../bindings/initial_binding.dart';
import '../screens/note/add_note_screen.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/note/edit_note_screen.dart';
import '../screens/layouts/home_page.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/profile/setting_account.dart';

var appPages = [
  GetPage(
    name: AuthScreen.routeName,
    page: () => const AuthScreen(),
  ),
  GetPage(
    name: HomePage.routeName,
    page: () => const HomePage(),
    binding: InitialBinding(),
    transition: Transition.cupertino,
    curve: Curves.easeInOut,
    transitionDuration: const Duration(milliseconds: 250),
  ),
  GetPage(
    name: AddNoteScreen.routeName,
    page: () => const AddNoteScreen(),
    transition: Transition.downToUp,
    curve: Curves.easeInOut,
    transitionDuration: const Duration(milliseconds: 250),
  ),
  GetPage(
    name: EditNoteScreen.routeName,
    page: () => const EditNoteScreen(),
    transition: Transition.rightToLeft,
    curve: Curves.easeInOut,
    transitionDuration: const Duration(milliseconds: 250),
  ),
  GetPage(
    name: LoginScreen.routeName,
    page: () => const LoginScreen(),
    transition: Transition.cupertino,
    curve: Curves.easeInOut,
    transitionDuration: const Duration(milliseconds: 250),
  ),
  GetPage(
    name: RegisterScreen.routeName,
    page: () => const RegisterScreen(),
    transition: Transition.cupertino,
    curve: Curves.easeInOut,
    transitionDuration: const Duration(milliseconds: 250),
  ),
  GetPage(
    name: SettingAccount.routeName,
    page: () => const SettingAccount(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.cupertino
  ),
  GetPage(
    name: IntroScreen.routeName,
    page: () => const IntroScreen(),
  ),
];
