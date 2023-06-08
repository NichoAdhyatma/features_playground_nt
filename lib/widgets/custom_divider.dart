import 'package:flutter/material.dart';

import '../constants/theme.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    required this.value,
  });

  final bool value;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Expanded(
        child: Divider(
          color: primaryColor,
          thickness: 1,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Text(
        value ? "Sudah Punya Akun ? " : "Belum Punya Akun ?",
        style: boldPrimaryLabel,
      ),
      const SizedBox(
        width: 10,
      ),
      const Expanded(
        child: Divider(
          color: primaryColor,
          thickness: 1,
        ),
      ),
    ]);
  }
}
