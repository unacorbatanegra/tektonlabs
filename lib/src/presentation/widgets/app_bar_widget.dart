// import 'package:flutter/material.dart';

// class AppBarWidget extends StatelessWidget implements PreferredSize {
//   final VoidCallback? onDrawer;
//   final VoidCallback? onEndDrawer;
//   final VoidCallback onClear;
//   final bool? hasNotification;
//   final TextEditingController state.
//   final FocusNode focusNode;
//   final ValueChanged<String> onChanged;
//   final String hint;
//   final bool showClear;
//   final bool showNotification;
//   final List<Widget>? actions;

//   const AppBarWidget({
//     Key? key,
//     required this.state.
//     required this.onChanged,
//     required this.focusNode,
//     required this.hint,
//     required this.showClear,
//     required this.onClear,
//     this.hasNotification,
//     this.onDrawer,
//     this.showNotification = true,
//     this.onEndDrawer,
//     this.actions,
//     // required this.onDone,
//   }) : super(key: key);

//   static const _border = OutlineInputBorder(
//     borderSide: BorderSide.none,
//     borderRadius: BorderRadius.all(
//       Radius.circular(30.0),
//     ),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       titleSpacing: 0,
//       leading: showNotification
//           ? IconButton(
//               onPressed: onDrawer?.call,
//               icon: const Icon(Icons.menu),
//             )
//           : null,
//       title: SafeArea(
//         top: false,
//         child: SizedBox(
//           height: 35,
//           child: TextField(
//             focusNode: focusNode,
//             state. state.
//             onChanged: onChanged,
//             decoration: InputDecoration(
//               contentPadding: EdgeInsets.zero,
//               border: _border,
//               focusedBorder: _border,
//               enabledBorder: _border,
//               hintText: hint,
//               prefixIcon: const Icon(Icons.search),
//               filled: true,
//               fillColor: Colors.white,
//               hintStyle: const TextStyle(color: Colors.grey),
//               suffixIcon: Visibility(
//                 visible: showClear,
//                 child: IconButton(
//                   icon: const Icon(Icons.clear),
//                   onPressed: onClear,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       actions: [
//         if (showNotification)
//           IconButton(
//             onPressed: onEndDrawer?.call,
//             icon: Image.asset(
//               hasNotification!
//                   ? 'assets/images/notification_alert_ico.png'
//                   : 'assets/images/notification_ico.png',
//               height: 25,
//             ),
//           ),
//         ...?actions,
//       ],
//     );
//   }

//   @override
//   Widget get child => throw UnimplementedError();

//   @override
//   Size get preferredSize => const Size.fromHeight(56);
// }
