import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:tektonlabs/src/domain/domain.dart';
import 'package:tektonlabs/src/domain/product/product_domain.dart';
import 'package:tektonlabs/src/presentation/pages/home/home_page.dart';
import 'package:tektonlabs/src/presentation/widgets/widgets.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

void main() {
  setUp(() {
    getIt.registerSingleton<ProductDomain>(
        ProductDomainImpl(ProductRepositoryImpl(MockHiveInterface())));
  });
  testWidgets(
    "Search",
    (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));
      final button = find.byIcon(Majes.search_line);
      expect(button, findsOneWidget);
      await tester.tap(button);
      await tester.pump();
      expect(find.byIcon(Majes.close_line), findsOneWidget);
    },
  );
}
