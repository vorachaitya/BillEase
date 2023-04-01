import 'package:bill_ease/utils/kj_theme.dart';
import 'package:flutter/material.dart';

class ForgotPassWidget extends StatelessWidget {
  const ForgotPassWidget({
    super.key,
    required this.width,
    required this.title,
    required this.data,
    required this.description,
    required this.onTap,
  });

  final double width;
  final String title;
  final IconData data;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            color: Colors.grey.shade200),
        child: Row(
          children: [
            Icon(
              data,
              size: width / 7,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: KJTheme.subtitleText(
                      size: width / 22,
                      weight: FontWeight.bold,
                      color: KJTheme.darkishGrey),
                ),
                Text(
                  description,
                  style: KJTheme.subtitleText(
                      size: width / 25,
                      weight: FontWeight.normal,
                      color: KJTheme.darkishGrey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
