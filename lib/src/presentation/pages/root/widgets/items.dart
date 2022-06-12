import '../../home/home_page.dart';
import '../../../../routes/routes.dart';
import '../../../widgets/widgets.dart';
import '../../menu/menu_page.dart';

class RootItem {
  final String name;
  final String route;
  final IconData iconData;
  final Widget child;
  final GlobalKey<NavigatorState> key;

  RootItem({
    required this.name,
    required this.iconData,
    required this.route,
    required this.child,
  }) : key = GlobalKey<NavigatorState>(debugLabel: name);
}

List<Widget> get pages => items
    .map((e) => Navigator(
        key: e.key,
        // initialRoute: e.route,
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            return MaterialPageRoute(
              builder: (_) => e.child,
            );
          }
          return RoutesApp.generateRoute(settings);
        }))
    .toList();

List<BottomNavigationBarItem> get bottoms => items
    .map((e) => BottomNavigationBarItem(
          icon: Icon(e.iconData),
          label: e.name,
          tooltip: e.name,
        ))
    .toList();
final items = [
  RootItem(
    name: "Home",
    route: '/accounts',
    iconData: Majes.receipt_text_line,
    child: const HomePage(),
  ),
  RootItem(
    child: const MenuPage(),
    name: 'More',
    route: '/menu',
    iconData: Majes.menu_line,
  ),
];
