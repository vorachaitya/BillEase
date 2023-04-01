import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class BillView extends StatefulWidget {
  const BillView(this.pdfLink, {Key? key}) : super(key: key);
  final pdfLink;

  @override
  State<BillView> createState() => _BillViewState();
}

class _BillViewState extends State<BillView> {
  // void test() async {
  //   Fluttertoast.showToast(msg: widget.pdfLink.toString());
  // }

  late File Pfile;
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
    var file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    setState(() {
      Pfile = file;
    });

    print(Pfile);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadNetwork();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // test();
    return Scaffold(
        appBar: AppBar(
          title: Text("Bill View"),
        ),
        body: Container(
          child: (!isLoading)
              ? (PDFView(
                  filePath: Pfile.path.toString(),
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
