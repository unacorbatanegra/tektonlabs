// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart' hide StateWidget,navigator; 

// import '../../../domain/domains.dart';

// class EndDrawerController extends StateController {
//   final list = <RemoteMessage>[].obs;

//   final service = PushNotificationService();

//   @override
//   void readyState() {
//     // OverlayStyle.setDark();
//     // OverlayStyle.setLight();
//     init();
//     super.readyState();
//   }

//   void init() {
//     list.assignAll(PushNotificationService.list.reversed);
//   }

//   void onTap(int idx) {
//     navigator.pop();
//     final m = list[idx];
//     list.removeAt(idx);
//     service.onResume(m);
//   }

//   // @override
//   // void dispose() {
//   //   // OverlayStyle.setDark();
//   //   // OverlayStyle.setLight();
//   //   super.dispose();
//   // }
// }
