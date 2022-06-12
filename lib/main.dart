import 'package:flutter/services.dart';

import 'src/app.dart';
import 'src/infraestructure/dependencies.dart';
import 'src/presentation/widgets/widgets.dart';
import 'src/utils/utils.dart';
import 'src/version.dart';

void main() async {
  AppConfig.init(
    isDebug: true,
    urlApp: 'https://dummyjson.com',
    version: packageVersion,
  );

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ),
  );
  // import tex
  ErrorWidget.builder = RootWidget.onError;

  SystemChrome.setPreferredOrientations(
    const [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
  // Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Dependencies.init();

  // FirebaseCrashlytics.instance.crash();
  runApp(const App());
}
