// ignore_for_file: use_key_in_widget_constructors

import 'package:a2b/Components/widgets/custom_calendar.dart';
import 'package:flutter/material.dart';
import '../../main/utils/allConstants.dart';
import '../../Components/widgets/app_bar_buttons.dart';
import '../Components/widgets/custom_button.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({Key? key});

  @override
  State<ConfirmOrder> createState() => _ConfirmOrder();
}

class _ConfirmOrder extends State<ConfirmOrder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var categories = [
      "8:00 - 10:00",
      "10:00 - 12:00 ",
      "12:00 - 14:00 ",
      "14:00 - 16:00 ",
      "16:00 - 18:00 ",
      "18:00 - 20:00 ",
      "20:00 - 22:00 ",
      "22:00 - 00:00 ",
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundLightMode,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'Confirm Order',
          isActionVisible: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 333,
                child: DropdownButtonFormField(
                  items: categories.map((String category) {
                    return DropdownMenuItem(
                        value: category,
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.star),
                            Text(category),
                          ],
                        ));
                  }).toList(),
                  onChanged: (newValue) {
                    // do other stuff with _category
                    //  setState();
                  },
                  //  value: _category,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Time',
                    //  errorText: errorSnapshot.data == 0 ? Localization.of(context).categoryEmpty : null),
                  ),
                ),
              ),

              const CustomCalendar(),
              // CustomShip(),
              CustomBtn(
                onPress: () {},
                primary: true,
                textonbtn: 'Confirm Order',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
