import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:note_taker/constants/theme.dart';
import 'package:note_taker/controllers/setting_account_controller.dart';
import 'package:note_taker/services/tracker_service.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class SettingAccount extends StatelessWidget {
  const SettingAccount({Key? key}) : super(key: key);
  static const routeName = "/setting-account";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: GetBuilder(
        init: Get.find<SettingAccountController>(),
        initState: (_) => Get.find<SettingAccountController>().getUser(),
        builder: (SettingAccountController userC) {
          TextEditingController name = userC.name;
          TextEditingController email = userC.email;
          return ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                child: const Text(
                  'Nama',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              userC.isFetch
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[400]!,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text("Skeleton"),
                      ),
                    )
                  : TextField(
                      style: textFieldText,
                      focusNode: userC.focusNode,
                      controller: userC.name,
                      decoration: textFieldPrimary().copyWith(
                        suffixIcon: const Icon(
                          Icons.edit,
                          color: primaryColor,
                        ),
                      ),
                      onChanged: (_) => userC.setIsChange(),
                    ),
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                child: const Text(
                  'Email',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              userC.isFetch
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[400]!,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text("Skeleton"),
                      ),
                    )
                  : TextField(
                      style: textFieldText,
                      controller: email,
                      decoration: const InputDecoration.collapsed(
                          hintText: "", enabled: false),
                    ),
              const SizedBox(height: 10),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: primaryButton,
                onPressed: userC.isPress || !userC.isChange
                    ? null
                    : () {
                        userC.focusNode.unfocus();
                        userC.updateUser(name);
                        (TrackerService()).track("update-user-profile");
                      },
                child: userC.isPress
                    ? LoadingAnimationWidget.inkDrop(
                        size: 30,
                        color: Colors.white,
                      )
                    : Text("SIMPAN",
                        style: boldPrimaryLabel.copyWith(color: Colors.white)),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: secondaryButon,
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      icon: const Icon(
                        Icons.logout_rounded,
                        size: 40,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      content: const Text("Kamu yakin mau Keluar ?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "Tidak",
                            style: boldPrimaryLabel,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.back();

                            userC.logout();
                          },
                          style: primaryButton,
                          child: const Text("Keluar"),
                        ),
                      ],
                    ),
                    transitionDuration: const Duration(milliseconds: 250),
                  );
                  (TrackerService()).track("click-logout");
                },
                child: userC.isLoading
                    ? LoadingAnimationWidget.inkDrop(
                        size: 30,
                        color: primaryColor,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.logout,
                            color: primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "KELUAR AKUN",
                            style: boldPrimaryLabel,
                          ),
                        ],
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
