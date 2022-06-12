
// import 'package:flutter/material.dart';
// import 'package:get/get.dart' hide StateWidget,navigator; 

// import 'onboarding_state.dart';

// class OnboardingPage extends StateWidget<OnboardingController> {
//   const OnboardingPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         body: Stack(
//           children: const [],
//         ),
//         floatingActionButton: Obx(
//           () => Visibility(
//             visible: state.current() == 2,
//             child: TextButton(
//               child: Text(
//                 'btn_skip'.tr,
//                 style: const TextStyle(
//                   fontFamily: 'Exo',
//                   color: Colors.white,
//                   fontSize: 18,
//                 ),
//               ),
//               onPressed: state.onNext,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
