import 'package:a2b/Components/widgets/custom_button.dart';
import 'package:a2b/Components/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../main/utils/allConstants.dart';
import '../../Components/widgets/app_bar_buttons.dart';

class EditProfile extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const EditProfile({Key? key});

  @override
  State<EditProfile> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _surnamecontroller = TextEditingController();
  @override
  void initState() {
    _namecontroller.dispose();

    _surnamecontroller.dispose();
    super.initState();
  }

  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 246, 246, 246),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'Edit Profile',
          isActionVisible: false,
        ),
      ),
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // CustomCalendar(),
              // CustomShip(),
              CustomTextfield(
                titleText: 'edit name',
                isPassword: false,
                hintText: 'name...',
                mycontroller: _namecontroller,
              ),
              CustomTextfield(
                titleText: 'edit surename',
                isPassword: false,
                hintText: 'surename...',
                mycontroller: _surnamecontroller,
              ),

              CustomBtn(
                textonbtn: 'update',
                onPress: () =>
                    controller.updateUserDetails(context, _namecontroller.text),
              ),
            ],
          );
        },
      ),
    );
  }
}
