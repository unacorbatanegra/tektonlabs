import '../presentation/widgets/widgets.dart';

mixin DialogHelper {
  static final key = GlobalKey<ScaffoldMessengerState>();

  static bool isPreloading = false;

  static void hidePreloader() {
    if (!isPreloading) return;
    isPreloading = false;
    if (Navigator.canPop(dialogContext!)) {
      Navigator.of(dialogContext!).pop();
    }
  }

  static BuildContext? dialogContext;

  static ScaffoldFeatureController? controller;

  static void showError(String errors) {
    key.currentState?.clearSnackBars();
    controller = key.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red.shade800,
        behavior: SnackBarBehavior.floating,
        elevation: 12,
        margin: const EdgeInsets.all(18.0),
        padding: const EdgeInsets.all(18.0),
        content: Text(
          errors,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  static void showSuccess(String message) {
    if (isPreloading) hidePreloader();
    key.currentState?.clearSnackBars();
    controller = key.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: Palette.green,
        behavior: SnackBarBehavior.floating,
        elevation: 12,
        margin: const EdgeInsets.all(18.0),
        padding: const EdgeInsets.all(18.0),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  static Future<bool> ifDialog({
    required BuildContext context,
    required String message,
  }) async {
    final result = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Atention'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () => Navigator.of(ctx).pop(true),
          )
        ],
      ),
    ) as bool?;
    return result ?? false;
  }
}

extension DialogExtension on BuildContext {
  static bool isPreloading = false;
  static BuildContext? dialogContext;
  void hidePreloader() {
    if (dialogContext != null) {
      if (Navigator.canPop(dialogContext!)) Navigator.pop(dialogContext!);
    }
  }

  void showInfo(String message) {
    showCupertinoDialog(
      context: this,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Atention'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: Navigator.of(ctx).pop,
          )
        ],
      ),
    );
  }

  void showPreloader() async {
    if (isPreloading) return;
    isPreloading = true;
    await showDialog(
      context: this,
      builder: (ctx) {
        dialogContext = ctx;
        return Center(
          child: Container(
            height: 64,
            width: 64,
            // padding:const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        );
      },
      barrierDismissible: false,
    );
    isPreloading = false;
  }
}
