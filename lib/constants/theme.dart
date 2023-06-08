import 'package:flutter/material.dart';

const primaryColor = Color(0XFF7579E7);
const secondayColor = Color(0xFF9AB3F5);
const ternaryColor = Color(0xFFA3D8F4);
const darkBlue = Color(0xFF01004E);

var themeData = ThemeData(
  fontFamily: "Poppins",
  iconTheme: const IconThemeData(color: primaryColor),
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    primary: primaryColor,
    secondary: secondayColor,
    tertiary: ternaryColor,
  ),
);

const labelTextStyle = TextStyle(
  color: darkBlue,
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

const titleTextStyle = TextStyle(
  color: darkBlue,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

var boldPrimaryLabel =
    labelTextStyle.copyWith(fontWeight: FontWeight.bold, color: primaryColor);

InputDecoration textFieldPrimary({String? label, String? hintText}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.all(15),
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
    hintText: hintText,
    border: const OutlineInputBorder(),
    labelText: label,
    labelStyle: const TextStyle(
      color: primaryColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    hintStyle: TextStyle(
      color: darkBlue.withOpacity(0.6),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.redAccent),
      borderRadius: BorderRadius.circular(15),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      borderRadius: BorderRadius.circular(15),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: primaryColor.withOpacity(0.5),
      ),
    ),
  );
}

const textFieldText = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.w500,
  letterSpacing: 1.2,
);

var secondaryButon = ElevatedButton.styleFrom(
  elevation: 0,
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  backgroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    side: const BorderSide(color: primaryColor, width: 2),
    borderRadius: BorderRadius.circular(15),
  ),
);

var primaryButton = ElevatedButton.styleFrom(
  elevation: 0,
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  disabledBackgroundColor: primaryColor.withOpacity(0.5),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
);
