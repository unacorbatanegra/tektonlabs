// import 'dart:io';

// import 'package:flutter/material.dart';
// // import 'package:flutter_icons/flutter_icons.dart';
// import 'package:fluttericon/font_awesome_icons.dart';
// import 'package:get/get.dart' hide StateWidget,navigator; 
// import 'package:url_launcher/url_launcher.dart';

// import '../../employees/bloc/state./login_state.dart';
// import '../../infraestructure/hive_settings.dart';
// import '../../utils/routes.dart';
// import 'palette.dart';

// class DrawerWidget extends StatelessWidget {
//   const DrawerWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<Loginstate.(
//       init: Loginstate.),
//       builder: (_) {
//         final phone = HiveSettings.get('companyPhone') as String? ?? '';
//         return Drawer(
//           child: Container(
//             height: Get.height,
//             color: Colors.white,
//             // padding: EdgeInsets.only(top: 20),
//             child: SafeArea(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: Get.height * 0.22,
//                     width: Get.width,
//                     child: Stack(children: [
//                       Container(
//                         width: double.infinity,
//                         child: Image.asset(
//                           'assets/images/bg_drawer.png',
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(left: 15),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: 30,
//                             ),
//                             CircleAvatar(
//                               radius: Get.height * 0.05,
//                               backgroundColor: Colors.blue[800],
//                               child: CircleAvatar(
//                                 radius: (Get.height * 0.05) - 2,
//                                 child: ClipOval(
//                                     child: FutureBuilder<String>(
//                                   future: _.getProfilePicture(),
//                                   builder: (BuildContext context,
//                                       AsyncSnapshot<String> snapshot) {
//                                     if (snapshot.hasData) {
//                                       if (snapshot.data == "noFile") {
//                                         return Image.asset(
//                                             'assets/images/user.png');
//                                       } else {
//          return Image.file(File(snapshot.data!));
//                                       }
//                                     } else {
//                                       return SizedBox.shrink();
//                                     }
//                                   },
//                                 )
//                                     /*(_.getProfilePicture()!='noFile') 
//                                 ? Image.file(File(_.getProfilePicture()))
//                                 : Image.asset('assets/images/user.png')*/
//                                     ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               _.getUsernameAndLastName(),
//                               style: TextStyle(
//                                   fontFamily: 'Exo',
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ]),
//                   ),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   ListTile(
//                     onTap: () {
//                       if (!_.loadingStatusSignatureBioMetric) {
//                         navigator.pushNamed('/profile');
//                       }
//                     },
//                     leading: Image.asset('assets/images/menu-perfil.png',
//                         height: 24),
//                     title: Text(
//                       'Mi perfil',
//                       style: TextStyle(
//                           fontFamily: 'Exo',
//                           fontSize: 16,
//                           color: _.loadingStatusSignatureBioMetric
//                               ? Colors.grey[400]
//                               : Colors.grey[600]),
//                     ),
//                   ),
//                   ListTile(
//                     onTap: () {
//                       if (!_.loadingStatusSignatureBioMetric) {
//                         _.loginProccessBiometric();
//                       }
//                       //navigator.pushNamed('/configBiometrics');
//                     },
//                     leading: Image.asset('assets/images/menu-settings.png',
//                         height: 24),
//                     title: Row(
//                       children: [
//                         _.loadingStatusSignatureBioMetric
//                             ? Container(
//                                 height: 17,
//                                 width: 17,
//                                 margin: EdgeInsets.only(right: 8),
//                                 child: CircularProgressIndicator(),
//                               )
//                             : SizedBox.shrink(),
//                         Text(
//                           _.loadingStatusSignatureBioMetric
//                               ? 'Obteniendo estado..'
//                               : 'Configuración biométrica',
//                           style: TextStyle(
//                               fontFamily: 'Exo',
//                               fontSize: 16,
//                               color: Colors.grey[600]),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Visibility(
//                     visible: true,
//                     child: ListTile(
//                       onTap: () => navigator.pushNamed(RouteName.issues),
//                       leading: Icon(
//                         FontAwesome.comment,
//                         color: Palette.orange,
//                       ),
//                       // Image.asset(
//                       //   'assets/images/icons/bubbles.png',
//                       //   width: 24,
//                       //   color: Palette.orange,
//                       // ),
//                       title: Text(
//                         'Mensajería',
//                         style: TextStyle(
//                           fontFamily: 'Exo',
//                           fontSize: 16,
//                           color: _.loadingStatusSignatureBioMetric
//                               ? Colors.grey[400]
//                               : Colors.grey[600],
//                         ),
//                       ),
//                     ),
//                   ),
//                   const Spacer(),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Column(
//                       children: [
//                         ExpansionTile(
//                           leading: Image.asset(
//                             'assets/images/menu-phone.png',
//                             width: 24,
//                           ),
//                           title: Text(
//                             'Teléfonos',
//                             style: TextStyle(
//                               fontFamily: 'Exo',
//                               fontSize: 16,
//                               color: _.loadingStatusSignatureBioMetric
//                                   ? Colors.grey[400]
//                                   : Colors.grey[600],
//                             ),
//                           ),
//                           children: [
//                             Visibility(
//                               visible: phone.isNotEmpty,
//                               child: ListTile(
//                                 onTap: () async {
//                                   // storage.read<String>('companyPhone');
//                                   print(phone);
//                                   // final p = 'tel:${phone.numericOnly()}';
//                                   // print(p);

//                                   if (await canLaunch(
//                                       'tel:${phone.numericOnly()}')) {
//                                     launch('tel:${phone.numericOnly()}');
//                                   } else {
//                                     print('cannot launch');
//                                   }
//                                 },
//                                 contentPadding: EdgeInsets.only(left: 35),
//                                 leading: Image.asset(
//                                   'assets/images/menu-empresa.png',
//                                   width: 24,
//                                 ),
//                                 title: Text(
//                                   'Mi empresa',
//                                   style: TextStyle(
//                                     fontFamily: 'Exo',
//                                     fontSize: 16,
//                                     color: _.loadingStatusSignatureBioMetric
//                                         ? Colors.grey[400]
//                                         : Colors.grey[600],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             InkWell(
//                               onTap: () async {
//                                 if (await canLaunch('tel:08009992345')) {
//                                   launch('tel:08009992345');
//                                 }
//                               },
//                               child: ListTile(
//                                 contentPadding: EdgeInsets.only(left: 35),
//                                 leading: Image.asset(
//                                   'assets/images/menu-inadi.png',
//                                   width: 29,
//                                 ),
//                                 title: Text(
//                                   'INADI',
//                                   style: TextStyle(
//                                     fontFamily: 'Exo',
//                                     fontSize: 16,
//                                     color: _.loadingStatusSignatureBioMetric
//                                         ? Colors.grey[400]
//                                         : Colors.grey[600],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             InkWell(
//                               onTap: () async {
//                                 if (await canLaunch('tel:144')) {
//                                   launch('tel:144');
//                                 }
//                               },
//                               child: ListTile(
//                                 contentPadding: EdgeInsets.only(left: 35),
//                                 leading: Image.asset(
//                                     'assets/images/menu-violencia.png',
//                                     width: 24),
//                                 title: Text(
//                                   'Violencia de género',
//                                   style: TextStyle(
//                                     fontFamily: 'Exo',
//                                     fontSize: 16,
//                                     color: _.loadingStatusSignatureBioMetric
//                                         ? Colors.grey[400]
//                                         : Colors.grey[600],
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                         ListTile(
//                           onTap: () async {
//                             if (!_.loadingStatusSignatureBioMetric) {
//                               _.logout();
//                             }
//                           },
//                           leading: Image.asset('assets/images/menu-logout.png',
//                               width: 24),
//                           title: Text(
//                             'Salir',
//                             style: TextStyle(
//                                 fontFamily: 'Exo',
//                                 fontSize: 16,
//                                 color: _.loadingStatusSignatureBioMetric
//                                     ? Colors.grey[400]
//                                     : Colors.grey[600]),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
