import 'package:flutter/material.dart';

import '../constants/theme.dart';

class MyAppbar extends StatelessWidget {
  const MyAppbar({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            blurRadius: 1.0,
            offset: Offset(
              0.0,
              0.5,
            ),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.05, bottom: size.height * 0.01, left: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/app-logo.png'),
                    fit: BoxFit.contain),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            title != null
                ? Text(
                    title!,
                    style: labelTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: primaryColor,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
