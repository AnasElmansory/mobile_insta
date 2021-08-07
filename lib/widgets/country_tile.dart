import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:insta_news_mobile/models/country.dart';
import 'package:insta_news_mobile/utils/extentions.dart';
import 'package:insta_news_mobile/controllers/settings/countries_preferences.dart';
import 'package:insta_news_mobile/utils/navigations.dart';

class CountryTile extends StatelessWidget {
  final Country country;
  final bool isInSearch;
  const CountryTile({
    Key? key,
    required this.country,
  })  : isInSearch = false,
        super(key: key);
  const CountryTile.inSearch({
    Key? key,
    required this.country,
  })  : isInSearch = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CountriesController());
    if (!isInSearch) {
      return _countryTile(country);
    } else {
      return _searchCountryTile(country);
    }
  }
}

Widget _countryTile(Country country) {
  final countryController = Get.find<CountriesController>();
  final selected = countryController.selected(country);
  return InkWell(
    onTap: () async => await navigateToCountrySourcesPage(country),
    child: GridTile(
      header: Align(
        alignment: Alignment.topLeft,
        child: Checkbox(
          shape: const CircleBorder(),
          side: const BorderSide(width: 1),
          value: selected,
          activeColor: Colors.blue,
          onChanged: (_) {},
        ),
      ),
      footer: Center(
        child: Text(country.translateCountryName).paddingAll(8),
      ),
      child: CachedNetworkImage(
        imageUrl: country.countryCode?.flagUrl ?? '',
        errorWidget: (_, __, ___) => Image.asset('user_placeholder.png'),
      ),
    ),
  );
}

Widget _searchCountryTile(Country country) {
  return Card(
    elevation: 5,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    margin: const EdgeInsets.all(16),
    child: InkWell(
      onTap: () async => await navigateToCountrySourcesPage(country),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GFListTile(
              titleText:
                  '${country.translateCountryName}\r( ${country.countryNameAr} )',
              subTitleText: 'Country\rCode:\r' + (country.countryCode ?? ''),
              avatar: CachedNetworkImage(
                imageUrl: country.countryCode?.flagUrl ?? '',
                errorWidget: (_, __, ___) =>
                    Image.asset('user_placeholder.png'),
              ),
            ),
            Wrap(
              spacing: 8,
              children: country.sources
                  .map<Chip>(
                    (source) => Chip(
                      backgroundColor: Colors.blue[600],
                      labelPadding:
                          const EdgeInsets.only(top: 4, right: 4, left: 4),
                      labelStyle: const TextStyle(color: Colors.white),
                      label: Text(
                        source.name,
                        textAlign: source.name.adaptiveTextAlign,
                        textDirection: source.name.adaptiveTextDirection,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    ),
  );
}
