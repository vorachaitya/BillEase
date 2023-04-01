// ignore_for_file: prefer_const_constructors, avoid_print, unused_field, must_be_immutable

import 'package:bill_ease/common/kj_store.dart';
import 'package:bill_ease/home/layout/bill_generator_page.dart';
import 'package:bill_ease/home/models/sales_data_model.dart';
import 'package:bill_ease/home/models/verified_user.dart';
import 'package:bill_ease/utils/kj_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'models/table_product_model.dart';
import 'package:bill_ease/analysis/retailer_line_chart_page.dart';

class Home extends StatefulWidget {
  Home({super.key, required this.user});
  VerifiedUser user;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  KJStore store = KJStore();

  List<TableProduct> products = <TableProduct>[
    TableProduct(product_name: "Box", quantity: 10),
    TableProduct(product_name: "Toys", quantity: 5),
    TableProduct(product_name: "Paint Box", quantity: 12),
    TableProduct(product_name: "Chocolates", quantity: 6),
    TableProduct(product_name: "Icecream", quantity: 5),
    TableProduct(product_name: "Others", quantity: 6),
  ];

  Widget bodyData() => DataTable(
      onSelectAll: (b) {},
      sortColumnIndex: 1,
      columnSpacing: KJTheme.getMobileWidth(context) * 0.2,
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text(
            "Product Name",
            style: KJTheme.titleText(
                size: KJTheme.getMobileWidth(context) / 28,
                color: KJTheme.nearlyBlue,
                weight: FontWeight.bold),
          ),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              products.sort((a, b) => a.product_name.compareTo(b.product_name));
            });
          },
          tooltip: "To display name of product name",
        ),
        DataColumn(
          label: Text(
            "Quantity",
            style: KJTheme.titleText(
                size: KJTheme.getMobileWidth(context) / 28,
                color: KJTheme.nearlyBlue,
                weight: FontWeight.bold),
          ),
          numeric: true,
          onSort: (i, b) {
            setState(() {
              products.sort((a, b) => a.quantity.compareTo(b.quantity));
            });
          },
          tooltip: "To display available quantity of product",
        ),
      ],
      rows: products
          .map(
            (name) => DataRow(
              cells: [
                DataCell(
                  Text(
                    name.product_name,
                    style: KJTheme.subtitleText(
                        size: KJTheme.getMobileWidth(context) / 30,
                        color: KJTheme.nearlyGrey.withOpacity(0.8),
                        weight: FontWeight.w600),
                  ),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(
                    name.quantity.toString(),
                    style: KJTheme.subtitleText(
                        size: KJTheme.getMobileWidth(context) / 30,
                        color: KJTheme.nearlyGrey,
                        weight: FontWeight.w600),
                  ),
                  showEditIcon: false,
                  placeholder: false,
                )
              ],
            ),
          )
          .toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KJTheme.backGroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: KJTheme.getMobileWidth(context) / 2.5,
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Hi,",
                        style: KJTheme.titleText(
                            size: KJTheme.getMobileWidth(context) * 0.12,
                            color: KJTheme.nearlyBlue,
                            weight: FontWeight.bold)),
                    TextSpan(
                        text: "\n${widget.user.name}",
                        style: KJTheme.titleText(
                            size: KJTheme.getMobileWidth(context) / 15,
                            color: KJTheme.nearlyGrey,
                            weight: FontWeight.bold))
                  ])),
                ),
                Image.asset(
                  "assets/images/dreamer.png",
                  height: KJTheme.getMobileWidth(context) / 2.5,
                  width: KJTheme.getMobileWidth(context) / 2.2,
                )
              ],
            ),
            Container(
              height: 0.4,
              margin: EdgeInsets.only(top: 10, bottom: 10),
              width: KJTheme.getMobileWidth(context),
              color: KJTheme.nearlyGrey.withOpacity(0.6),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 10),
                  child: Text("Start Scanning",
                      style: KJTheme.titleText(
                          size: KJTheme.getMobileWidth(context) / 11,
                          color: KJTheme.darkishGrey,
                          weight: FontWeight.bold)),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Generate Qr-bill using barcode Scanner",
                      style: KJTheme.subtitleText(
                          size: KJTheme.getMobileWidth(context) / 27,
                          color: KJTheme.nearlyGrey,
                          weight: FontWeight.w500)),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: BillGeneratorPage(),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.scale);
                },
                style: KJTheme.buttonStyle(
                  backColor: KJTheme.nearlyBlue,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/barcode.png",
                        height: KJTheme.getMobileWidth(context) / 4,
                        width: KJTheme.getMobileWidth(context) / 4,
                        color: KJTheme.backGroundColor,
                      ),
                      SizedBox(
                        width: KJTheme.getMobileWidth(context) / 2.25,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Scan Barcode",
                                style: KJTheme.titleText(
                                    size: KJTheme.getMobileWidth(context) / 16,
                                    color: KJTheme.darkishGrey,
                                    weight: FontWeight.bold)),
                            Text(
                                "Make sure that the barcode fits within the frame of the scanner.",
                                textAlign: TextAlign.end,
                                style: KJTheme.subtitleText(
                                    size: KJTheme.getMobileWidth(context) / 31,
                                    color: KJTheme.backGroundColor,
                                    weight: FontWeight.w600))
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            Container(
              height: 0.4,
              margin: EdgeInsets.only(top: 30, bottom: 10),
              width: KJTheme.getMobileWidth(context),
              color: KJTheme.nearlyGrey.withOpacity(0.6),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 10),
                  child: Text("Analytics",
                      style: KJTheme.titleText(
                          size: KJTheme.getMobileWidth(context) / 11,
                          color: KJTheme.darkishGrey,
                          weight: FontWeight.bold)),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Access to your analytics and data on the go.",
                      style: KJTheme.subtitleText(
                          size: KJTheme.getMobileWidth(context) / 27,
                          color: KJTheme.nearlyGrey,
                          weight: FontWeight.w500)),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Total sales",
                      style: KJTheme.titleText(
                          size: KJTheme.getMobileWidth(context) / 21,
                          color: KJTheme.nearlyBlue,
                          weight: FontWeight.w700)),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text("₹ 2253.90",
                      style: KJTheme.titleText(
                          size: KJTheme.getMobileWidth(context) / 16,
                          color: KJTheme.darkishGrey,
                          weight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: KJTheme.nearlyGrey.withOpacity(0.2),
                      )),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Draft orders",
                                style: KJTheme.titleText(
                                    size: KJTheme.getMobileWidth(context) / 26,
                                    color: KJTheme.nearlyBlue,
                                    weight: FontWeight.w600)),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text("200",
                                style: KJTheme.titleText(
                                    size: KJTheme.getMobileWidth(context) / 24,
                                    color: KJTheme.darkishGrey,
                                    weight: FontWeight.bold)),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text("Average order value",
                                style: KJTheme.titleText(
                                    size: KJTheme.getMobileWidth(context) / 26,
                                    color: KJTheme.nearlyBlue,
                                    weight: FontWeight.w600)),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text("₹ 22",
                                style: KJTheme.titleText(
                                    size: KJTheme.getMobileWidth(context) / 24,
                                    color: KJTheme.darkishGrey,
                                    weight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text("SALES OVER TIME",
                      style: KJTheme.titleText(
                          size: KJTheme.getMobileWidth(context) / 23,
                          color: KJTheme.darkishGrey,
                          weight: FontWeight.w700)),
                ),
                SizedBox(
                  height: KJTheme.getMobileHeight(context) * 0.4,
                  width: KJTheme.getMobileWidth(context),
                  child: StreamBuilder<dynamic>(
                    stream: FirebaseFirestore.instance
                        .collection("analysis")
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .snapshots(),
                    builder: (context, snapshot) {
                      Widget component_bills = Text("No Data for Analysis",
                          style: KJTheme.subtitleText(
                              size: KJTheme.getMobileWidth(context) / 27,
                              color: KJTheme.nearlyGrey,
                              weight: FontWeight.w500));
                      if (snapshot.hasData) {
                        if (snapshot.data.data() != null) {
                          component_bills = Text('${snapshot.data.data()[0]}');
                          List<FlSpot> plotPts = [];
                          var bufferHelper = {};
                          var helperList = [];
                          snapshot.data.data()?.forEach((key, value) => {
                                bufferHelper[key.toString()] = value.toString(),
                                helperList.add(int.parse(key)),
                              });

                          helperList.sort();

                          helperList.forEach((element) {
                            plotPts.add(FlSpot(
                                double.parse(element.toString()),
                                double.parse(
                                    bufferHelper[element.toString()])));
                          });

                          return LineChartRetailer(plotPts);
                        } else {
                          return Center(child: component_bills);
                        }
                      } else {
                        return Center(child: component_bills);
                      }
                    },
                  ),
                )
              ],
            ),
            Container(
              height: 0.4,
              margin: EdgeInsets.only(top: 20, bottom: 10),
              width: KJTheme.getMobileWidth(context),
              color: KJTheme.nearlyGrey.withOpacity(0.6),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 10),
                  child: Text("Current Stock",
                      style: KJTheme.titleText(
                          size: KJTheme.getMobileWidth(context) / 11,
                          color: KJTheme.darkishGrey,
                          weight: FontWeight.bold)),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "View availability of products in your inventory.",
                      style: KJTheme.subtitleText(
                          size: KJTheme.getMobileWidth(context) / 27,
                          color: KJTheme.nearlyGrey,
                          weight: FontWeight.w500)),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            bodyData()
          ],
        ),
      )),
    );
  }
}
