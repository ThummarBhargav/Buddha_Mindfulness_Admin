import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/color_constant.dart';
import '../../../../constants/firebase_controller.dart';
import '../../../../constants/sizeConstant.dart';
import '../../../../utilities/buttons.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  FireController fireController = FireController();

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade100,
          title: Row(
            children: [
              Text(
                'Buddha Mindfulness Admin',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: appTheme.primaryTheme,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 8.0,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset('assets/images/bg.jpg', fit: BoxFit.cover),
              ClipRRect(
                // Clip it cleanly.
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Container(
                    color: Colors.white.withOpacity(0.9),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MySize.getHeight(500),
                          height: MySize.getHeight(400),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      filled: true,
                                      focusColor: Colors.black,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[800]),
                                      hintText: "Select  Type",
                                      fillColor: Colors.blue[100]),
                                  value: controller.dropdownValue.value,
                                  items: <String>['post', 'dailyThought']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    );
                                  }).toList(),
                                  // Step 5.
                                  onChanged: (String? newValue) {
                                    controller.dropdownValue.value = newValue!;
                                  },
                                ),
                                Spacing.height(20),
                                ElevatedButton(
                                    onPressed: () {
                                      controller.pickFile();
                                    },
                                    child: Text("Upload")),
                                Spacing.height(20),
                                Text(controller.hasImage.isFalse
                                    ? "Please select a file"
                                    : controller.result!.value.files.first.name
                                        .toString()),
                                Spacing.height(20),
                                ElevatedButton(
                                    onPressed: () {
                                      controller.pickThumbnail();
                                    },
                                    child: Text("Upload")),
                                Spacing.height(20),
                                Text(controller.hasThumbnail.isFalse
                                    ? "Please select a Thumbnail"
                                    : controller
                                        .resultThumbnail!.value.files.first.name
                                        .toString()),
                                Spacing.height(20),
                                InkWell(
                                  onTap: () async {
                                    if (!isNullEmptyOrFalse(
                                        controller.result)) {
                                      RxString videoTumbnail = "".obs;
                                      RxString medialink = "".obs;
                                      if (!isNullEmptyOrFalse(
                                          controller.resultThumbnail)) {
                                        await FirebaseStorage.instance
                                            .ref(
                                                '${controller.resultThumbnail!.value.files.first.name}')
                                            .putData(controller.resultThumbnail!
                                                .value.files.first.bytes!)
                                            .then((p0) async {
                                          videoTumbnail.value =
                                              await p0.ref.getDownloadURL();
                                        }).catchError((e) {
                                          print(e);
                                        });
                                        ;
                                      }
                                      await FirebaseStorage.instance
                                          .ref(
                                              '${controller.result!.value.files.first.name}')
                                          .putData(controller
                                              .result!.value.files.first.bytes!)
                                          .then((p0) async {
                                        medialink.value =
                                            await p0.ref.getDownloadURL();
                                      }).catchError((e) {
                                        print(e);
                                      });
                                      print("mediaLink: $medialink");
                                      await fireController.addData(
                                          context: context,
                                          isSelected:
                                              controller.dropdownValue.value,
                                          mediaLink: medialink.value,
                                          videoThumbnail: videoTumbnail.value);
                                    } else {
                                      ShowSnackBar(context,
                                          "Please select a file", Colors.red);
                                    }
                                  },
                                  child: getButton(
                                    title: 'Submit',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
