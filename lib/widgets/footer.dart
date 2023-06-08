import 'package:flutter/material.dart';
import '../constants/theme.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/app-logo.png",
            width: 25,
            height: 25,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text("Note Taker 2.4.3", style: labelTextStyle),
        ],
      ),
    );
  }
}
