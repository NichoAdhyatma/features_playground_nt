import 'package:flutter/material.dart';

class TextFieldWithCheckbox extends StatefulWidget {
  // late final TextEditingController body;
  @override
  _TextFieldWithCheckboxState createState() => _TextFieldWithCheckboxState();
}

class _TextFieldWithCheckboxState extends State<TextFieldWithCheckbox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    // TextEditingController body = widget.body;
    return InputDecorator(
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Checkbox(
            value: _isChecked,
            onChanged: (value) {
              setState(() {
                _isChecked = value!;
              });
            },
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: TextField(
              autocorrect: false,
              // controller: body,
              maxLines: null,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Masukkan List",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
