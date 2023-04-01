// ignore_for_file: must_be_immutable

import 'package:bill_ease/utils/kj_theme.dart';
import 'package:flutter/material.dart';

class ScanQrPage extends StatefulWidget {
  ScanQrPage({super.key, required this.scanCode});
  String scanCode;
  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  @override
  void initState() {
    print(widget.scanCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KJTheme.backGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: KJTheme.darkishGrey,
        elevation: 0.0,
        automaticallyImplyLeading: true,
        title: Text(
          "Scan QR",
          style: KJTheme.titleText(
              color: KJTheme.darkishGrey,
              size: KJTheme.getMobileWidth(context) / 20,
              weight: FontWeight.bold),
        ),
      ),
    );
  }
}
