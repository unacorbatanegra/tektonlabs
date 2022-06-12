import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart';
import 'tektonlabs_route.dart';
export 'tektonlabs_routes.dart';
export 'tektonlabs_route.dart';

import '../presentation/pages/unknown/unknown_page.dart';

mixin RoutesApp {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static Route generateRoute(RouteSettings settings) {
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
    return onGenerateRoute(
      settings: settings,
      notFoundPageBuilder: () => const UnknownPage(),
      getRouteSettings: getRouteSettings,
    );
  }
}
