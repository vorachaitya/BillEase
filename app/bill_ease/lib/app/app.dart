// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api
import 'package:bill_ease/common/kj_store.dart';
import 'package:bill_ease/customer/customer.dart';
import 'package:bill_ease/excel/upload_excel.dart';
import 'package:bill_ease/home/home.dart';
import 'package:bill_ease/home/models/verified_user.dart';
import 'package:bill_ease/settings/profile.dart';
import 'package:bill_ease/utils/kj_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../bills/bills.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  KJStore store = KJStore();
  bool loader = false;
  late VerifiedUser user;

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  getUserDetails() {
    setState(() {
      loader = true;
    });
    store.getUserDetails().then((value) {
      setState(() {
        loader = false;
      });
      user = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (loader) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
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
                    child: Text("Rolling In",
                        style: KJTheme.titleText(
                            size: KJTheme.getMobileWidth(context) / 18,
                            color: KJTheme.nearlyGrey,
                            weight: FontWeight.bold)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text("Gathering stuffs!",
                        style: KJTheme.titleText(
                            size: KJTheme.getMobileWidth(context) / 28,
                            color: KJTheme.nearlyGrey.withOpacity(0.8),
                            weight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return buildWidget(context);
      }
    });
  }

  Widget buildWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: PersistentTabView(
        context,
        backgroundColor: KJTheme.backGroundColor,
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.easeIn,
        ),
        decoration: NavBarDecoration(
            border:
                Border(top: BorderSide(color: Colors.grey.withOpacity(0.2)))),
        screens: [
          user.userType == "retailer"
              ? Home(
                  user: user,
                )
              : Customer(user: user),
          user.userType == "retailer" ? UploadExcel() : BillingHistory(),
          Profile(
            user: user,
          ),
        ],
        items: [
          PersistentBottomNavBarItem(
              icon: Icon(CupertinoIcons.house,
                  size: KJTheme.getMobileWidth(context) / 17),
              inactiveColorPrimary: Colors.grey,
              activeColorSecondary: Colors.white,
              activeColorPrimary: KJTheme.nearlyBlue,
              title: "Home",
              textStyle: KJTheme.subtitleText(
                  size: KJTheme.getMobileWidth(context) / 30,
                  weight: FontWeight.w600)),
          PersistentBottomNavBarItem(
              icon: Icon(
                user.userType == "retailer"
                    ? Icons.inventory_outlined
                    : Icons.history_sharp,
                size: KJTheme.getMobileWidth(context) / 17,
              ),
              inactiveColorPrimary: Colors.grey,
              activeColorSecondary: Colors.white,
              activeColorPrimary: KJTheme.nearlyBlue,
              title: user.userType == "retailer" ? "Inventory" : "Bills",
              textStyle: KJTheme.subtitleText(
                  size: KJTheme.getMobileWidth(context) / 30,
                  weight: FontWeight.w600)),
          PersistentBottomNavBarItem(
              icon: Icon(
                CupertinoIcons.settings,
                size: KJTheme.getMobileWidth(context) / 17,
              ),
              inactiveColorPrimary: Colors.grey,
              activeColorSecondary: Colors.white,
              activeColorPrimary: KJTheme.nearlyBlue,
              title: "Settings",
              textStyle: KJTheme.subtitleText(
                  size: KJTheme.getMobileWidth(context) / 30,
                  weight: FontWeight.w600)),
        ],
        controller: _controller,
        confineInSafeArea: true,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: false,
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        navBarStyle: NavBarStyle.style10,
      ),
    );
  }
}
