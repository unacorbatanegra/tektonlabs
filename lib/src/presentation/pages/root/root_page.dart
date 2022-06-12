import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:occam/occam.dart';

import '../../widgets/widgets.dart';
import 'root_controller.dart';
import 'widgets/items.dart';
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
            body: RxWidget<int>(
              notifier: state.currentIndex,
              builder: (context, value) => IndexedStack(
                children: pages,
                index: value,
              ),
            ),
            bottomNavigationBar: RxWidget(
              notifier: state.currentIndex,
              builder: (ctx, value) => BottomNavigationBar(
                items: bottoms,
                onTap: state.onIndexChanged,
                currentIndex: state.currentIndex(),
              ),
            ),
          );
        },
      ),
    );
  }
}
