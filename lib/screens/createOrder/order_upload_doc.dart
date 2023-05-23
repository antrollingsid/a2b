// ignore_for_file: unused_field

import 'dart:io';

import 'package:a2b/Components/widgets/custom_button.dart';
import 'package:a2b/Components/widgets/custom_textfield.dart';
import 'package:a2b/screens/createOrder/order_map.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../controllers/order_details_text_controller.dart';
import '../../main/utils/allConstants.dart';
import '../../Components/widgets/app_bar_buttons.dart';
import 'controller/create_order_controller.dart';
import 'order_summary.dart';

class OrderUploadDoc extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const OrderUploadDoc({Key? key});

  @override
  State<OrderUploadDoc> createState() => _OrderPage();
}

// final orderPage2controller = Get.put(PackageController());

class _OrderPage extends State<OrderUploadDoc> with TickerProviderStateMixin {
  late AnimationController loadingController;
  File? _file;
  PlatformFile? _platformFile;
  UploadTask? uploadTask;
  late final String urlDownload;
  final List<PlatformFile> _uploadedFiles =
      []; // define an empty list of platform files

  Future uploadFile() async {
    try {
      final path = 'demo/${_platformFile!.name}';
      final files = File(_platformFile!.path!);

      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(files);

      final snapshot = await uploadTask!.whenComplete(() {});
      urlDownload = await snapshot.ref.getDownloadURL();
      print('download link: $urlDownload');
    } catch (e) {
      print(e);
    }
  }

  bool isChecked = false;
  selectFile() async {
    final files = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
      allowMultiple: false,
    );
    if (files != null) {
      for (int i = 0; i < files.files.length; i++) {
        setState(() {
          _file = File(files.files[i].path!);
          _platformFile = files.files[i];
        });
        await uploadFile();
      }
    }
    loadingController.forward();
  }

  @override
  void initState() {
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const <MaterialState>{
        MaterialState.pressed,
        MaterialState.focused,
      };

      return AppColors.errorDark;
    }

    final orderPage2controller = Get.put(PackageController());
    final ordercontroller = Get.put(OrderDetails());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'Additional Details',
          isActionVisible: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              CustomTextfield(
                isPassword: false,
                hintText: 'Product Name',
                mycontroller: ordercontroller.productName,
                width: 333,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomBtn(
                  textonbtn: 'Upload Picture(s) of Product',
                  onPress: selectFile,
                  primary: false),
              SizedBox(
                height: 220,
                child: _platformFile != null
                    ? Container(
                        width: 333,
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Selected File:',
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              //files here
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: context.primaryColor,
                                  width: 1.0,
                                ),
                                color: context.scaffoldBackgroundColor,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          _file!,
                                          width: 95,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _platformFile!.name,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${(_platformFile!.size / 1024).ceil()} KB',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: AppColors.textFaded,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                              height: 20,
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                      color: Colors.transparent,
                                                    ),
                                                  ),
                                                  Positioned.fill(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Container(
                                                        height: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          child: buildProcess(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ),
              SizedBox(
                width: 333,
                child: TextField(
                  maxLines: null, // allow any number of lines
                  minLines: 5, // set a minimum of 5 lines
                  keyboardType: TextInputType.multiline,
                  controller: ordercontroller.description,
                  decoration: InputDecoration(
                    hintText: 'give a brief description of your package....',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: context.primaryColor,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: context.primaryColor,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: context.primaryColor,
                        width: 1,
                      ),
                    ),
                    filled: true,
                    fillColor: context.scaffoldBackgroundColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Checkbox(
                      // checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    const Text('fragile product'),
                  ],
                ),
              ),
              CustomBtn(
                textonbtn: 'Next',
                onPress: () {
                  uploadFile();
                  try {
                    orderPage2controller.setOrderUploadDetails(
                        context,
                        ordercontroller.productName.text,
                        urlDownload,
                        ordercontroller.description.text,
                        isChecked);
                  } catch (e) {
                    print(e);
                  }
                },
                primary: true,
              ),
              // CustomBtn(
              //   textonbtn: 'Next',
              //   onPress: () => Get.to(() => const PlaceOrderMap()),
              //   primary: true,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProcess() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return SizedBox(
            height: 20,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.transparent,
                  color: Colors.transparent,
                ),
                Center(
                  child: Text('${(100 * progress).roundToDouble()}%',
                      style: const TextStyle(color: Colors.white)),
                ), // Center
              ],
            ),
          );
        } else {
          return const SizedBox(
            height: 20,
          );
        }
      });
}
//prod name,file, description, isfragile