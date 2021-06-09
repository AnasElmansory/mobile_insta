import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:insta_news_mobile/api/sources_service.dart';
import 'package:insta_news_mobile/d_injection.dart';
import 'package:insta_news_mobile/hooks/pagination_hook.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'package:insta_news_mobile/pages/pick_country_page.dart';
import 'package:insta_news_mobile/controllers/source_tabs_controller.dart';
import 'package:insta_news_mobile/widgets/search_bar.dart';
import 'package:insta_news_mobile/widgets/source_widget.dart';

class SourcesPage extends StatelessWidget {
  const SourcesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sourceTabController = Get.put(SourceTabController());
    final size = context.mediaQuerySize;
    return Obx(
      () => SafeArea(
        child: IndexedStack(
          index: sourceTabController.index,
          sizing: StackFit.expand,
          children: [
            const SourcesPart(),
            Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  width: size.width,
                  child: const SourcePageHeader(),
                ),
                const PickCountryPage(
                  showSaveAndContinue: false,
                ).marginOnly(top: 50),
              ],
            ),
          ],
        ),
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
        height: 50,
        child: GFButtonBar(
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

class SourcesPart extends HookWidget {
  const SourcesPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = context.mediaQueryPadding;
    final sourcesService = getIt<SourcesService>();
    final pagingController = usePagingController<Source>(1, sourcesService);
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          pagingController.itemList?.clear();
          pagingController.nextPageKey = 1;
          pagingController.refresh();
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            const SourcePageHeader(),
            Positioned.fill(
              child: PagedListView.separated(
                pagingController: pagingController,
                separatorBuilder: (_, __) => const Divider(),
                builderDelegate: PagedChildBuilderDelegate<Source>(
                  itemBuilder: (_, source, __) {
                    return SourceWidget(source: source);
                  },
                ),
              ).marginOnly(top: 116 + padding.top),
            ),
            Positioned.fill(
              top: 50,
              child: SearchBar<Source>(
                apiService: sourcesService,
                hint: 'search_source_hint',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
