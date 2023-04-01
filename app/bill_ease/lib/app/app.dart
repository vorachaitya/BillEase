// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bill_ease/excel/upload_excel.dart';
import 'package:bill_ease/home/home.dart';
import 'package:bill_ease/settings/profile.dart';
import 'package:bill_ease/utils/kj_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
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
          const Home(),
          const UploadExcel(),
          const Profile(),
          // Scaffold(
          //   body: Center(
          //       child: ElevatedButton(
          //           onPressed: () async {
          //             SharedPreferences pref =
          //                 await SharedPreferences.getInstance();
          //             pref.remove("session").then((value) {
          //               PersistentNavBarNavigator.pushNewScreen(context,
          //                   screen: Scaffold(),
          //                   withNavBar: false,
          //                   pageTransitionAnimation:
          //                       PageTransitionAnimation.scale);
          //             });
          //           },
          //           child: Text("Logout"))),
          // ),
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
                Icons.inventory_outlined,
                size: KJTheme.getMobileWidth(context) / 17,
              ),
              inactiveColorPrimary: Colors.grey,
              activeColorSecondary: Colors.white,
              activeColorPrimary: KJTheme.nearlyBlue,
              title: "Inventory",
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
