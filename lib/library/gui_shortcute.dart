library;

import 'package:flutter/material.dart';

class GuiShortcut {
  GuiShortcut._();

  static const double defaultHeightSizedBox = 16.0;

  static Widget buildTextField(String labelText,
      TextEditingController controller, ColorScheme colorScheme,
      [bool? addSizeBox]) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: colorScheme.primary),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: labelText,
              border: InputBorder.none,
            ),
          ),
        ),
        if (addSizeBox == null || addSizeBox)
          const SizedBox(height: GuiShortcut.defaultHeightSizedBox),
      ],
    );
  }

  static Widget buildRowSwitchLoginSignup(String textLabel, String textButton,
      BuildContext context, StatefulWidget newPage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(textLabel),
        const SizedBox(width: 8.0),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => newPage,
              ),
            );
          },
          child: Text(textButton),
        ),
      ],
    );
  }
}
