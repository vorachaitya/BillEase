// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unnecessary_string_interpolations

import 'package:bill_ease/bills/widgets/pdf_card.dart';
import 'package:bill_ease/common/kj_store.dart';
import 'package:bill_ease/utils/kj_theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:bill_ease/customer/models/pdfmodel.dart';

class BillingHistory extends StatefulWidget {
  const BillingHistory({Key? key}) : super(key: key);

  @override
  State<BillingHistory> createState() => _BillingHistoryState();
}

class _BillingHistoryState extends State<BillingHistory> {
  KJStore store = KJStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KJTheme.backGroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 10),
                    child: Text("Bill History",
                        style: KJTheme.titleText(
                            size: KJTheme.getMobileWidth(context) / 11,
                            color: KJTheme.darkishGrey,
                            weight: FontWeight.bold)),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("View all your Decentralized bills instantly",
                        style: KJTheme.subtitleText(
                            size: KJTheme.getMobileWidth(context) / 27,
                            color: KJTheme.nearlyGrey,
                            weight: FontWeight.w500)),
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: store.getCustomerBills(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.data() == null) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Chip(
                                labelPadding: EdgeInsets.all(20),
                                label: Text(
                                  "No Bills Generated.",
                                  style: KJTheme.subtitleText(
                                      size:
                                          KJTheme.getMobileWidth(context) / 26,
                                      color: KJTheme.nearlyGrey,
                                      weight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      List<PDFModel> models = [];
                      snapshot.data!.data()!.forEach((key, value) => {
                            models.add(PDFModel(
                                name: value["name"].toString(),
                                timestamp: key.toString(),
                                ipfsLink: value["ipfs_link"].toString(),
                                total: value["total"].toString()))
                          });
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.only(top: 40, left: 0, right: 0),
                          itemCount: models.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              child: SlideAnimation(
                                horizontalOffset: 80,
                                child: FadeInAnimation(
                                  child: PDFCard(model: models[index]),
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: KJTheme.getMobileWidth(context) / 15,
                              width: KJTheme.getMobileWidth(context) / 15,
                              child: const CircularProgressIndicator(
                                  strokeWidth: 3, color: KJTheme.nearlyBlue),
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
