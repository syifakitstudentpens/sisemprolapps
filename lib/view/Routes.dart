import 'package:flutter/material.dart';
import 'package:sisemprol/data/category/Category.dart';
import 'package:sisemprol/data/jadwal/Jadwal.dart';
import 'package:sisemprol/view/page/CategoryDetailsPage.dart';
import 'package:sisemprol/view/page/ChangePasswordPage.dart';
import 'package:sisemprol/view/page/JadwalDetailsPage.dart';
import 'package:sisemprol/view/page/PrivacyPolicyPage.dart';

enum Routes {
  HOME,
  LOGIN,
}

// ignore: non_constant_identifier_names
var ROUTE_PATH = {
  Routes.HOME: '/home',
  Routes.LOGIN: '/login',
};

class NavigateHelper {
  static navigateToJadwalDetails(BuildContext context, Jadwal jadwal) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JadwalDetailsPage(jadwal)),
    );
  }

  static navigateToCategoryPage(BuildContext context, Category category) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CategoryDetailsPage(category),
      ),
    );
  }

  static navigateToChangePasswordPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChangePasswordPage(
              context: context,
            )));
  }

  static navigateToPrivacyPolicyPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PrivacyPolicyPage(),
      ),
    );
  }
}
