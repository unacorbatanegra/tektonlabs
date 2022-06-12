import 'package:collection/collection.dart';
import 'package:occam/occam.dart';

import '../../../models/models.dart';
import '../../widgets/widgets.dart';
import 'home_controller.dart';
import 'widgets/product_widget.dart';

class HomePage extends StateWidget<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomeController createState() => HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          CupertinoButton(
            child: const Icon(Majes.table_heart_line),
            onPressed: state.toFavorites,
          )
        ],
      ),
      body: Column(
        children: [
          RxWidget<bool>(
            notifier: state.isSearching,
            builder: (ctx, isSearching) => RxWidget<int>(
              notifier: state.length,
              builder: (ctx, value) => SearchWidget(
                length: value,
                isSearching: isSearching,
                toSearch: state.toSearch,
                onFilter: state.onFilter,
                controller: state.controller,
                onChanged: state.onChanged,
              ),
            ),
          ).paddingSymmetric(horizontal: 16.0),
          Expanded(
            child: RxWidget<bool>(
              notifier: state.isLoading,
              builder: (ctx, isLoading) {
                if (isLoading) return loadingIndicator;
                return RxWidget<List<Product>>(
                  notifier: state.list,
                  builder: (ctx, list) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: state.onRefresh,
                              child: SingleChildScrollView(
                                physics: always,
                                controller: state.scroll,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: list
                                      .groupListsBy((e) => e.category)
                                      .entries
                                      .map(
                                        (e) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              e.key.capitalize
                                                  .replaceAll('-', ' '),
                                              style: context.h6?.copyWith(
                                                color: Palette.primary,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            gap8,
                                            SizedBox(
                                              width: context.w,
                                              child: GridView.count(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 16.0,
                                                mainAxisSpacing: 16.0,
                                                childAspectRatio: 13 / 16,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                children: e.value
                                                    .map(
                                                      (e) => ProductWidget(
                                                        product: e,
                                                        onTap: () =>
                                                            state.onTap(e),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                            gap18,
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                          RxWidget<bool>(
                            notifier: state.isLoadingMore,
                            builder: (ctx, value) {
                              if (value) {
                                return loadingIndicator.paddingAll(16.0);
                              }
                              return emptyWidget;
                            },
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
