import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/color_constant.dart';
import '../../../../constants/firebase_controller.dart';
import '../../../../constants/sizeConstant.dart';
import '../../../../utilities/buttons.dart';
import '../../../../utilities/text_field.dart';
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
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.white.withOpacity(0.9),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: controller.formKey,
                          child: Container(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      controller.dropdownValue.value =
                                          newValue!;
                                    },
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    child:
                                        Text("Please Enter (Image/Video) Url"),
                                  ),
                                  getTextField(
                                      hintText: "Enter (Image/Video) Url",
                                      textEditingController:
                                          controller.mediaLinkController.value,
                                      ErrorBorderColor: Colors.red,
                                      validation: (value) {
                                        return controller
                                            .hasValidUrl(value.toString());
                                      },
                                      borderRadius: 10,
                                      borderColor: Colors.black,
                                      prefixIcon: Icon(Icons.link)),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text("Please Enter Thumbnail Url"),
                                  ),
                                  getTextField(
                                      hintText: "Enter Thumbnail Url",
                                      textEditingController: controller
                                          .videoThumbnaiController.value,
                                      borderRadius: 10,
                                      borderColor: Colors.black,
                                      prefixIcon: Icon(Icons.link)),
                                  Spacing.height(20),
                                  InkWell(
                                    onTap: () async {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        await fireController.addData(
                                            context: context,
                                            isSelected:
                                                controller.dropdownValue.value,
                                            mediaLink: controller
                                                .mediaLinkController.value.text
                                                .toString()
                                                .trim(),
                                            videoThumbnail: controller
                                                .videoThumbnaiController
                                                .value
                                                .text
                                                .toString()
                                                .trim());
                                      }
                                    },
                                    child: getButton(
                                      title: 'Submit',
                                    ),
                                  ),
                                ],
                              ),
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
