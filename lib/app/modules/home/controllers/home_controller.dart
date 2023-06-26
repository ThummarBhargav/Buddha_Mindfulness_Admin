import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:http/http.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxString dropdownValue = 'post'.obs;
  Rx<TextEditingController> mediaLinkController = TextEditingController().obs;
  Rx<TextEditingController> videoThumbnaiController =
      TextEditingController().obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<FilePickerResult>? result;
  Rx<FilePickerResult>? resultThumbnail;
  RxBool hasImage = false.obs;
  RxBool hasThumbnail = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  hasValidUrl(String value) {
    String pattern =
        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter url';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid url';
    }
    return null;
  }

  Future<String> pickFile() async {
    hasImage.value = false;
    await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['mp4', 'webm', 'mov', 'jpeg', 'png', 'jpg'],
    ).then((value) {
      result = value!.obs;
      print(value.files.first.name);
      result!.refresh();
      hasImage.value = true;
      update();
    }).catchError((e) {
      print(e);
    });

    if (result != null) {
      return result!.value.files.single.name;
    } else {
      throw Exception('No video file selected.');
    }
  }

  Future<String> pickThumbnail() async {
    hasThumbnail.value = false;
    await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['jpeg', 'png', 'jpg'],
    ).then((value) {
      resultThumbnail = value!.obs;
      resultThumbnail!.refresh();
      hasThumbnail.value = true;
      update();
    }).catchError((e) {
      print(e);
    });

    if (resultThumbnail != null) {
      return resultThumbnail!.value.files.single.name;
    } else {
      throw Exception('No video file selected.');
    }
  }
}
