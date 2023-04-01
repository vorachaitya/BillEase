import 'package:bill_ease/utils/kj_theme.dart';
import 'package:flutter/material.dart';

class Bills extends StatefulWidget {
  const Bills({super.key});

  @override
  State<Bills> createState() => _BillsState();
}

class _BillsState extends State<Bills> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KJTheme.backGroundColor,
      appBar: AppBar(),
      body: Column(
        children: [],
      ),
    );
  }
}
