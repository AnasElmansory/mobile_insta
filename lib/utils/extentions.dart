import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/models/country.dart';
import 'package:insta_news_mobile/models/news.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'package:insta_news_mobile/models/twitter_models/media.dart';
import 'package:insta_news_mobile/models/user.dart';
import 'package:intl/intl.dart' as intl;

extension MediaTypeX on MediaType? {
  String? typeToString() {
    if (runtimeType == MediaType.video) {
      return 'video';
    } else if (this == MediaType.photo) {
      return 'photo';
    } else if (this == MediaType.gif) return 'animated_gif';
  }
}

extension SourceX on Source {
  String get profileImageSmall => profileImageUrl ?? '';
  String get profileImageMedium =>
      profileImageUrl?.replaceFirst('normal', '200x200') ?? '';
  String get profileImageLarge =>
      profileImageUrl?.replaceFirst('normal', '400x400') ?? '';
}

extension StringX on String? {
  bool get isArabic => RegExp(r'[\u0600-\u06FF]').hasMatch(this!);
  TextDirection get adaptiveTextDirection =>
      isArabic ? TextDirection.rtl : TextDirection.ltr;
  TextAlign get adaptiveTextAlign =>
      isArabic ? TextAlign.right : TextAlign.left;

  String get profileImageSmall => this ?? '';
  String get profileImageMedium =>
      this?.replaceFirst('normal', '200x200') ?? '';
  String get profileImageLarge => this?.replaceFirst('normal', '400x400') ?? '';
}

extension StringX2 on String {
  String get flagUrl => 'https://www.countryflags.io/$this/flat/64.png';
  String get replaceArabicNumber {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = [
      '\u0660 ',
      '\u0661 ',
      '\u0662 ',
      '\u0663 ',
      '\u0664 ',
      '\u0665 ',
      '\u0666 ',
      '\u0666 ',
      '\u0667 ',
      '\u0668 ',
      '\u0669 '
    ];
    String input = this;
    if (Get.locale?.languageCode == 'ar') {
      for (int i = 0; i < english.length; i++) {
        input = input.replaceAll(english[i], arabic[i]);
      }
    }
    return input.trim();
  }
}

extension CountryX on Country {
  String get translateCountryName =>
      (Get.locale?.languageCode == 'ar') ? countryNameAr : countryName;
}

extension DateTimeX on DateTime {
  String get newsTime {
    intl.DateFormat.shouldUseNativeDigitsByDefaultFor(
        Get.locale?.languageCode ?? 'en');
    final now = DateTime.now();
    final dif = now.difference(this);

    if (dif.inSeconds < 60) {
      return dif.inSeconds.toString().replaceArabicNumber + '\r' + 'sec'.tr;
    } else if (dif.inMinutes < 60) {
      return dif.inMinutes.toString().replaceArabicNumber + '\r' + 'min'.tr;
    } else if (dif.inHours < 24) {
      return dif.inHours.toString().replaceArabicNumber + '\r' + 'hour'.tr;
    } else if (dif.inDays < 30) {
      return dif.inDays.toString().replaceArabicNumber + '\r' + 'day'.tr;
    } else {
      return (dif.inDays / 30).floor().toString().replaceArabicNumber +
          '\r' +
          'months'.tr;
    }
  }
}

extension UserX on User {
  bool get isGuest => provider == 'guest';
}

extension LocaleAlignX on Locale? {
  Alignment get adaptiveWidgetAlignment =>
      (this?.languageCode == 'ar') ? Alignment.topLeft : Alignment.topRight;
  RoundedRectangleBorder get adaptiveRoundedBorder =>
      (this?.languageCode == 'ar')
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            )
          : const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            );
}
