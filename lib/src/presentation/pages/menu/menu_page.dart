import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart';
import 'package:occam/occam.dart';

import 'menu_controller.dart';

@FFRoute(name: "/menu")
class MenuPage extends StateWidget<MenuController> {
  const MenuPage({Key? key}) : super(key: key);

  @override
  MenuController createState() => MenuController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modules'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: state.logout,
            ),
          ],
        ),
      ),
    );
  }
}
