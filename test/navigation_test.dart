import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:tektonlabs/src/domain/domain.dart';
import 'package:tektonlabs/src/presentation/pages/favorites/favorites_page.dart';
import 'package:tektonlabs/src/presentation/pages/home/home_page.dart';
import 'package:tektonlabs/src/presentation/widgets/widgets.dart';
import 'package:tektonlabs/src/routes/routes.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockHiveInterface extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box {}

void main() {
  MockHiveInterface mockHiveInterface;
  MockHiveBox mockHiveBox;

  setUp(() {
    mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockHiveBox();
    Dependencies.init(mockHiveInterface);
  });
  testWidgets('Favorite', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    await tester.pumpWidget(
      MaterialApp(
        home: const HomePage(),
        onGenerateRoute: RoutesApp.generateRoute,
        navigatorObservers: [mockObserver],
      ),
    );
    final fav = find.byIcon(Majes.table_heart_line);
    expect(fav, findsOneWidget);
    await tester.tap(fav);
    await tester.pumpAndSettle();
    expect(find.byType(FavoritesPage), findsOneWidget);
  });
}
