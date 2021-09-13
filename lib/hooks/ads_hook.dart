import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

class BannerAdContainer extends StatefulWidget {
  const BannerAdContainer({Key? key}) : super(key: key);

  @override
  State<BannerAdContainer> createState() => _BannerAdContainerState();
}

class _BannerAdContainerState extends State<BannerAdContainer> {
  late BannerAdController _controller;

  @override
  void initState() {
    _controller = BannerAdController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BannerAd(
      unitId: BannerAdController.testUnitId,
      size: BannerSize.ADAPTIVE,
      controller: _controller,
      builder: (context, banner) {
        if (_controller.isLoaded) {
          return banner;
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

enum NativeAdSize {
  small,
  medium,
}

class NativeAdContainer extends StatefulWidget {
  final NativeAdSize size;
  final double? height;
  const NativeAdContainer({Key? key, this.height})
      : size = NativeAdSize.small,
        super(key: key);
  const NativeAdContainer.medium({Key? key, this.height})
      : size = NativeAdSize.medium,
        super(key: key);
  @override
  State<NativeAdContainer> createState() => _NativeAdContainerState();
}

class _NativeAdContainerState extends State<NativeAdContainer> {
  late NativeAdController _controller;

  @override
  void initState() {
    _controller = NativeAdController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  AdLinearLayout Function(
          AdRatingBarView,
          AdMediaView,
          AdImageView,
          AdTextView,
          AdTextView,
          AdTextView,
          AdTextView,
          AdTextView,
          AdTextView,
          AdButtonView)
      get layout => widget.size == NativeAdSize.small
          ? smallAdTemplate
          : mediumAdTemplate;

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    final height = widget.height ??
        (widget.size == NativeAdSize.small
            ? size.height * 0.2
            : size.height * 0.4);

    return NativeAd(
      unitId: NativeAdController.testUnitId,
      buildLayout: layout,
      controller: _controller,
      height: height,
      loading: const SizedBox.shrink(),
      builder: (context, nativeAd) {
        if (_controller.isLoaded) {
          return nativeAd;
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class OpenAd {
  static showAd() async {
    final _appOpenAd = AppOpenAd();
    _appOpenAd.load(unitId: AppOpenAd.testUnitId);
    if (_appOpenAd.isLoaded) {
      await _appOpenAd.show();
      _appOpenAd.dispose();
    }
  }
}

class InterAd extends GetxController {
  late InterstitialAd _interstitialAd;
  final RxInt _navigationCounter = 0.obs;
  int get navigationCounter => _navigationCounter.value;

  set navigationCounter(int value) {
    _navigationCounter.value = value;
    if (_navigationCounter.value % 8 == 0) {
      _navigationCounter.value = 0;
      _initAd();
    }
  }

  void _initAd() async {
    await _interstitialAd.load(unitId: InterstitialAd.testUnitId);
    if (_interstitialAd.isLoaded) {
      await _interstitialAd.show();
    }
  }

  @override
  void onInit() {
    _interstitialAd = InterstitialAd();
    super.onInit();
  }

  @override
  void onClose() {
    _interstitialAd.dispose();
    super.onClose();
  }
}

AdLayoutBuilder get smallAdTemplate {
  return (
    ratingBar,
    media,
    icon,
    headline,
    advertiser,
    body,
    price,
    store,
    attribution,
    button,
  ) {
    return AdLinearLayout(
      decoration: AdDecoration(
        backgroundColor: Colors.white,
        borderRadius: AdBorderRadius.all(10),
      ),
      margin: const EdgeInsets.all(8.0),
      elevation: 5,
      width: MATCH_PARENT,
      height: MATCH_PARENT,
      gravity: LayoutGravity.center_vertical,
      padding: const EdgeInsets.all(8.0),
      children: [
        attribution,
        AdLinearLayout(
          margin: const EdgeInsets.only(top: 6.0),
          orientation: HORIZONTAL,
          children: [
            icon,
            AdExpanded(
              flex: 2,
              child: AdLinearLayout(
                width: WRAP_CONTENT,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                children: [headline, body, advertiser],
              ),
            ),
            AdExpanded(flex: 3, child: button),
          ],
        ),
      ],
    );
  };
}

AdLayoutBuilder get mediumAdTemplate {
  return (
    ratingBar,
    media,
    icon,
    headline,
    advertiser,
    body,
    price,
    store,
    attribution,
    button,
  ) {
    return AdLinearLayout(
      decoration: AdDecoration(
        backgroundColor: Colors.white,
        borderRadius: AdBorderRadius.all(10),
      ),
      elevation: 5,
      width: MATCH_PARENT,
      height: MATCH_PARENT,
      gravity: LayoutGravity.center_vertical,
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      children: [
        attribution,
        AdLinearLayout(
          padding: const EdgeInsets.only(top: 6.0),
          height: WRAP_CONTENT,
          orientation: HORIZONTAL,
          children: [
            icon,
            AdExpanded(
              flex: 2,
              child: AdLinearLayout(
                width: WRAP_CONTENT,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                children: [headline, body, advertiser],
              ),
            ),
          ],
        ),
        media,
        button
      ],
    );
  };
}
