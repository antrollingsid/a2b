import 'dart:io';

import 'package:a2b/Components/widgets/custom_button.dart';

import '../../main/utils/allConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import '../../Components/widgets/app_bar_buttons.dart';

class PlaceOrderUpload extends StatefulWidget {
  const PlaceOrderUpload({Key? key}) : super(key: key);

  @override
  State<PlaceOrderUpload> createState() => _PlaceOrderUploadState();
}

class _PlaceOrderUploadState extends State<PlaceOrderUpload>
    with TickerProviderStateMixin {
  late AnimationController loadingController;

  File? _file;
  PlatformFile? _platformFile;

  selectFile() async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

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
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundDark,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'ulpaod documents',
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: selectFile,
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              dashPattern: const [10, 4],
              strokeCap: StrokeCap.round,
              color: Colors.blue.shade400,
              child: Container(
                width: 333,
                height: 374,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(20, 40, 40, 40),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.string(
                      SvgConstant.uploadIconDark,
                      height: 80,
                      width: 80,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Upload your file',
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    Container(
                      height: 53,
                      width: 131,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.secondaryBlue,
                      ),
                      child: const Text(
                        'Browse',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'File should be jpg, png',
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _platformFile != null
              ? Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected File',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: const Offset(0, 1),
                                  blurRadius: 3,
                                  spreadRadius: 2,
                                )
                              ]),
                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    _file!,
                                    width: 70,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _platformFile!.name,
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${(_platformFile!.size / 1024).ceil()} KB',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        height: 5,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.blue.shade50,
                                        ),
                                        child: LinearProgressIndicator(
                                          value: loadingController.value,
                                        )),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      // MaterialButton(
                      //   minWidth: double.infinity,
                      //   height: 45,
                      //   onPressed: () {},
                      //   color: Colors.black,
                      //   child: Text('Upload', style: TextStyle(color: Colors.white),),
                      // )
                    ],
                  ))
              : Container(),
          const SizedBox(
            height: 150,
          ),
          // const CustomShip(),
          // const TrackingTextField(),
          // const OrderHistoryActivity(),
          Center(
            child: CustomBtn(
              textonbtn: 'upload',
              onPress: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class TrackingTextField extends StatelessWidget {
  const TrackingTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
        height: 67,
        width: 333,
        child: Center(
          child: TextField(
            style: const TextStyle(color: AppColors.backgroundLightMode),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.string(
                  SvgConstant.searchIconDark,
                  // alignment: Alignment.center,
                  width: 19,
                  height: 19,
                ),
              ),
              hintText: 'Tracking code',
              hintStyle: const TextStyle(color: AppColors.textGrey),
              filled: true,
              fillColor: AppColors.buttonStroke,
              border: GradientOutlineInputBorder(
                gradient: const LinearGradient(
                    colors: [AppColors.secondaryBlue, AppColors.primaryDark],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(0.5, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                width: 1,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
