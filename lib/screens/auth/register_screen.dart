import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:note_taker/constants/theme.dart';
import 'package:note_taker/controllers/register_screen_controller.dart';
import 'package:note_taker/services/tracker_service.dart';
import 'package:get/get.dart';
import 'package:note_taker/widgets/footer.dart';
import '../../widgets/custom_divider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = "/register";

  @override
  Widget build(BuildContext context) {
    var registerC = Get.put(RegisterScreenController());
    var scrollController = ScrollController();

    void scrollDown() {
      scrollController.animateTo(
        100,
        duration: const Duration(milliseconds: 250),
        curve: Curves.fastOutSlowIn,
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Form(
            key: registerC.formKey,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: Text(
                    "Daftar",
                    style: titleTextStyle.copyWith(
                        color: primaryColor, fontSize: 24),
                  ),
                ),
                const SizedBox(height: 10),
                Image.asset(
                  "assets/images/register.png",
                  height: 200,
                  fit: BoxFit.cover,
                  width: 200,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  focusNode: registerC.nameFocus,
                  controller: registerC.name,
                  style: textFieldText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kamu belum mengisi kolom nama';
                    }
                    return null;
                  },
                  decoration: textFieldPrimary(
                      label: 'Nama', hintText: 'Masukan nama mu disini'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onTap: scrollDown,
                  focusNode: registerC.emailFocus,
                  controller: registerC.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kamu belum mengisi kolom email';
                    }
                    return null;
                  },
                  style: textFieldText,
                  decoration: textFieldPrimary(
                      label: 'Email', hintText: 'example@gmail.com'),
                ),
                const SizedBox(height: 20),
                GetBuilder<RegisterScreenController>(
                  builder: (registerC) => TextFormField(
                    onEditingComplete: () {
                      registerC.register();
                    },
                    onTap: scrollDown,
                    textInputAction: TextInputAction.done,
                    focusNode: registerC.passwordFocus,
                    controller: registerC.password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kamu belum mengisi kolom password';
                      }
                      return null;
                    },
                    style: textFieldText,
                    obscureText: registerC.isSecure,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      suffixIcon: IconButton(
                        onPressed: () {
                          registerC.setIsSecure();
                        },
                        icon: Icon(registerC.isSecure
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: secondayColor,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: secondayColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Masukan Kata Sandi",
                      border: const OutlineInputBorder(),
                      labelText: "Kata Sandi",
                      labelStyle: const TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      hintStyle: TextStyle(color: darkBlue.withOpacity(0.6)),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.redAccent, width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: primaryColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                GetBuilder<RegisterScreenController>(
                  builder: (registerC) => ElevatedButton(
                    style: primaryButton,
                    onPressed: registerC.isLoading
                        ? null
                        : () {
                            (TrackerService()).track("click-register");
                            registerC.register();
                          },
                    child: Center(
                      child: registerC.isLoading
                          ? LoadingAnimationWidget.inkDrop(
                              size: 30,
                              color: Colors.white,
                            )
                          : const Text(
                              "DAFTAR",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const CustomDivider(
                  value: true,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: secondaryButon,
                  child: const Center(
                    child: Text(
                      "MASUK",
                      style: TextStyle(
                          fontSize: 18,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
