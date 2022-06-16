import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';
import 'package:tektonlabs/src/domain/domain.dart';
import 'package:tektonlabs/src/domain/product/product_domain.dart';
import 'package:tektonlabs/src/presentation/pages/home/home_page.dart';
import 'package:tektonlabs/src/presentation/widgets/widgets.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

void main() {
  tearDown(() async {
    await tearDownTestHive();
  });
  setUp(() async {
    AppConfig.init(
      isDebug: true,
      urlApp: 'https://dummyjson.com',
      version: '',
    );
    await setUpTestHive();
    final dio = Dio(BaseOptions(
      baseUrl: AppConfig.url,
      validateStatus: (status) => (status ?? 500) < 501,
      receiveDataWhenStatusError: true,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
    ));
    final dioAdapter = DioAdapter(dio: dio);
    dioAdapter.onGet(
      '/products',
      (server) => server.reply(
        200,
        {
          "products": [
            {
              "id": 1,
              "title": "iPhone 9",
              "description": "An apple mobile which is nothing like apple",
              "price": 549,
              "discountPercentage": 12.96,
              "rating": 4.69,
              "stock": 94,
              "brand": "Apple",
              "category": "smartphones",
              "thumbnail":
                  "https://dummyjson.com/image/i/products/1/thumbnail.jpg",
              "images": [
                "https://dummyjson.com/image/i/products/1/1.jpg",
                "https://dummyjson.com/image/i/products/1/2.jpg",
                "https://dummyjson.com/image/i/products/1/3.jpg",
                "https://dummyjson.com/image/i/products/1/4.jpg",
                "https://dummyjson.com/image/i/products/1/thumbnail.jpg"
              ]
            },
            {
              "id": 2,
              "title": "iPhone X",
              "description":
                  "SIM-Free, Model A19211 6.5-inch Super Retina HD display with OLED technology A12 Bionic chip with ...",
              "price": 899,
              "discountPercentage": 17.94,
              "rating": 4.44,
              "stock": 34,
              "brand": "Apple",
              "category": "smartphones",
              "thumbnail":
                  "https://dummyjson.com/image/i/products/2/thumbnail.jpg",
              "images": [
                "https://dummyjson.com/image/i/products/2/1.jpg",
                "https://dummyjson.com/image/i/products/2/2.jpg",
                "https://dummyjson.com/image/i/products/2/3.jpg",
                "https://dummyjson.com/image/i/products/2/thumbnail.jpg"
              ]
            },
            {
              "id": 3,
              "title": "Samsung Universe 9",
              "description":
                  "Samsung's new variant which goes beyond Galaxy to the Universe",
              "price": 1249,
              "discountPercentage": 15.46,
              "rating": 4.09,
              "stock": 36,
              "brand": "Samsung",
              "category": "smartphones",
              "thumbnail":
                  "https://dummyjson.com/image/i/products/3/thumbnail.jpg",
              "images": ["https://dummyjson.com/image/i/products/3/1.jpg"]
            },
            {
              "id": 4,
              "title": "OPPOF19",
              "description": "OPPO F19 is officially announced on April 2021.",
              "price": 280,
              "discountPercentage": 17.91,
              "rating": 4.3,
              "stock": 123,
              "brand": "OPPO",
              "category": "smartphones",
              "thumbnail":
                  "https://dummyjson.com/image/i/products/4/thumbnail.jpg",
              "images": [
                "https://dummyjson.com/image/i/products/4/1.jpg",
                "https://dummyjson.com/image/i/products/4/2.jpg",
                "https://dummyjson.com/image/i/products/4/3.jpg",
                "https://dummyjson.com/image/i/products/4/4.jpg",
                "https://dummyjson.com/image/i/products/4/thumbnail.jpg"
              ]
            },
            {
              "id": 5,
              "title": "Huawei P30",
              "description":
                  "Huawei’s re-badged P30 Pro New Edition was officially unveiled yesterday in Germany and now the device has made its way to the UK.",
              "price": 499,
              "discountPercentage": 10.58,
              "rating": 4.09,
              "stock": 32,
              "brand": "Huawei",
              "category": "smartphones",
              "thumbnail":
                  "https://dummyjson.com/image/i/products/5/thumbnail.jpg",
              "images": [
                "https://dummyjson.com/image/i/products/5/1.jpg",
                "https://dummyjson.com/image/i/products/5/2.jpg",
                "https://dummyjson.com/image/i/products/5/3.jpg"
              ]
            }
          ],
          "total": 100,
          "skip": 0,
          "limit": 5
        },
        // Reply would wait for one-sec before returning data.
        delay: const Duration(seconds: 1),
      ),
    );
    getIt.registerSingleton<ApiRepository>(ApiRepository(dio));
    getIt.registerSingleton<ProductDomain>(
        ProductDomainImpl(ProductRepositoryImpl(Hive)));
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
