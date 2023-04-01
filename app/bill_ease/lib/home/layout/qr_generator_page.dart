// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:bill_ease/app/app.dart';
import 'package:bill_ease/common/kj_store.dart';
import 'package:bill_ease/utils/kj_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGeneratorPage extends StatefulWidget {
  QrGeneratorPage({super.key, required this.cid_data});
  String cid_data;
  @override
  State<QrGeneratorPage> createState() => _QrGeneratorPageState();
}

class _QrGeneratorPageState extends State<QrGeneratorPage> {
  KJStore store = KJStore();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: KJTheme.backGroundColor,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: KJTheme.getMobileWidth(context) / 8,
            child: ElevatedButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: const App(),
                      pageTransitionAnimation: PageTransitionAnimation.scale);
                },
                style: KJTheme.buttonStyle(backColor: KJTheme.nearlyBlue),
                child: Text(
                  "DONE",
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
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "QR Bill",
            style: KJTheme.titleText(
                color: KJTheme.nearlyBlue,
                size: KJTheme.getMobileWidth(context) / 13,
                weight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _auth.currentUser!.displayName == null
                  ? Center(
                      child: FutureBuilder(
                          future:
                              store.getUserDetails(uid: _auth.currentUser!.uid),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              return SizedBox(
                                width: KJTheme.getMobileWidth(context),
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: snapshot.data,
                                          style: KJTheme.titleText(
                                              size: KJTheme.getMobileWidth(
                                                      context) /
                                                  16,
                                              color: KJTheme.darkishGrey,
                                              weight: FontWeight.bold)),
                                      TextSpan(
                                          text: "\n${_auth.currentUser!.email}",
                                          style: KJTheme.subtitleText(
                                              size: KJTheme.getMobileWidth(
                                                      context) /
                                                  28,
                                              color: KJTheme.nearlyGrey
                                                  .withOpacity(0.8),
                                              weight: FontWeight.w500))
                                    ])),
                              );
                            } else {
                              return RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "User",
                                        style: KJTheme.titleText(
                                            size: KJTheme.getMobileWidth(
                                                    context) /
                                                16,
                                            color: KJTheme.darkishGrey,
                                            weight: FontWeight.bold)),
                                    TextSpan(
                                        text: "\nuser@gmail.com",
                                        style: KJTheme.subtitleText(
                                            size: KJTheme.getMobileWidth(
                                                    context) /
                                                28,
                                            color: KJTheme.nearlyGrey
                                                .withOpacity(0.8),
                                            weight: FontWeight.w500))
                                  ]));
                            }
                          }),
                    )
                  : Center(
                      child: SizedBox(
                        width: KJTheme.getMobileWidth(context),
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: _auth.currentUser!.displayName,
                                  style: KJTheme.titleText(
                                      size:
                                          KJTheme.getMobileWidth(context) / 16,
                                      color: KJTheme.darkishGrey,
                                      weight: FontWeight.bold)),
                              TextSpan(
                                  text: "\n${_auth.currentUser!.email}",
                                  style: KJTheme.subtitleText(
                                      size:
                                          KJTheme.getMobileWidth(context) / 28,
                                      color:
                                          KJTheme.nearlyGrey.withOpacity(0.8),
                                      weight: FontWeight.w500))
                            ])),
                      ),
                    ),
              SizedBox(
                height: KJTheme.getMobileWidth(context) / 10,
              ),
              QrImage(
                data: widget.cid_data,
                size: KJTheme.getMobileHeight(context) * 0.33,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: KJTheme.getMobileWidth(context) / 1.3,
                alignment: Alignment.center,
                child: Text(
                  "Scan QR with your mobile phone or with the help of our App to get your Qr-Bill.",
                  textAlign: TextAlign.center,
                  style: KJTheme.subtitleText(
                      color: KJTheme.nearlyGrey,
                      size: KJTheme.getMobileWidth(context) / 28,
                      weight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
