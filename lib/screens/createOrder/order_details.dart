import 'dart:io';

import 'package:a2b/Components/widgets/custom_button.dart';
import 'package:a2b/Components/widgets/custom_textfield.dart';
import 'package:a2b/screens/place_order_map.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/order_details_text_controller.dart';
import '../../controllers/signup_text_controller.dart';
import '../../main/utils/allConstants.dart';
import '../../Components/widgets/app_bar_buttons.dart';

class OrderPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const OrderPage({Key? key});

  @override
  State<OrderPage> createState() => _OrderPage();
}

class _OrderPage extends State<OrderPage> with TickerProviderStateMixin {
  late AnimationController loadingController;
  File? _file;
  PlatformFile? _platformFile;
  UploadTask? uploadTask;

  Future uploadFile() async {
    try {
      final path = 'demo/${_platformFile!.name}';
      final files = File(_platformFile!.path!);

      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(files);

      final snapshot = await uploadTask!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      print('download link: $urlDownload');
    } catch (e) {
      print(e);
    }
  }

  selectFile() async {
    final file = await FilePicker.platform.pickFiles();

    if (file != null) {
      setState(() {
        _file = File(file.files.single.path!);
        _platformFile = file.files.first;
      });
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
    final ordercontroller = Get.put(OrderDetails());
    bool _isChecked = false;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'Order Details',
          isActionVisible: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextfield(
                isPassword: false,
                hintText: 'Product Name',
                mycontroller: ordercontroller.productName,
                width: 333,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextfield(
                    isPassword: false,
                    hintText: 'Width',
                    mycontroller: ordercontroller.width,
                    width: 164.5,
                  ),
                  const SizedBox(width: 5),
                  CustomTextfield(
                    isPassword: false,
                    hintText: 'Height',
                    mycontroller: ordercontroller.height,
                    width: 164.5,
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextfield(
                    isPassword: false,
                    hintText: 'weight, kg',
                    mycontroller: ordercontroller.weight,
                    width: 164.5,
                  ),
                  const SizedBox(width: 5),
                  CustomTextfield(
                    isPassword: false,
                    hintText: 'Type',
                    mycontroller: ordercontroller.type,
                    width: 164.5,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Material(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Colors.transparent,
                      child: Checkbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value ?? false;
                          });
                        },
                      ),
                    ),
                    const Text('Easily broken product'),
                  ],
                ),
              ),
              CustomBtn(
                  textonbtn: 'Select Product',
                  onPress: selectFile,
                  primary: false),
              Container(
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
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 1.0,
                                ),
                                color: AppColors.background,
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
                                                      color:
                                                          AppColors.background,
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
                                                          color:
                                                              AppColors.primary,
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
                                      // const SizedBox(
                                      //   width: 10,
                                      // ),
                                    ],
                                  ),
                                  CustomBtn(
                                      textonbtn: 'Upload Product',
                                      onPress: uploadFile,
                                      primary: false),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ),
              // CustomBtn(
              //     textonbtn: 'Upload Product',
              //     onPress: uploadFile,
              //     primary: true),
              // CustomCalendar(),
              // CustomShip(),

              CustomBtn(
                textonbtn: 'Next',
                onPress: () => Get.to(() => const PlaceOrderMap()),
                primary: true,
              ),
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
                  backgroundColor: Colors.grey,
                  color: AppColors.primary,
                ),
                Center(
                  child: Text('${(100 * progress).roundToDouble()}%',
                      style: const TextStyle(color: Colors.white)),
                ), // Center
              ],
            ),
          );
        } else {
          return SizedBox(
            height: 20,
          );
        }
      });
}
