// ignore_for_file: must_be_immutable, depend_on_referenced_packages, non_constant_identifier_names, avoid_print, unused_field, unused_local_variable, prefer_interpolation_to_compose_strings, unused_element, deprecated_member_use, use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:bill_ease/common/kj_store.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:bill_ease/utils/kj_theme.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanQrPage extends StatefulWidget {
  ScanQrPage({super.key, required this.scanCode});
  String scanCode;
  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  late File pdf_file;
  bool isLoading = false;
  Map<String, dynamic> paymentJson = {};
  int? pages = 0;
  bool isReady = false;
  KJStore store = KJStore();
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  String _scanBarcode = "Unknown";

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  void loadNetwork() async {
    setState(() {
      isLoading = true;
    });
    var url = widget.scanCode;
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/$filename');
    file.writeAsBytes(bytes, flush: true).then((value) {
      saveBill().then((v) {
        if (v.isNotEmpty) {
          setState(() {
            pdf_file = file;
            paymentJson = v;
            isLoading = false;
          });
        }
      });
    });
  }

  Future<Map<String, dynamic>> saveBill() async {
    Map<String, dynamic> json =
        await store.customerBillSaver(scanBarCode: widget.scanCode);
    return json;
  }

  @override
  void initState() {
    loadNetwork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (isLoading) {
        return Scaffold(
          backgroundColor: KJTheme.backGroundColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: KJTheme.getMobileWidth(context) / 15,
                  width: KJTheme.getMobileWidth(context) / 15,
                  child: const CircularProgressIndicator(
                      strokeWidth: 3, color: KJTheme.nearlyBlue),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text("Wait a sec",
                      style: KJTheme.titleText(
                          size: KJTheme.getMobileWidth(context) / 18,
                          color: KJTheme.nearlyGrey,
                          weight: FontWeight.bold)),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("Parsing your pdf",
                      style: KJTheme.titleText(
                          size: KJTheme.getMobileWidth(context) / 28,
                          color: KJTheme.nearlyGrey.withOpacity(0.8),
                          weight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        );
      } else {
        return buildWidget(context);
      }
    });
  }

  Widget buildWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: KJTheme.backGroundColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: KJTheme.getMobileWidth(context) / 8,
          child: ElevatedButton(
              onPressed: () {
                scanQR().then((value) async {
                  String gpayUrl = "$_scanBarcode&am=" + paymentJson["total"];
                  bool result = await launch(gpayUrl);
                  if (result) {
                    Fluttertoast.showToast(
                        msg: "Successful payment",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: KJTheme.darkishGrey,
                        textColor: Colors.white,
                        fontSize: KJTheme.getMobileWidth(context) / 30);
                  }
                });
              },
              style: KJTheme.buttonStyle(backColor: KJTheme.nearlyBlue),
              child: Text(
                "Pay using UPI",
                style: KJTheme.titleText(
                    color: KJTheme.backGroundColor,
                    size: KJTheme.getMobileWidth(context) / 20,
                    weight: FontWeight.bold),
              )),
        ),
      ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "PDF Copy of Bill",
              style: KJTheme.titleText(
                  color: KJTheme.nearlyBlue,
                  size: KJTheme.getMobileWidth(context) / 14,
                  weight: FontWeight.bold),
            ),
          ),
          Container(
            height: 0.4,
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            width: KJTheme.getMobileWidth(context),
            color: KJTheme.nearlyGrey.withOpacity(0.6),
          ),
          Expanded(
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
          ),
        ],
      ),
    );
  }
}
