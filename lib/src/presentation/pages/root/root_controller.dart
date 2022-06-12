import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:get/get.dart' hide navigator;
import 'package:occam/occam.dart';

import 'root_page.dart';
import 'widgets/items.dart';

class RootController extends StateController<RootPage> {
  final isLoading = true.rx;
  final currentIndex = 0.rx;

  // final domain = Get.find<UserDomain>();
  // final root = Get.find<RootDomain>();

  @override
  void readyState() {
    init();
  }

  void init() async {
    // await 1.delay();
    isLoading.value = false;
    // update(['root']);
  }

  void onIndexChanged(int idx) {
    if (idx == currentIndex()) {
      final inner = items[idx].key;
      inner.currentState?.popUntil((route) => route.isFirst);
      // final page = '${Get.currentRoute}tab:${currentChild.toString()}';
      // RoutesApp.observer.analytics.setCurrentScreen(screenName: page);
    }
    currentIndex(idx);
  }

  BuildContext get navContext => items[currentIndex()].key.currentContext!;

  static bool hasNotification = false;

  static final scaffoldKey = GlobalKey<ScaffoldState>();

  static void openDrawer() => scaffoldKey.currentState?.openDrawer();

  static void openEndDrawer() {
    hasNotification = false;
    scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  void dispose() {
    // sub?.cancel();
    super.dispose();
  }

  Future<bool> onWillPop() async {
    final nav = items[currentIndex()].key;
    if (nav.currentState?.canPop() == true) {
      nav.currentState?.pop();
      return false;
    }
    return true;
  }
}
