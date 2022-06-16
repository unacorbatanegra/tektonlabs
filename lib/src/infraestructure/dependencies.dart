import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../domain/domains.dart';

final getIt = GetIt.instance;
mixin Dependencies {
  static Future<void> init(HiveInterface interface) async {
    getIt.registerSingleton<ProductDomain>(
      ProductDomainImpl(ProductRepositoryImpl(interface)),
    );
    // Get.put<UserDomain>(UserDomain(), permanent: true).init();
    // Get.put<AuthDomain>(AuthDomain(), permanent: true).init();
    // Get.put<RootDomain>(RootDomain(), permanent: true).init();
    // Get.put<ChatDomain>(ChatDomain(), permanent: true).init();
    // Get.put<ContactDomain>(ContactDomain(), permanent: true).init();
    // Get.put<AccountDomain>(AccountDomain(), permanent: true).init();
    // Get.put<OpportunityDomain>(OpportunityDomain(), permanent: true).init();
    // Get.put<CaseDomain>(CaseDomain(), permanent: true).init();
    // Get.put<MapDomain>(MapDomain(), permanent: true).init();
    // Get.put<ActivityDomain>(ActivityDomain(), permanent: true).init();
    // Get.put<EmailDomain>(EmailDomain(), permanent: true).init();
    // Get.put<FeedDomain>(FeedDomain(), permanent: true).init();

    return await handleHive(interface);
  }

  static Future<void> handleHive(HiveInterface interface) async {
    await interface.initFlutter();
    interface.registerAdapter<Product>(ProductAdapter());
    await interface.openBox('favorites');
    Future<void> open() async {
      try {
        await interface.openBox('settings');
      } on Exception {
        await interface.deleteBoxFromDisk('settings');
        return await open();

        // ignore: avoid_catching_errors
      } on HiveError {
        await interface.deleteBoxFromDisk('settings');
        return await open();
      }
      return;
    }

    await open();
    GetIt.instance.registerSingleton<ApiRepository>(ApiRepository(null));
    // Get.put<ApiRepository>(ApiRepository(), permanent: true);

    return;
  }
}
