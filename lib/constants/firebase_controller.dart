import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/progress_dialog_utils.dart';

class FireController {
  static FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addData(
      {required BuildContext context,
      required String isSelected,
      required String mediaLink,
      required String videoThumbnail}) async {
    ProgressDialogUtils.showProgressDialog();
    RxString uId = "".obs;
    if (isSelected == "post") {
      int dateTime = DateTime.now().microsecondsSinceEpoch;
      DatabaseReference ref =
          FirebaseDatabase.instance.ref().child("post/${dateTime}");
      await ref.set({
        "dateTime": dateTime,
        //  "${int.parse(DateTime.now().millisecondsSinceEpoch.toString())}",
        "mediaLink": mediaLink.trim(),
        "videoThumbnail": videoThumbnail.trim(),
      }).then((value) {
        print(dateTime);
        ProgressDialogUtils.hideProgressDialog();
        print("Success");
        ShowSnackBar(context, "Success", Colors.green);
      }).catchError((error, stackTrace) {
        // error is SecondError
        print("outer: $error");
        ShowSnackBar(context, error, Colors.red);
      });
    } else {
      int dateTime = DateTime.now().microsecondsSinceEpoch;
      DatabaseReference ref =
          FirebaseDatabase.instance.ref().child("dailyThought/${dateTime}");
      await ref.set({
        "dateTime": dateTime,
        //  "${int.parse(DateTime.now().millisecondsSinceEpoch.toString())}",
        "mediaLink": mediaLink.trim(),
        "videoThumbnail": videoThumbnail.trim(),
      }).then((value) {
        ProgressDialogUtils.hideProgressDialog();
        print("Success");
        ShowSnackBar(context, "Success", Colors.green);
      }).catchError((error, stackTrace) {
        // error is SecondError
        print("outer: $error");
        ShowSnackBar(context, error, Colors.red);
      });
    }
  }
}

void ShowSnackBar(BuildContext context, String message, Color color) {
  final snackBar =
      new SnackBar(content: new Text(message), backgroundColor: color);

  // Find the Scaffold in the Widget tree and use it to show a SnackBar!
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
