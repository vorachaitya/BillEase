// ignore_for_file: avoid_print

import 'package:bill_ease/excel/models/item_models.dart';
import 'package:bill_ease/register/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class KJStore {
  static final KJStore _apiService = KJStore._internal();

  factory KJStore() {
    return _apiService;
  }

  KJStore._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth authUser = FirebaseAuth.instance;

  Future<dynamic> createUser(
      {required UserCredential credential, required UserModel model}) async {
    try {
      await _firestore
          .collection("users")
          .doc(credential.user!.uid)
          .set(model.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<String> getUserDetails({required String uid}) async {
    try {
      var x = await _firestore.collection("users").doc(uid).get();
      return x.data()!["name"];
    } catch (e) {
      return "";
    }
  }

  Future<dynamic> uploadJson(
      {required Map<String, dynamic> json, required bool isUpdate}) async {
    try {
      if (!isUpdate) {
        await _firestore
            .collection("inventory")
            .doc(authUser.currentUser!.email!)
            .set(json);
      } else {
        await _firestore
            .collection("inventory")
            .doc(authUser.currentUser!.email!)
            .update(json);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> uploadBill({required num total, required String cid}) async {
    try {
      await FirebaseFirestore.instance
          .collection("billingHistory")
          .doc(cid.toString())
          .set({
        "name": authUser.currentUser!.email!,
        "total": total.toString(),
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<ItemModel>> getItemModels() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> x = await _firestore
          .collection("inventory")
          .doc(authUser.currentUser!.email!)
          .get();
      List<ItemModel> items = [];
      x.data()!.forEach((key, value) {
        items.add(ItemModel(barCode: key, name: value[0], price: value[1]));
      });
      return items;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
