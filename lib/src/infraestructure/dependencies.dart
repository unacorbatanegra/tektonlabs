import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../domain/domains.dart';

final getIt = GetIt.instance;
mixin Dependencies {
  static Future<void> init() async {
    getIt.registerSingleton<ProductDomain>(
      ProductDomainImpl(ProductRepositoryImpl()),
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

    return await handleHive();
  }

  static Future<void> handleHive() async {
    await Hive.initFlutter();
    Future<void> open() async {
      try {
        await Hive.openBox('settings');
      } on Exception {
        await Hive.deleteBoxFromDisk('settings');
        return await open();

        // ignore: avoid_catching_errors
      } on HiveError {
        await Hive.deleteBoxFromDisk('settings');
        return await open();
      }
      return;
    }

    await open();
    GetIt.instance.registerSingleton<ApiRepository>(ApiRepository());
    // Get.put<ApiRepository>(ApiRepository(), permanent: true);

    return;
  }
}
