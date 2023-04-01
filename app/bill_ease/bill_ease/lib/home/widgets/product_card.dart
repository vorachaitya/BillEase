// ignore_for_file: must_be_immutable

import 'package:bill_ease/utils/kj_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductCard extends StatefulWidget {
  ProductCard(
      {super.key,
      required this.isLast,
      required this.productController,
      required this.idController,
      required this.qtController,
      required this.qntAdd,
      required this.onDelete,
      required this.priceController,
      required this.index,
      required this.onScan,
      required this.onAdd});
  bool isLast;
  TextEditingController productController;
  TextEditingController idController;
  TextEditingController priceController;
  TextEditingController qtController;
  VoidCallback onAdd;
  VoidCallback onScan;
  VoidCallback qntAdd;
  VoidCallback onDelete;
  int index;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.grey.shade400,
            ),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${widget.index + 1}.",
                    style: KJTheme.titleText(
                        size: KJTheme.getMobileWidth(context) / 18,
                        color: KJTheme.nearlyBlue,
                        weight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: widget.productController,
                      style: KJTheme.subtitleText(
                          size: KJTheme.getMobileWidth(context) / 26,
                          color: KJTheme.nearlyGrey,
                          weight: FontWeight.bold),
                      cursorColor: KJTheme.darkishGrey,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        counter: const Offstage(),
                        labelText: "Product",
                        labelStyle: KJTheme.subtitleText(
                            size: KJTheme.getMobileWidth(context) / 24,
                            weight: FontWeight.bold,
                            color: Colors.grey.shade800),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                                color: KJTheme.nearlyBlue, width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Colors.redAccent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                                color: KJTheme.nearlyBlue, width: 2)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                              color: Colors.grey.shade400, width: 1.2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.none,
                readOnly: true,
                controller: widget.idController,
                cursorColor: KJTheme.darkishGrey,
                style: KJTheme.subtitleText(
                    size: KJTheme.getMobileWidth(context) / 26,
                    color: KJTheme.nearlyGrey,
                    weight: FontWeight.bold),
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: KJTheme.getMobileWidth(context) / 16,
                      width: KJTheme.getMobileWidth(context) / 6,
                      child: ElevatedButton(
                          onPressed: () {
                            widget.onScan();
                          },
                          style: KJTheme.buttonStyle(
                              borderColor: KJTheme.darkishGrey,
                              backColor: KJTheme.darkishGrey),
                          child: Text(
                            "Scan",
                            style: KJTheme.subtitleText(
                                size: KJTheme.getMobileWidth(context) / 30,
                                color: KJTheme.backGroundColor,
                                weight: FontWeight.bold),
                          )),
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  counter: const Offstage(),
                  labelText: "Barcode",
                  labelStyle: KJTheme.subtitleText(
                      size: KJTheme.getMobileWidth(context) / 24,
                      weight: FontWeight.bold,
                      color: Colors.grey.shade800),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                          color: KJTheme.nearlyBlue, width: 2)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.redAccent)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                          color: KJTheme.nearlyBlue, width: 2)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    borderSide:
                        BorderSide(color: Colors.grey.shade400, width: 1.2),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: widget.qtController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      cursorColor: KJTheme.darkishGrey,
                      style: KJTheme.subtitleText(
                          size: KJTheme.getMobileWidth(context) / 24,
                          color: KJTheme.nearlyGrey,
                          weight: FontWeight.bold),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              widget.qntAdd();
                            },
                            icon: Icon(
                              Icons.add,
                              size: KJTheme.getMobileWidth(context) / 16,
                              color: KJTheme.nearlyBlue,
                            )),
                        contentPadding: const EdgeInsets.only(left: 7),
                        counter: const Offstage(),
                        isDense: true,
                        prefix: Text("Qt. ",
                            style: KJTheme.subtitleText(
                                size: KJTheme.getMobileWidth(context) / 24,
                                weight: FontWeight.bold,
                                color: Colors.grey.shade400)),
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 0, minHeight: 0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                                color: KJTheme.nearlyBlue, width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Colors.redAccent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                                color: KJTheme.nearlyBlue, width: 2)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                              color: Colors.grey.shade400, width: 1.2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: widget.priceController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      cursorColor: KJTheme.darkishGrey,
                      style: KJTheme.subtitleText(
                          size: KJTheme.getMobileWidth(context) / 24,
                          color: KJTheme.nearlyGrey,
                          weight: FontWeight.bold),
                      decoration: InputDecoration(
                        labelText: "Price",
                        labelStyle: KJTheme.subtitleText(
                            size: KJTheme.getMobileWidth(context) / 24,
                            weight: FontWeight.bold,
                            color: Colors.grey.shade800),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.5, horizontal: 16),
                        counter: const Offstage(),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                                color: KJTheme.nearlyBlue, width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Colors.redAccent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                                color: KJTheme.nearlyBlue, width: 2)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                              color: Colors.grey.shade400, width: 1.2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  widget.index == 0
                      ? const SizedBox()
                      : SizedBox(
                          height: KJTheme.getMobileWidth(context) / 9.1,
                          child: IconButton(
                              onPressed: () {
                                widget.onDelete();
                              },
                              icon: Icon(
                                CupertinoIcons.delete,
                                size: KJTheme.getMobileWidth(context) / 13,
                                color: Colors.redAccent,
                              )),
                        )
                ],
              )
            ],
          ),
        ),
        Container(
            height: KJTheme.getMobileWidth(context) * 0.06,
            width: 1,
            decoration: BoxDecoration(color: Colors.grey.shade400)),
        widget.isLast
            ? GestureDetector(
                onTap: () {
                  widget.onAdd();
                },
                child: Icon(Icons.add_circle_outline_sharp,
                    color: KJTheme.darkishGrey.withOpacity(0.5)))
            : const SizedBox()
      ],
    );
  }
}
