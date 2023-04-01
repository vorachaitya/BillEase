// ignore_for_file: unnecessary_string_interpolations, must_be_immutable

import 'package:bill_ease/customer/models/pdfmodel.dart';
import 'package:bill_ease/utils/kj_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../layout/bill_view_pdf_page.dart';

class PDFCard extends StatefulWidget {
  PDFCard({super.key, required this.model});
  PDFModel model;
  @override
  State<PDFCard> createState() => _PDFCardState();
}

class _PDFCardState extends State<PDFCard> {
  String date = "";
  DateFormat formatter = DateFormat("yyyy-MM-dd HH:mm");

  @override
  void initState() {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(widget.model.timestamp));
    date = DateFormat("dd/MM/yyyy").format(dateTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return BillView(widget.model.ipfsLink);
              })))
            },
        child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: KJTheme.darkishGrey.withOpacity(0.3),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/images/shop.svg',
                  width: KJTheme.getMobileWidth(context) / 3.2,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.model.name.split("@")[0],
                      style: KJTheme.titleText(
                          size: KJTheme.getMobileWidth(context) / 18,
                          weight: FontWeight.bold),
                    ),
                    Chip(
                        backgroundColor: KJTheme.nearlyBlue,
                        label: Text(
                          "₹ ${widget.model.total}",
                          style: KJTheme.titleText(
                              color: KJTheme.backGroundColor,
                              size: KJTheme.getMobileWidth(context) / 22,
                              weight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Paid on:  ",
                              style: KJTheme.titleText(
                                  size: KJTheme.getMobileWidth(context) / 28,
                                  color: KJTheme.darkishGrey,
                                  weight: FontWeight.bold)),
                          TextSpan(
                              text: date,
                              style: KJTheme.subtitleText(
                                  size: KJTheme.getMobileWidth(context) / 30,
                                  color: KJTheme.nearlyBlue,
                                  weight: FontWeight.bold))
                        ]))
                      ],
                    )
                  ],
                )
              ],
            )));
  }
}
