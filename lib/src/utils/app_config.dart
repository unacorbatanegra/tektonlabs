mixin AppConfig {
  static late String versionApp;
  static late String url;

  static late bool _debug;

  static bool get isDebug => _debug;

  static void init({
    required bool isDebug,
    required String version,
    required String urlApp,
  }) {
    _debug = isDebug;
    url = urlApp;
    versionApp = version;
  }
}
