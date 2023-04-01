// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, non_constant_identifier_names

import 'package:bill_ease/utils/kj_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class BillView extends StatefulWidget {
  const BillView(this.pdfLink, {Key? key}) : super(key: key);
  final String pdfLink;

  @override
  State<BillView> createState() => _BillViewState();
}

class _BillViewState extends State<BillView> {
  late File pdf_file;
  bool isLoading = false;

  Future<void> loadNetwork() async {
    setState(() {
      isLoading = true;
    });
    var url = widget.pdfLink;
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/$filename');
    file.writeAsBytes(bytes, flush: true).then((value) {
      setState(() {
        pdf_file = file;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    loadNetwork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: KJTheme.darkishGrey,
          elevation: 0.0,
          automaticallyImplyLeading: true,
          title: Text(
            "Bill",
            style: KJTheme.titleText(
                color: KJTheme.darkishGrey,
                size: KJTheme.getMobileWidth(context) / 20,
                weight: FontWeight.bold),
          ),
        ),
        body: Container(
          child: (!isLoading)
              ? (PDFView(
                  filePath: pdf_file.path.toString(),
                  fitPolicy: FitPolicy.BOTH,
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: false,
                  pageFling: false,
                  onError: (error) {
                    print(error.toString());
                  },
                  onPageError: (page, error) {
                    print('$page: ${error.toString()}');
                  },
                ))
              : (Center(child: CircularProgressIndicator())),
        ));
  }
}
