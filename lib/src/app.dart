// ignore_for_file: avoid_print

import 'dart:ui';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'domain/domain.dart';
import 'domain/domains.dart';
import 'presentation/widgets/widgets.dart';
import 'routes/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus(),
      child: MaterialApp(
        locale: window.locale,
        navigatorKey: RoutesApp.navigatorKey,
        debugShowCheckedModeBanner: AppConfig.isDebug,
        title: 'Tekton Labs',
        theme: AppTheme.theme,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        scaffoldMessengerKey: DialogHelper.key,
        onGenerateRoute: RoutesApp.generateRoute,
        initialRoute: RouteName.root,
      ),
    );
  }
}
