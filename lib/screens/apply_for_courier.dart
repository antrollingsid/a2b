import 'dart:io';

import 'package:a2b/Components/widgets/custom_button.dart';
import 'package:a2b/Components/widgets/custom_textfield.dart';
import 'package:a2b/screens/profile/profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/apply_controller.dart';
import '../main/utils/allConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import '../Components/widgets/app_bar_buttons.dart';
import 'createOrder/order_map.dart';
import 'dashboard/dashboard.dart';

class ApplyForCourier extends StatefulWidget {
  const ApplyForCourier({Key? key}) : super(key: key);

  @override
  State<ApplyForCourier> createState() => _ApplyForCourierState();
}

class _ApplyForCourierState extends State<ApplyForCourier>
    with TickerProviderStateMixin {
  final TextEditingController _platenocontroller = TextEditingController();
  final TextEditingController _transportcontroller = TextEditingController();

  late AnimationController loadingController;

  File? _file;
  PlatformFile? _platformFile;
  UploadTask? uploadTask;

  late String urlDownload;

  Future uploadFile() async {
    try {
      final path = 'foad/${_platformFile!.name}';
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

  selectFile() async {
    final files = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg'],
        allowMultiple: true);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: context.scaffoldBackgroundColor,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CustomAppBar(
            titleText: 'Apply for courier',
            isActionVisible: false,
            isLeadingVisible: true,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: selectFile,
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  dashPattern: const [10, 4],
                  strokeCap: StrokeCap.round,
                  color: context.primaryColor,
                  child: Container(
                    width: 333,
                    height: 264,
                    decoration: BoxDecoration(
                        // color: const Color.fromARGB(20, 40, 40, 40),
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
                              // color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'File should be jpg, png',
                          style: TextStyle(
                            fontSize: 15,
                            // color: Colors.grey.shade500
                          ),
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
                          const Text(
                            'Selected File',
                            style: TextStyle(
                              color: AppColors.backgroundLight,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: context.primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: context.scaffoldBackgroundColor,
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
                                          color: AppColors.backgroundLight,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${(_platformFile!.size / 1024).ceil()} KB',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: AppColors.backgroundLight,
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
                                                color: context.primaryColor,
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
                                                    color: context.primaryColor,
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
                            color: context.primaryColor,
                            child: const Text(
                              'Upload file',
                              style:
                                  TextStyle(color: AppColors.backgroundLight),
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 10,
              ),
              // const CustomShip(),
              // const TrackingTextField(),
              // const OrderHistoryActivity(),

              CustomTextfield(
                isPassword: false,
                hintText: 'plate no',
                mycontroller: _platenocontroller,
                width: 333,
              ),

              CustomTextfield(
                isPassword: false,
                hintText: 'transport type',
                mycontroller: _transportcontroller,
                width: 333,
              ),
              Center(
                child: CustomBtn(
                  textonbtn: 'submit',
                  onPress: () => applyForCourier(context, urlDownload,
                      _platenocontroller.text, _transportcontroller.text),
                  primary: true,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: AppColors.backgroundLight, // Choose your desired color
                width: 1.0, // Choose your desired width
              ),
            ),
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: context.scaffoldBackgroundColor,
            type: BottomNavigationBarType.fixed,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.add,
                    color: context.scaffoldBackgroundColor,
                    size: 30,
                  ),
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outlined,
                  color: AppColors.backgroundLight,
                ),
                label: '',
              ),
            ],
            selectedItemColor: context.primaryColor,
            onTap: (index) {
              if (index == 0) {
                Get.to(() => const DashBoard());
              } else if (index == 1) {
                Get.to(() => const PlaceOrderMap());
              } else if (index == 2) {
                Get.to(() => const Profile());
              }
            },
          ),
        ));
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
                  color: context.primaryColor,
                ),
                Center(
                  child: Text('${(100 * progress).roundToDouble()}%',
                      style: TextStyle(color: context.scaffoldBackgroundColor)),
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
            style: const TextStyle(color: AppColors.backgroundLight),
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
                    colors: [AppColors.secondaryDark, AppColors.primaryLight],
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
