import 'package:flutter/material.dart';
import 'package:insta_news_mobile/controllers/settings/font_controller.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'package:insta_news_mobile/models/twitter_models/media.dart';
import 'package:intl/intl.dart' as intl;

extension EmumX on MediaType? {
  String? typeToString() {
    if (this == MediaType.video) {
      return 'video';
    } else if (this == MediaType.photo) return 'photo';
  }
}

extension SourceX on Source {
  String get profileImageSmall => profileImageUrl ?? '';
  String get profileImageMedium =>
      profileImageUrl?.replaceFirst('normal', '200x200') ?? '';
  String get profileImageLarge =>
      profileImageUrl?.replaceFirst('normal', '400x400') ?? '';
}

extension StringX on String {
  bool get isArabic => RegExp(r'[\u0600-\u06FF]').hasMatch(this);
  TextDirection get adaptiveTextDirection =>
      isArabic ? TextDirection.rtl : TextDirection.ltr;
}

extension DateTimeX on DateTime {
  String get newsTime => intl.DateFormat('yyyy/MM/dd hh:mm').format(this);
}

extension InstaFontsX on InstaFontSize {
  double get fontSize => (this == InstaFontSize.small)
      ? 14.0
      : (this == InstaFontSize.medium)
          ? 16.0
          : 18.0;
}
