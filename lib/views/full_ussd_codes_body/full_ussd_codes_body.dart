// import 'package:flutter/material.dart';
// import 'package:ussd_bank_codes/views/network_option_ist_screen/network_option_list_screen.dart';
// import 'package:ussd_bank_codes/widget/textts.dart';

// class USSDCodesOptionsBody extends StatefulWidget {
//   static const String ussdCodesOptionsBody = "ussdCodesOptionsBody";
//   const USSDCodesOptionsBody({super.key});

//   @override
//   State<USSDCodesOptionsBody> createState() => _USSDCodesOptionsBodyState();
// }

// class _USSDCodesOptionsBodyState extends State<USSDCodesOptionsBody> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.green,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back_ios_new_rounded,
//               color: Colors.white,
//             )),
//         title: TextOf(
//           text: "Available USSD Codes",
//           size: 14,
//           color: Colors.white,
//           weight: FontWeight.w600,
//         ),
//       ),
//       body: const Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: NetworkOptionListScreen(),
//       ),
//     );
//   }
// }
