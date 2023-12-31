import 'package:flutter/material.dart';

bool isLight(BuildContext context) {
  return Theme.of(context).brightness == Brightness.light;
}

dynamic findResource(key, BuildContext context) {
  switch (Theme.of(context).brightness) {
    case Brightness.light:
      return lightMap[key];
    case Brightness.dark:
      return darkMap[key];
  }
}

class ConstKey {
  static const String MAIN_NAVIGATIONBAR_BG_COLOR =
      "main_navigationbar_bg_color";
}

Map<String, dynamic> lightMap = {
  ConstKey.MAIN_NAVIGATIONBAR_BG_COLOR: Colors.white,
};

Map<String, dynamic> darkMap = {
  ConstKey.MAIN_NAVIGATIONBAR_BG_COLOR: const Color(0xFF25262A),
};
