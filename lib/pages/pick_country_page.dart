import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:insta_news_mobile/hooks/pagination_hook.dart';
import 'package:insta_news_mobile/controllers/settings/countries_preferences.dart';
import 'package:insta_news_mobile/widgets/country_tile.dart';
import 'package:insta_news_mobile/widgets/search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:insta_news_mobile/api/countries_service.dart';
import 'package:insta_news_mobile/d_injection.dart';
import 'package:insta_news_mobile/models/country.dart';
import 'package:insta_news_mobile/utils/navigations.dart';

class PickCountryPage extends HookWidget {
  final bool showSaveAndContinue;
  const PickCountryPage({
    Key? key,
    this.showSaveAndContinue = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countryController = Get.put(CountriesController());
    final countryService = getIt<CountriesService>();
    final paginationController =
        usePagingController<Country>(1, countryService);
    final padding = context.mediaQueryPadding;
    final size = context.mediaQuerySize;
    final top = kToolbarHeight + padding.top + 50;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 50,
              width: size.width,
              child: Center(
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
            ),
            Positioned.fill(
              top: top,
              child: PagedListView.separated(
                pagingController: paginationController,
                separatorBuilder: (_, __) => const Divider(),
                builderDelegate: PagedChildBuilderDelegate<Country>(
                  itemBuilder: (context, country, index) {
                    return CountryTile(country: country);
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              width: size.width,
              child: Center(
                child: SizedBox(
                  width: showSaveAndContinue ? size.width * .65 : null,
                  child: GFButton(
                    text: showSaveAndContinue ? 'save_continue'.tr : 'save'.tr,
                    fullWidthButton: showSaveAndContinue,
                    borderShape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      final shared = await SharedPreferences.getInstance();
                      await shared.setStringList(
                        'countries_preference',
                        countryController.countriesPreferences
                            .map((c) => c.toJson())
                            .toList(),
                      );
                      await navigateToHomePage();
                    },
                  ),
                ),
              ),
            ),
            SearchBar<Country>(
              apiService: countryService,
              hint: 'search_country_hint'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
