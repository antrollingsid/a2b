import 'package:a2b/Components/widgets/custom_button.dart';
import 'package:a2b/Components/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/update_profile_controller.dart';
import '../../../main/utils/allConstants.dart';
import '../../../Components/widgets/app_bar_buttons.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({key});

  @override
  State<EditProfile> createState() => _EditProfile();
}

final TextEditingController _namecontroller = TextEditingController();
final TextEditingController _surnamecontroller = TextEditingController();
final TextEditingController _phonecontroller = TextEditingController();

class _EditProfile extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundLightMode,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'Edit Profile',
          isActionVisible: false,
        ),
      ),
      body: GetBuilder<UpdateProfileController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextfield(
                isPassword: false,
                hintText: 'name...',
                mycontroller: _namecontroller,
                width: 333,
              ),
              CustomTextfield(
                isPassword: false,
                hintText: 'surename...',
                mycontroller: _surnamecontroller,
                width: 333,
              ),
              CustomTextfield(
                isPassword: false,
                hintText: 'surename...',
                mycontroller: _phonecontroller,
                width: 333,
              ),
              CustomBtn(
                textonbtn: 'update',
                onPress: () {},
                //=> 
                primary: true,
              ),
            ],
          );
        },
      ),
    );
  }
}
