// ignore_for_file: must_be_immutable, unused_import, unnecessary_brace_in_string_interps, non_constant_identifier_names, avoid_print, import_of_legacy_library_into_null_safe

import 'dart:async';
import 'dart:io';
import 'package:bill_ease/common/kj_store.dart';
import 'package:bill_ease/excel/models/item_models.dart';
import 'package:bill_ease/home/layout/qr_generator_page.dart';
import 'package:bill_ease/utils/kj_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ipfs/flutter_ipfs.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class PDFGeneratorPage extends StatefulWidget {
  PDFGeneratorPage({super.key, required this.models});
  List<ItemModel> models;
  @override
  State<PDFGeneratorPage> createState() => _PDFGeneratorPageState();
}

class _PDFGeneratorPageState extends State<PDFGeneratorPage> {
  num totalCost = 0;
  late File file;
  KJStore store = KJStore();
  String cid_file = "";
  List<List<String>> list_of_items = [
    ["Product", "Price", "Quantity"]
  ];
  bool loading = false;
  // final Completer<PDFViewController> _controller =
  //     Completer<PDFViewController>();
  int? pages = 0;
  bool isReady = false;

  Future<List<int>> generateDocument() async {
    final pw.Document doc = pw.Document();
    doc.addPage(pw.MultiPage(
        pageFormat:
            PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (pw.Context context) {
          if (context.pageNumber == 1) {
            return pw.SizedBox();
          }
          return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              decoration: const pw.BoxDecoration(
                  border: pw.Border(
                      bottom:
                          pw.BorderSide(width: 0.5, color: PdfColors.grey))),
              child: pw.Text('Portable Document Format',
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.grey)));
        },
        build: (pw.Context context) => <pw.Widget>[
              pw.Table.fromTextArray(
                context: context,
                data: list_of_items,
              ),
              pw.Paragraph(text: ""),
              pw.Paragraph(text: "Subtotal: ${totalCost}"),
              pw.Padding(padding: const pw.EdgeInsets.all(10)),
            ]));
    return doc.save();
  }

  @override
  void initState() {
    convertio();
    getPdf();
    super.initState();
  }

  void convertio() {
    for (ItemModel x in widget.models) {
      totalCost += int.parse(x.qt!) * int.parse(x.price);
      list_of_items.add([x.name, x.price, x.qt!]);
    }
    setState(() {});
  }

  void getPdf() async {
    setState(() {
      loading = true;
    });
    List<int> uint8list = await generateDocument();
    Directory output = await getTemporaryDirectory();
    String time_stamp = "tush";
    file = File("${output.path}/${time_stamp}.pdf");
    file.writeAsBytes(uint8list).then((value) async {
      try {
        cid_file = await FlutterIpfs().uploadToIpfs(file.path);
        store.uploadBill(cid: cid_file, total: totalCost).then((value) {
          setState(() {
            loading = false;
          });
        });
      } catch (e) {
        setState(() {
          loading = false;
        });
        print(e.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (_) {
      if (loading) {
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
                  child: Text("Hang Tight!",
                      style: KJTheme.titleText(
                          size: KJTheme.getMobileWidth(context) / 18,
                          color: KJTheme.nearlyGrey,
                          weight: FontWeight.bold)),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("Generating your pdf.",
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
                PersistentNavBarNavigator.pushNewScreen(context,
                    screen: QrGeneratorPage(
                        cid_data: "https://ipfs.io/ipfs/$cid_file"),
                    pageTransitionAnimation: PageTransitionAnimation.scale,
                    withNavBar: false);
              },
              style: KJTheme.buttonStyle(backColor: KJTheme.nearlyBlue),
              child: Text(
                "Generate Qr",
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
          "Generate PDF",
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
            child: PdfView(path: file.path),
            // child: PDFView(
            //   filePath: file.path,
            //   enableSwipe: true,
            //   swipeHorizontal: true,
            //   autoSpacing: false,
            //   pageFling: false,
            //   onRender: (x) {
            //     setState(() {
            //       pages = x;
            //       isReady = true;
            //     });
            //   },
            //   onError: (error) {
            //     print(error.toString());
            //   },
            //   onPageError: (page, error) {
            //     print('$page: ${error.toString()}');
            //   },
            //   onViewCreated: (PDFViewController pdfViewController) {
            //     _controller.complete(pdfViewController);
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}
