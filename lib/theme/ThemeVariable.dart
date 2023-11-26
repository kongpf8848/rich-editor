import 'package:flutter/material.dart';

dynamic findResource(key, BuildContext context) {
  switch (Theme.of(context).brightness) {
    case Brightness.dark:
      return darkMap[key];

    case Brightness.light:
      return lightMap[key];
  }
}

//Theme.of(context).brightness == Brightness.light
//?
//Color(0x90ffffff)
//: Color(0xaa1a1a1a)

class ConstKey {
  static const String ADD_ICON = 'addIcon';
  static const String MSG_ICON = 'msgIcon';
  static const String SCAN_ICON = 'scanIcon';
  static const String NAV_SCAN_ICON = 'navScanIcon';
  static const String NAV_SEARCH_ICON = 'searchIcon';
  static const String HINT_COLOR = 'hintColor';
  static const String INPUT_BG_COLOR = 'input_bg_color';
  static const String ICON_UP = 'icon_up';
  static const String ICON_DOWN = 'icon_down';
  static const String DIVIDER_LINE_COLOR = 'divider_line_color';
  static const String SEARCH_ICON = 'search_icon';
  static const String CHAT_LIST_BACKGROUND_COLOR = 'chat_list_background_color';
  static const String FRIENDS_ICON = 'friends_icon';
  static const String ORG_ICON = 'org_icon';
  static const String RELATED_ORG_ICON = 'related_org_icon';
  static const String SELF_ORG_ICON = 'self_org_icon';
  static const String ADD_FRIEND_ICON = 'add_friend_icon';
  static const String GROUP_FRIEND_ICON = 'group_friend_icon';
  static const String SERVICE_ICON = 'service_icon';
  static const String LIST_RIGHT_ICON = 'list_right_icon';

  static const String LIST_TXT_COLOR = 'list_txt_color';
  static const String DOLOG_PRIMARY = 'dolog_primary';

  static const String CHAT_LIST_HOVER_COLOR = "chat_list_hover_color";
  static const String EXPAND_BG = "expand_bg";
  static const String NAVIGATIONBAR_BG_COLOR = "navigationbar_bg_color";

  static const String NAVIGATIONBAR_WEBTAB_BG_COLOR =
      "navigationbar_webtab_bg_color";

  static const String WORKFLOW_BG = "workflow_bg";
  static const String WORKFLOW_CARD_BG = "workflow_card_bg";
  static const String WORKFLOW_BTN_COLOR = "workflow_btn_color";
  static const String WORKFLOW_TITLE_COLOR = "workflow_title_color";
  static const String WORKFLOW_SUB_TITLE_COLOR = "workflow_sub_title_color";
  static const String WORKFLOW_TODO_BG_COLOR = "workflow_todo_bg_color";
  static const String WORKFLOW_BG_MORE = "workflow_bg_more";
  static const String WORKFLOW_FOOTER_COLOR = "workflow_footer_color";
  static const String WORKFLOW_SUMMARY_COLOR = "workflow_summary_color";
  static const String WORK_FLOW_BG_TIPS = "workflow_bg_tips";
  static const String WORKFLOW_HINT_TITLE_COLOR = "workflow_hint_title_color";

  static const String WORKFLOW_DIVIDER_COLOR = "work_divider_color";
  static const String MEETING_NAVIGATIONBAR_BG_COLOR =
      "meeting_navigationbar_bg_color";
  static const String MAIN_NAVIGATIONBAR_BG_COLOR =
      "main_navigationbar_bg_color";
  static const String DIALOG_BORDER_COLOR = 'dialog_border_color';
  static const String DIALOG_TITLE_COLOR = 'dialog_title_color';
  static const String HINT_TXT_COLOR = 'hint_txt_color';
}

Map<String, dynamic> darkMap = {
  ConstKey.ADD_ICON: 'images/add_rim_normal@3x.png',
  ConstKey.MSG_ICON: 'images/comment@3x.png',
  ConstKey.SCAN_ICON: 'images/settings/my_scan@3x.png',
  ConstKey.NAV_SCAN_ICON: 'images/chat/common_scan@3x.png',
  ConstKey.SEARCH_ICON: 'images/chat/common_search@3x.png',
  ConstKey.NAV_SEARCH_ICON: 'images/common_nav_search@3x.png',
  ConstKey.ICON_UP: 'images/chat/top_pack_up@3x.png',
  ConstKey.ICON_DOWN: 'images/chat/top_pull_down@3x.png',
  ConstKey.HINT_COLOR: Color(0xff8B91A0),
  ConstKey.DIVIDER_LINE_COLOR: Color(0x504A4E59),
  ConstKey.INPUT_BG_COLOR: Color(0xff4A4E59),
  ConstKey.CHAT_LIST_BACKGROUND_COLOR: Color(0xff25262A),
  ConstKey.FRIENDS_ICON: 'images/chat/out_friend_icon.png',
  ConstKey.ORG_ICON: 'images/chat/org_icon.png',
  ConstKey.SELF_ORG_ICON: 'images/chat/department_icon.png',
  ConstKey.RELATED_ORG_ICON: 'images/org/related_org.png',
  ConstKey.ADD_FRIEND_ICON: 'images/chat/new_friend@3x.png',
  ConstKey.GROUP_FRIEND_ICON: 'images/chat/group_chat@3x.png',
  ConstKey.SERVICE_ICON: 'images/chat/service_number@3x.png',
  ConstKey.LIST_RIGHT_ICON: 'images/chat/list_right_dark@3x.png',
  ConstKey.LIST_TXT_COLOR: Color(0xffD9DCE5),
  ConstKey.DOLOG_PRIMARY: Color(0xffeeeeee),
  ConstKey.CHAT_LIST_HOVER_COLOR: Color(0x22ffffff),
  ConstKey.EXPAND_BG: Color(0xFF4A4E59),
  ConstKey.WORKFLOW_BG: Color(0xFF111111),
  ConstKey.WORKFLOW_CARD_BG: Color(0xFF25262a),
  ConstKey.WORKFLOW_BTN_COLOR: Color(0xE5F1F5FF),
  ConstKey.NAVIGATIONBAR_BG_COLOR: Color(0xff25262A),
  ConstKey.WORKFLOW_TITLE_COLOR: Color(0xFFEFF1F4),
  ConstKey.WORKFLOW_SUB_TITLE_COLOR: Color(0xFFD9DCE5),
  ConstKey.WORKFLOW_TODO_BG_COLOR: Color(0xFF292B32),
  ConstKey.WORKFLOW_BG_MORE: Color(0xFF25262A),
  ConstKey.WORKFLOW_FOOTER_COLOR: Color(0xFFB5B9C7),
  ConstKey.WORKFLOW_SUMMARY_COLOR: Color(0xFFD9DCE5),
  ConstKey.WORK_FLOW_BG_TIPS: Color(0xFF686868),
  ConstKey.WORKFLOW_DIVIDER_COLOR: Color(0xFF4A4E59),
  ConstKey.WORKFLOW_HINT_TITLE_COLOR: Color(0xFFB5B9C7),
  ConstKey.MEETING_NAVIGATIONBAR_BG_COLOR: Color(0xFF17181C),
  ConstKey.MAIN_NAVIGATIONBAR_BG_COLOR: Color(0xFF25262a),
  ConstKey.DIALOG_BORDER_COLOR: Color(0xff1E1B17),
  ConstKey.DIALOG_TITLE_COLOR: Color(0xffDAD9D5),
  ConstKey.HINT_TXT_COLOR: Color(0xffD9DCE5),
  ConstKey.NAVIGATIONBAR_WEBTAB_BG_COLOR: Color(0xFF17181C),
};

Map<String, dynamic> lightMap = {
  ConstKey.ADD_ICON: 'images/add_rim_normal@3x.png',
  ConstKey.MSG_ICON: 'images/comment@3x.png',
  ConstKey.SCAN_ICON: 'images/settings/my_scan@3x.png',
  ConstKey.NAV_SCAN_ICON: 'images/chat/common_scan@3x.png',
  ConstKey.SEARCH_ICON: 'images/chat/common_search@3x.png',
  ConstKey.NAV_SEARCH_ICON: 'images/common_nav_search@3x.png',
  ConstKey.ICON_UP: 'images/chat/top_pack_up@3x.png',
  ConstKey.ICON_DOWN: 'images/chat/top_pull_down@3x.png',
  ConstKey.HINT_COLOR: Color(0xff8B91A0),
  ConstKey.DIVIDER_LINE_COLOR: Color(0xffEFF1F4),
  ConstKey.INPUT_BG_COLOR: Color(0xffF3F5F9),
  ConstKey.CHAT_LIST_BACKGROUND_COLOR: Color(0xffffffff),
  ConstKey.FRIENDS_ICON: 'images/chat/out_friend_icon.png',
  ConstKey.ORG_ICON: 'images/chat/org_icon.png',
  ConstKey.SELF_ORG_ICON: 'images/chat/department_icon.png',
  ConstKey.RELATED_ORG_ICON: 'images/org/related_org.png',
  ConstKey.ADD_FRIEND_ICON: 'images/chat/new_friend@3x.png',
  ConstKey.GROUP_FRIEND_ICON: 'images/chat/group_chat@3x.png',
  ConstKey.SERVICE_ICON: 'images/chat/service_number@3x.png',
  ConstKey.LIST_RIGHT_ICON: 'images/chat/list_right@3x.png',
  ConstKey.LIST_TXT_COLOR: Color(0xff070707),
  ConstKey.DOLOG_PRIMARY: Color(0xff2b2b2b),
  ConstKey.CHAT_LIST_HOVER_COLOR: Color(0x00f6f7f8),
  ConstKey.EXPAND_BG: Color(0xFFF5F6F8),
  ConstKey.WORKFLOW_BG: Color(0xFFF2F4F7),
  ConstKey.WORKFLOW_CARD_BG: Color(0xFFFFFFFF),
  ConstKey.WORKFLOW_BTN_COLOR: Color(0xFFF1F5FF),
  ConstKey.NAVIGATIONBAR_BG_COLOR: Color(0xffffffff),
  ConstKey.WORKFLOW_TITLE_COLOR: Color(0xFF25262A),
  ConstKey.WORKFLOW_SUB_TITLE_COLOR: Color(0xFF4A4E59),
  ConstKey.WORKFLOW_TODO_BG_COLOR: Color(0xFFF2F4F7),
  ConstKey.WORKFLOW_BG_MORE: Color(0xFFEFF1F4),
  ConstKey.WORKFLOW_FOOTER_COLOR: Color(0xFFB5B9C7),
  ConstKey.WORKFLOW_SUMMARY_COLOR: Color(0xFF25262A),
  ConstKey.WORK_FLOW_BG_TIPS: Color(0xFF25262A),
  ConstKey.WORKFLOW_DIVIDER_COLOR: Color(0xFFD9DCE5),
  ConstKey.WORKFLOW_HINT_TITLE_COLOR: Color(0xFF4A4E59),
  ConstKey.MEETING_NAVIGATIONBAR_BG_COLOR: Colors.white,
  ConstKey.MAIN_NAVIGATIONBAR_BG_COLOR: Colors.white,
  ConstKey.DIALOG_BORDER_COLOR: Color(0xffE1E4E8),
  ConstKey.DIALOG_TITLE_COLOR: Color(0xff25262A),
  ConstKey.HINT_TXT_COLOR: Color(0xffB5B9C7),
  ConstKey.NAVIGATIONBAR_WEBTAB_BG_COLOR: Color(0xfff2f3f5),
};
