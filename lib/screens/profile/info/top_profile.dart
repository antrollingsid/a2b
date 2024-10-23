// import 'package:a2b/controllers/auth_controller.dart';
// import 'package:a2b/main.dart';
// import 'package:a2b/main/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import '../../../controllers/update_profile_controller.dart';

// final UpdateProfileController ctrl = Get.put(UpdateProfileController());

// class TopProfile extends StatelessWidget {
//   const TopProfile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AuthController>(
//       builder: (controller) {
//         if (controller.isLoggedIn) {
//           print(controller.user.details.name);
//         } else {
//           print(controller.user.details.name);
//         }
//         return Center(
//           child: SizedBox(
//             width: 333,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(0, 10, 60, 0),
//                       child: Stack(children: [
//                         Container(
//                           width: 90,
//                           height: 90,
//                           decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 148, 34, 34),
//                               borderRadius: BorderRadius.circular(100),
//                               image: const DecorationImage(
//                                   image: NetworkImage(
//                                       "https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60"),
//                                   fit: BoxFit.cover)),
//                         ),
//                       ]),
//                     ),
//                     SizedBox(
//                       height: 150,
//                       child: VerticalDivider(
//                         width: 3,
//                         thickness: 2,
//                         color: appStore.isDarkMode
//                             ? AppColors.onBackgroundDark
//                             : AppColors.onBackgroundLight,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 30),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Column(
//                             mainAxisSize: MainAxisSize.max,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     language.email,
//                                     style: const TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w100,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Text(
//                                 controller.user.details.email,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           Column(
//                             mainAxisSize: MainAxisSize.max,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     language.phoneNumber,
//                                     style: const TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w100,
//                                     ),
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       _changePhoneNumberPressed(
//                                           context, ctrl.phoneNumber);
//                                     },
//                                     icon: const Icon(
//                                       Icons.edit,
//                                       size: 12,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Text(
//                                 controller.user.details.phone,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 15, 0, 40),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             controller.user.details.name,
//                             style: const TextStyle(
//                               fontSize: 36,
//                               fontWeight: FontWeight.w500,
//                               color: AppColors.backgroundLight,
//                             ),
//                           ),
//                           IconButton(
//                               onPressed: () {
//                                 _changeNamePressed(context, ctrl.name);
//                               },
//                               icon: const Icon(
//                                 Icons.edit,
//                                 size: 12,
//                               ))
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             controller.user.details.surname,
//                             style: const TextStyle(
//                               fontSize: 36,
//                               fontWeight: FontWeight.w200,
//                               // wordSpacing: 1.5,
//                               letterSpacing: 1.5,
//                               color: AppColors.textGrey,
//                             ),
//                           ),
//                           IconButton(
//                               onPressed: () {
//                                 _changeSurNamePressed(context, ctrl.surname);
//                               },
//                               icon: const Icon(
//                                 Icons.edit,
//                                 size: 12,
//                               ))
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// _changeNamePressed(context, TextEditingController mycontroller) {
//   Alert(
//       context: context,
//       title: "Change Your Firstname",
//       content: Column(
//         children: <Widget>[
//           TextField(
//             controller: mycontroller,
//             decoration: const InputDecoration(
//               icon: Icon(Icons.verified_user_rounded),
//               labelText: 'Firstname',
//             ),
//           ),
//         ],
//       ),
//       buttons: [
//         DialogButton(
//           color: AppColors.buttonBlue,
//           onPressed: () {
//             ctrl.updateName(ctrl.name.text);
//             Navigator.pop(context);
//           },
//           child: const Text(
//             "Change",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//         )
//       ]).show();
// }

// _changeSurNamePressed(context, TextEditingController mycontroller) {
//   Alert(
//       context: context,
//       title: "Change Your Surname",
//       content: Column(
//         children: <Widget>[
//           TextField(
//             controller: mycontroller,
//             decoration: const InputDecoration(
//               icon: Icon(Icons.verified_user_rounded),
//               labelText: 'Surnane',
//             ),
//           ),
//         ],
//       ),
//       buttons: [
//         DialogButton(
//           color: AppColors.buttonBlue,
//           onPressed: () {
//             ctrl.updateSurname(ctrl.surname.text);
//             Navigator.pop(context);
//           },
//           child: const Text(
//             "Change",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//         )
//       ]).show();
// }

// _changePhoneNumberPressed(context, TextEditingController mycontroller) {
//   Alert(
//       context: context,
//       title: "Change Your Number",
//       content: Column(
//         children: <Widget>[
//           TextField(
//             controller: mycontroller,
//             decoration: const InputDecoration(
//               icon: Icon(Icons.verified_user_rounded),
//               labelText: 'Phone number',
//             ),
//           ),
//         ],
//       ),
//       buttons: [
//         DialogButton(
//           color: AppColors.buttonBlue,
//           onPressed: () {
//             ctrl.updatePhoneNumber(ctrl.phoneNumber.text);
//             Navigator.pop(context);
//           },
//           child: const Text(
//             "Change",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//         )
//       ]).show();
// }
