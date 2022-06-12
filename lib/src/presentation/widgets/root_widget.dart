import 'package:flutter/foundation.dart';

import 'widgets.dart';

class RootWidget extends StatelessWidget {
  final Widget child;

  const RootWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () =>
              WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus(),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: child,
          ),
        );
      },
    );
  }

  static Widget builder(BuildContext context, Widget? child) {
    return RootWidget(child: child!);
  }

  static Widget onError(FlutterErrorDetails details) {
    if (!kReleaseMode) {
      return ErrorWidget(details);
    }
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          'Error in: ${details.exception}',
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}
