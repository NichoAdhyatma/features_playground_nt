import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:note_taker/constants/theme.dart';
import 'package:note_taker/controllers/login_screen_controller.dart';
import 'package:note_taker/screens/intro_screen/intro_screen.dart';
import 'package:note_taker/screens/auth/register_screen.dart';
import 'package:get/get.dart';
import 'package:note_taker/widgets/footer.dart';
import '../../services/tracker_service.dart';
import '../../widgets/custom_divider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    var loginC = Get.put(LoginScreenController());
    var scrollController = ScrollController();

    void scrollDown() {
      scrollController.animateTo(
        50,
        duration: const Duration(milliseconds: 250),
        curve: Curves.fastOutSlowIn,
      );
    }

    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          margin: const EdgeInsets.all(25),
          backgroundColor: darkBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Tekan sekali lagi untuk keluar",
            style: labelTextStyle.copyWith(color: Colors.white),
          ),
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 30,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: Text(
                    "Masuk",
                    style: titleTextStyle.copyWith(
                        color: primaryColor, fontSize: 24),
                  ),
                ),
                const SizedBox(height: 10),
                Image.asset(
                  "assets/images/login.png",
                  height: 200,
                  fit: BoxFit.cover,
                  width: 200,
                ),
                const SizedBox(height: 10),
                Form(
                  key: loginC.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onTap: () => scrollDown(),
                        style: textFieldText,
                        textInputAction: TextInputAction.next,
                        focusNode: loginC.emailFocus,
                        controller: loginC.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kamu belum mengisi kolom email';
                          }
                          return null;
                        },
                        decoration: textFieldPrimary(
                            label: 'Email', hintText: 'example@mail.com'),
                      ),
                      const SizedBox(height: 30),
                      GetBuilder<LoginScreenController>(
                        builder: (loginC) => TextFormField(
                          onEditingComplete: () {
                            loginC.emailFocus.unfocus();
                            loginC.passwordFocus.unfocus();
                            loginC.isLoading ? null : loginC.login();
                          },
                          onTap: () => scrollDown(),
                          style: textFieldText,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kamu belum mengisi kolom password';
                            }
                            return null;
                          },
                          focusNode: loginC.passwordFocus,
                          controller: loginC.password,
                          obscureText: loginC.isSecure,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            suffixIcon: IconButton(
                              onPressed: () {
                                loginC.setIsSecure();
                              },
                              icon: Icon(loginC.isSecure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
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
                            hintStyle:
                                TextStyle(color: darkBlue.withOpacity(0.6)),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.redAccent, width: 2),
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
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                GetBuilder<LoginScreenController>(
                  builder: (loginC) => ElevatedButton(
                    onPressed: loginC.isLoading
                        ? null
                        : () {
                            loginC.emailFocus.unfocus();
                            loginC.passwordFocus.unfocus();
                            loginC.isLoading ? null : loginC.login();
                            (TrackerService()).track('click-login');
                          },
                    style: primaryButton,
                    child: loginC.isLoading
                        ? Center(
                            child: LoadingAnimationWidget.inkDrop(
                              size: 30,
                              color: Colors.white,
                            ),
                          )
                        : const Center(
                            child: Text(
                              "MASUK",
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
                  value: false,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: secondaryButon,
                  onPressed: () {
                    loginC.emailFocus.unfocus();
                    loginC.passwordFocus.unfocus();
                    Navigator.pushNamed(
                      context,
                      RegisterScreen.routeName,
                    );
                  },
                  child: const Center(
                    child: Text(
                      "DAFTAR",
                      style: TextStyle(
                          fontSize: 18,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Get.offAllNamed(IntroScreen.routeName);
                  },
                  child: const Text("Halaman Awal"),
                ),
                const Footer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
