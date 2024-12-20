import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:nb_utils/nb_utils.dart';

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
  UploadTask? uploadTask;

  Future uploadFile() async {
    try {
      final path = 'demo/${_platformFile!.name}';
      final files = File(_platformFile!.path!);

      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(files);

      final snapshot = await uploadTask!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      if (kDebugMode) {
        print('download link: $urlDownload');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'ulpaod documents',
          isActionVisible: true,
          isLeadingVisible: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
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
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'File should be jpg, png',
                          style: TextStyle(
                              fontSize: 15, color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _platformFile != null
                  ? Container(
                      width: 333,
                      padding: const EdgeInsets.only(top: 30),
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
                              color: AppColors.buttonStroke,
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    _file!,
                                    width: 70,
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
                                          color: Color.fromARGB(
                                              255, 235, 231, 231),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${(_platformFile!.size / 1024).ceil()} KB',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade500,
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
                                                    BorderRadius.circular(5),
                                                color:
                                                    AppColors.backgroundLight,
                                              ),
                                            ),
                                            Positioned.fill(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color:
                                                        AppColors.primaryLight,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
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
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            minWidth: double.infinity,
                            height: 45,
                            onPressed: uploadFile,
                            color: Colors.black,
                            child: const Text(
                              'Upload',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),

              const SizedBox(
                height: 70,
              ),
              // const CustomShip(),
              // const TrackingTextField(),
              // const OrderHistoryActivity(),
              // ElevatedButton(onPressed: uploadFile, child: const Text('upload')),
              // buildProcess(),

              // ElevatedButton(
              // onPressed: selectFile, child: const Text('select file')),
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
                  color: Colors.green,
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
