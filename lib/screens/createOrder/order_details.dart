import 'package:a2b/Components/widgets/custom_button.dart';
import 'package:a2b/Components/widgets/custom_textfield.dart';
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

class _OrderPage extends State<OrderPage> {
  @override
  void initState() {
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
                  textonbtn: 'Upload Product', onPress: () {}, primary: false)
              // CustomCalendar(),
              // CustomShip(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColors.background,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.access_time,
              color: AppColors.primary,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: AppColors.primary,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.feedback_outlined,
              color: AppColors.primary,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outlined,
              color: AppColors.primary,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        onTap: (index) {
          if (index == 2) {
            // Get.to(() => const OrderPage());
          }
        },
      ),
    );
  }
}
