// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, non_constant_identifier_names

import 'dart:async';

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
  int? pages = 0;
  bool isReady = false;
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

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
        body: Builder(builder: (context) {
          if (isLoading) {
            return Center(
              child: SizedBox(
                height: KJTheme.getMobileWidth(context) / 15,
                width: KJTheme.getMobileWidth(context) / 15,
                child: const CircularProgressIndicator(
                    strokeWidth: 3, color: KJTheme.nearlyBlue),
              ),
            );
          } else {
            return Expanded(
              child: PDFView(
                filePath: pdf_file.path,
                enableSwipe: true,
                swipeHorizontal: true,
                autoSpacing: false,
                pageFling: false,
                onRender: (x) {
                  setState(() {
                    pages = x;
                    isReady = true;
                  });
                },
                onError: (error) {
                  print(error.toString());
                },
                onPageError: (page, error) {
                  print('$page: ${error.toString()}');
                },
                onViewCreated: (PDFViewController pdfViewController) {
                  _controller.complete(pdfViewController);
                },
              ),
            );
          }
        }));
  }
}
