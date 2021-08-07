import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/api/sources_service.dart';
import 'package:insta_news_mobile/d_injection.dart';

import 'package:insta_news_mobile/models/country.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'package:insta_news_mobile/widgets/source_widget.dart';
import 'package:lottie/lottie.dart';

class CountrySourcesPage extends StatefulWidget {
  final Country country;
  const CountrySourcesPage({
    Key? key,
    required this.country,
  }) : super(key: key);

  @override
  State<CountrySourcesPage> createState() => _CountrySourcesPageState();
}

class _CountrySourcesPageState extends State<CountrySourcesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final sourceService = getIt<SourcesService>();
  late SearchBar _searchBar;
  late ValueNotifier<List<Source>> _searchResultNotifier;
  late ValueNotifier<bool> _showIndicatorNotifier;
  Widget buildAppBar(BuildContext context) => AppBar(
        title: Text(widget.country.countryName),
        actions: [
          _searchBar.getSearchAction(context),
        ],
      );
  @override
  void initState() {
    _searchResultNotifier = ValueNotifier(const <Source>[]);
    _showIndicatorNotifier = ValueNotifier(false);
    _searchBar = SearchBar(
      setState: setState,
      buildDefaultAppBar: buildAppBar,
      onSubmitted: (query) async => await search(query),
      hintText: 'Search Sources',
    );
    super.initState();
  }

  Future<void> search(String query) async {
    _searchBar.beginSearch(context);
    _showIndicatorNotifier.value = true;
    _searchResultNotifier.value = await sourceService.searchCountrySources(
      country: widget.country.countryName,
      query: query,
    );
    _showIndicatorNotifier.value = false;
  }

  @override
  void dispose() {
    _searchResultNotifier.dispose();
    _showIndicatorNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: _searchBar.build(context),
      body: page(),
    );
  }

  Widget page() {
    if (!_searchBar.isSearching.value) {
      return CountrySourcesMain(countryName: widget.country.countryName);
    } else {
      return ValueListenableBuilder<List<Source>>(
        valueListenable: _searchResultNotifier,
        builder: (context, sources, _) => CountrySourcesSearch(
          sources: _searchResultNotifier.value,
          showIndicatorNotifier: _showIndicatorNotifier,
        ),
      );
    }
  }
}

class CountrySourcesMain extends StatelessWidget {
  final String countryName;
  const CountrySourcesMain({Key? key, required this.countryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Source>>(
      future: getIt<SourcesService>().getSourcesByCountry(countryName),
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
    );
  }
}

class CountrySourcesSearch extends StatelessWidget {
  final List<Source> sources;
  final ValueNotifier<bool> showIndicatorNotifier;
  const CountrySourcesSearch({
    Key? key,
    required this.sources,
    required this.showIndicatorNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: showIndicatorNotifier,
      builder: (context, isSearching, child) {
        final size = context.mediaQuerySize;
        return Stack(
          children: [
            Positioned.fill(
              child: child!,
            ),
            if (isSearching)
              Positioned.fill(
                child: Center(
                  child: SizedBox.square(
                    dimension: size.height * 0.15,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: Lottie.asset('assets/newspaper_spinner.json'),
                      ),
                    ),
                  ),
                ),
              )
          ],
        );
      },
      child: ListView.builder(
        itemCount: sources.length,
        itemBuilder: (context, index) => SourceWidget(source: sources[index]),
      ),
    );
  }
}
