import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:occam/occam.dart';
import 'package:tektonlabs/src/presentation/pages/home/home_page.dart';

import '../../widgets/widgets.dart';
import 'root_controller.dart';
import 'widgets/splash_widget.dart';

@FFRoute(name: '/', routeName: '/')
class RootPage extends StateWidget<RootController> {
  const RootPage({Key? key}) : super(key: key);
  @override
  RootController createState() => RootController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: state.onWillPop,
      child: RxWidget<bool>(
        notifier: state.isLoading,
        builder: (ctx, value) {
          if (value) return const SplashWidget();
          return Scaffold(
            key: RootController.scaffoldKey,
            body: const SafeArea(child: HomePage()).paddingOnly(bottom: 16.0),

            // body: RxWidget<int>(
            //   notifier: state.currentIndex,
            //   builder: (context, value) => IndexedStack(
            //     children: pages,
            //     index: value,
            //   ),
            // ),

            // ),
          );
        },
      ),
    );
  }
}
