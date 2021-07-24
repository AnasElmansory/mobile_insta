import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:insta_news_mobile/api/countries_service.dart';
import 'package:insta_news_mobile/api/sources_service.dart';
import 'package:insta_news_mobile/d_injection.dart';
import 'package:insta_news_mobile/hooks/pagination_hook.dart';
import 'package:insta_news_mobile/hooks/search_hook.dart';
import 'package:insta_news_mobile/controllers/source/source_tabs_controller.dart';
import 'package:insta_news_mobile/models/country.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'package:insta_news_mobile/widgets/search/search_body.dart';

class SourcesPage extends StatelessWidget {
  const SourcesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sourceTabController = Get.put(SourceTabController());
    return Obx(
      () => IndexedStack(
        index: sourceTabController.index,
        sizing: StackFit.expand,
        children: const [
          SourcesFragment(),
          CountryFragment(),
        ],
      ),
    );
  }
}

class SourcePageHeader extends StatelessWidget {
  const SourcePageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    final sourceTabController = Get.find<SourceTabController>();
    return Obx(
      () => SizedBox(
        width: size.width * 0.7,
        height: kToolbarHeight,
        child: GFButtonBar(
          padding: const EdgeInsets.only(top: 8),
          runSpacing: 0,
          spacing: 0,
          textDirection: TextDirection.ltr,
          children: [
            SizedBox(
              width: size.width * .35,
              child: GFButton(
                text: 'sources'.tr,
                type: sourceTabController.index == 0
                    ? GFButtonType.solid
                    : GFButtonType.outline,
                padding: const EdgeInsets.all(0),
                borderShape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                onPressed: () => sourceTabController.index = 0,
              ),
            ),
            SizedBox(
              width: size.width * .35,
              child: GFButton(
                text: 'countries'.tr,
                type: sourceTabController.index == 1
                    ? GFButtonType.solid
                    : GFButtonType.outline,
                padding: const EdgeInsets.all(0),
                borderShape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                onPressed: () => sourceTabController.index = 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SourcesFragment extends HookWidget {
  const SourcesFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sourcesService = getIt<SourcesService>();
    final searchModel = useSearchHook<Source>(
      hintText: 'search_source_hint'.tr,
      service: sourcesService,
    );

    return Scaffold(
      appBar: searchModel.searchBar.build(context),
      body: (searchModel.searchBar.isSearching.value)
          ? SearchBody<Source>(notifier: searchModel.items)
          : Column(
              children: [
                const SourcePageHeader(),
                Expanded(
                  child: PaginationWidget(
                    apiService: sourcesService,
                    divider: const SizedBox(),
                  ),
                ),
              ],
            ),
    );
  }
}

class CountryFragment extends HookWidget {
  const CountryFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countryService = getIt<CountriesService>();
    final searchModel = useSearchHook<Country>(
      hintText: 'search_country_hint'.tr,
      service: countryService,
    );

    return Scaffold(
      appBar: searchModel.searchBar.build(context),
      body: (searchModel.searchBar.isSearching.value)
          ? SearchBody<Country>(notifier: searchModel.items)
          : Column(
              children: [
                const SourcePageHeader(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      'search_country'.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(child: PaginationWidget(apiService: countryService)),
              ],
            ),
    );
  }
}
