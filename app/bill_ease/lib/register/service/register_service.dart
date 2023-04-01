// ignore_for_file: unnecessary_null_comparison, nullable_type_in_catch_clause

import 'package:bill_ease/common/kj_store.dart';
import 'package:bill_ease/register/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class RegisterService {
  FirebaseAuth authUser = FirebaseAuth.instance;
  KJStore store = KJStore();

  Future<dynamic> createUser(
      {required String email,
      required String password,
      required String name,
      required String phone,
      required String user_type,
      required BuildContext context}) async {
    try {
      UserCredential? creds = await authUser.createUserWithEmailAndPassword(
          email: email, password: password);
      if (creds != null) {
        await store.createUser(
            credential: creds,
            model: UserModel(
                email: email, name: name, phone: phone, user_type: user_type));
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('session', creds.user!.uid);
      }
      return creds;
    } on FirebaseAuthException catch (e) {
      SnackBar snackBar = SnackBar(content: Text(e.message!));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return null;
    }
  }

  Future<dynamic> loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential creds = await authUser.signInWithEmailAndPassword(
          email: email, password: password);
      if (creds != null) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('session', creds.user!.uid);
      }
      return creds;
    } on FirebaseAuthException catch (e) {
      SnackBar snackBar = SnackBar(content: Text(e.message!));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return null;
    }
  }

  Future<dynamic> signup(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      UserCredential creds =
          await authUser.signInWithCredential(authCredential);
      if (creds != null) {
        await store.createUser(
            credential: creds,
            model: UserModel(
                user_type: "",
                email: creds.user!.email!,
                name: creds.user!.displayName ?? "",
                phone: ""));
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('session', creds.user!.uid);
      }
      return creds;
    }
  }
}
