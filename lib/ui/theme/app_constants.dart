import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import '/ui/android/contracts_page.dart';
import '/ui/android/history_page.dart';
import '/ui/android/news_page.dart';
import '/ui/android/profile_page.dart';
import '/ui/android/saved_page.dart';

class Constants {
  static const Color darkColor = Color(0XFF2A2A2D);
  static const Color darkerColor = Color(0XFF1E1E20);
  static const Color darkestColor = Color(0XFF141416);
  static const Color redColor = Color(0XFFFF426D);
  static const Color darkGreenColor = Color(0XFF008F7F);
  static const Color lightGreenColor = Color(0XFF00A795);
  static String invoice = 'invoice'.tr();
  static const pages = <Widget>[
    ContractsPage(),
    HistoryPage(),
    NewsPage(),
    SavedPage(),
    ProfilePage(),
  ];
  static List<String> titles = [
    'contract'.tr(),
    'history'.tr(),
    'news'.tr(),
    'saved'.tr(),
    'profile'.tr()
  ];
}
