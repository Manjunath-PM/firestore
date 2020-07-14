import 'package:flutter/material.dart';

Color primaryOrange = Colors.deepOrange[400];
Color primaryGreen = Color(0xff416d6d);
Color appBarColor = Color(0xff416d6d);
Color primary_darkMode = Color.fromRGBO(18, 18, 18, 1);
Color primary_Grey = Colors.grey[800];
Color pdf_advanced_backgroud = Color.fromRGBO(236, 64, 122, 1);
Color pdf_normal_backgroud = Color.fromRGBO(0, 152, 166, 1);
List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[800], blurRadius: 3, offset: Offset(0, 0))
];

List<BoxShadow> shadowList1 = [
  BoxShadow(color: Colors.black, blurRadius: 2, offset: Offset(0, 0))
];
List<BoxShadow> shadowList2 = [
  BoxShadow(color: Colors.white, blurRadius: 3, offset: Offset(0, 0))
];

class DarkMode {
  static bool darkMode = false;
}

class Orientationclass {
  static bool setOrientation = false;
}

////////////////////////////////////////////////////////////////////////////////////////////////
List<Map> categories = [
  {
    'name': 'English',
    'iconpath': 'images/bluebook.png',
    'url':
        'https://drive.google.com/u/0/uc?id=1U0P7LfTCM153O2lUc2WCig_HowJUrvax&export=download',
  },
  {
    'name': 'kannada',
    'iconpath': 'images/brownbook.png',
    'url':
        'https://drive.google.com/u/0/uc?id=1kq0z6ujSL_1h9maxm1didXW2wbhICdJu&export=download'
  },
  {
    'name': 'Physics',
    'iconpath': 'images/greenbook.png',
    'url':
        'https://drive.google.com/u/0/uc?id=19DcAYQD0qGZs3rdKA0yZNye4dxPZJEnW&export=download'
  },
  {
    'name': 'Chemistry',
    'iconpath': 'images/pinkbook.png',
    'url':
        'https://drive.google.com/u/0/uc?id=1W_fC4MeEyQvqTbJWQOgPhyKSE1mSrLTB&export=download'
  },
  {
    'name': 'Biology',
    'iconpath': 'images/redbook.png',
    'url':
        'https://drive.google.com/u/0/uc?id=1bXskslZbTFKCH_mbsPR3cjhVWD5YspaK&export=download'
  },
  {
    'name': 'Maths',
    'iconpath': 'images/yellowbook.png',
    'url':
        'https://drive.google.com/u/0/uc?id=19DcAYQD0qGZs3rdKA0yZNye4dxPZJEnW&export=download'
  },
];
///////////////////////////////////////////////////////////////////////////////////////////////////
