import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:bill_ease/utils/kj_theme.dart';
import 'package:bill_ease/customer/models/pdfmodel.dart';
import 'package:bill_ease/customer/layout/bill_view_pdf_page.dart';

class BillingHistory extends StatefulWidget {
  const BillingHistory({Key? key}) : super(key: key);

  @override
  State<BillingHistory> createState() => _BillingHistoryState();
}

class _BillingHistoryState extends State<BillingHistory> {
  Stream<dynamic> getBills() {
    var user_email = FirebaseAuth.instance.currentUser!.email;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var res = firestore.collection("bills").doc('${user_email}').snapshots();
    return res;
  }

  Widget pdfCard(PDFModel pdfModel) => Card(
      child: InkWell(
          onTap: () => {
                // Fluttertoast.showToast(msg: "heeey!"),
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return BillView(pdfModel.ipfsLink);
                })))
              },
          child: Container(
              padding: EdgeInsets.all(6.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/shop.svg',
                        width: 100,
                      ),
                      SizedBox(width: KJTheme.getMobileWidth(context) / 20),
                      Text(pdfModel.name.toString().split("@")[0] + "@",
                          style: KJTheme.titleText(
                              size: KJTheme.getMobileWidth(context) / 12,
                              weight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: KJTheme.getMobileHeight(context) / 20),
                  Row(
                    children: [
                      SizedBox(width: KJTheme.getMobileWidth(context) / 20),
                      Text(
                          DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(pdfModel.timestamp.toString()))
                              .toString(),
                          style: KJTheme.subtitleText(
                              size: KJTheme.getMobileWidth(context) / 25,
                              weight: FontWeight.w500)),
                      SizedBox(width: KJTheme.getMobileWidth(context) / 5),
                      Text("Amt: " + pdfModel.total.toString(),
                          style: KJTheme.subtitleText(
                              size: KJTheme.getMobileWidth(context) / 25,
                              weight: FontWeight.w500)),
                    ],
                  )
                ],
              ))));
  @override
  void initState() {
    getBills();
    // Fluttertoast.showToast(msg: "This is rendered");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Fluttertoast.showToast(msg: "This is rendered");
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Billing History"),
      // ),
      body: Container(
        padding: EdgeInsets.all(4.0),
        child: StreamBuilder<dynamic>(
          stream: getBills(),
          builder: (context, snapshot) {
            Widget component_bills;
            if (snapshot.hasData) {
              var print_val = [];
              component_bills = Text('${snapshot.data.data()[0]}');
              snapshot.data.data().forEach((key, value) => {
                    print_val.add(PDFModel(
                        name: "${value["name"]}",
                        timestamp: "$key",
                        ipfsLink: "${value["ipfs_link"]}",
                        total: "${value["total"]}"))
                  });
              component_bills = Scrollbar(
                child: ListView.builder(
                    itemCount: print_val.length,
                    itemBuilder: (BuildContext context, int index) {
                      Fluttertoast.showToast(msg: print_val[index].toString());
                      if (index == print_val.length - 1) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(seconds: 2),
                          child: SlideAnimation(
                            horizontalOffset: 80,
                            child: FadeInAnimation(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  pdfCard(print_val[index]),
                                  // advCard(names[index].name, names[index].img),
                                  SizedBox(
                                    height: 80,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(seconds: 2),
                          child: SlideAnimation(
                            horizontalOffset: 80,
                            child: FadeInAnimation(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  pdfCard(print_val[index]),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    }),
              );
            } else {
              component_bills = CircularProgressIndicator();
            }
            return Center(child: component_bills);
          },
        ),
      ),
    );
  }
}
