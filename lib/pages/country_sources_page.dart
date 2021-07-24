import 'package:flutter/material.dart';
import 'package:insta_news_mobile/api/sources_service.dart';
import 'package:insta_news_mobile/d_injection.dart';

import 'package:insta_news_mobile/models/country.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'package:insta_news_mobile/widgets/source_widget.dart';
import 'package:lottie/lottie.dart';

class CountrySourcesPage extends StatelessWidget {
  final Country country;
  const CountrySourcesPage({
    Key? key,
    required this.country,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country.countryName),
      ),
      body: FutureBuilder<List<Source>>(
        future:
            getIt<SourcesService>().getSourcesByCountry(country.countryName),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Lottie.asset('assets/newspaper_spinner.json'));
          } else {
            final sources = snapshot.data!;
            return ListView.builder(
              itemCount: sources.length,
              itemBuilder: (_, index) {
                final source = sources[index];
                return SourceWidget(source: source);
              },
            );
          }
        },
      ),
    );
  }
}
