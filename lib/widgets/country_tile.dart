import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:insta_news_mobile/models/country.dart';
import 'package:insta_news_mobile/controllers/settings/countries_preferences.dart';

class CountryTile extends StatelessWidget {
  final Country country;
  const CountryTile({
    Key? key,
    required this.country,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countryController = Get.find<CountriesController>();

    return Obx(
      () {
        final selected = countryController.selected(country);
        return GFListTile(
          onTap: () => countryController.handleThis(country),
          titleText: country.countryName,
          subTitleText: 'Country Code: ' + (country.countryCode ?? ''),
          selected: selected,
          color: selected ? Colors.blue : Colors.grey,
          description: Wrap(
            runSpacing: 8,
            spacing: 8,
            children: country.countryAliases
                .map<Chip>((alias) => Chip(
                      label: Text(alias),
                      backgroundColor: Colors.white,
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
