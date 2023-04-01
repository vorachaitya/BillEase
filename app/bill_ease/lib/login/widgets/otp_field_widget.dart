import 'package:bill_ease/utils/kj_theme.dart';
import 'package:flutter/material.dart';

Widget textFieldOTP(
    {required bool first,
    last,
    required TextEditingController controller,
    required BuildContext context}) {
  return SizedBox(
    height: 80,
    child: Center(
      child: AspectRatio(
        aspectRatio: 0.6,
        child: TextField(
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: KJTheme.titleText(size: 20, weight: FontWeight.w600),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.grey.withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: KJTheme.nearlyBlue),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    ),
  );
}
