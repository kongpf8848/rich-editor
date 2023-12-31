import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:rich_editor/theme/theme_util.dart';
import 'package:rich_editor/quill/mobile_toolbar.dart';
import 'package:rich_editor/quill/embed_unknown.dart';
import 'package:rich_editor/quill/embed_mention.dart';
import 'package:rich_editor/quill/embed_divider.dart';

import 'mobile_icon_theme.dart';

QuillController createQuillController(BuildContext context,
    {required String? summary}) {
  Document? document;
  if ((summary ?? "").isNotEmpty) {
    try {
      document = Document.fromJson(jsonDecode(summary!));
    } catch (e) {
      document = Document()
        ..insert(0, summary);
    }
  }
  document ??= Document();
  final controller = QuillController(
      document: document, selection: const TextSelection.collapsed(offset: 0));
  return controller;
}

QuillEditor createQuillEditor(BuildContext context,
    {required QuillController controller,
      required FocusNode focusNode,
      required bool readOnly,
      required String? userId,
      String? hint = "",
      bool scrollable = true,
      bool autoFocus = true,
      bool expands = false,
      double paddingLeft = 0.0,
      double paddingRight = 0.0,
      double paddingTop = 0.0,
      double paddingBottom = 0.0,
      ScrollController? scrollController}) {
  final _editor = QuillEditor(
    scrollController: scrollController ?? ScrollController(),
    focusNode: focusNode,
    configurations: QuillEditorConfigurations(
      controller: controller,
      placeholder: hint,
      scrollable: scrollable,
      autoFocus: autoFocus,
      expands: expands,
      readOnly: readOnly,
      showCursor: !readOnly,
      padding: EdgeInsets.only(
          left: paddingLeft,
          right: paddingRight,
          top: paddingTop,
          bottom: paddingBottom),
      embedBuilders: [
        ...FlutterQuillEmbeds.defaultEditorBuilders(),
        MentionEmbedBuilder(currentUid: userId),
        DividerEmbedBuilder()
      ],
      unknownEmbedBuilder: UnknownEmbedBuilder(),
      customStyles: DefaultStyles(
        h1: DefaultTextBlockStyle(
            TextStyle(
              fontSize: 21,
              color: isLight(context) ? Color(0xFF1D2129) : Color(0xFFFFFFFF),
              height: 1.2,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
            const VerticalSpacing(16, 0),
            const VerticalSpacing(0, 0),
            null),
        h2: DefaultTextBlockStyle(
            TextStyle(
              fontSize: 17,
              color: isLight(context) ? Color(0xFF1D2129) : Color(0xFFFFFFFF),
              height: 1.2,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
            const VerticalSpacing(12, 0),
            const VerticalSpacing(0, 0),
            null),
        h3: DefaultTextBlockStyle(
            TextStyle(
              fontSize: 15,
              color: isLight(context) ? Color(0xFF1D2129) : Color(0xFFFFFFFF),
              height: 1.25,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
            const VerticalSpacing(8, 0),
            const VerticalSpacing(0, 0),
            null),
        link: TextStyle(
            color: isLight(context)
                ? const Color(0xFF165DFF)
                : const Color(0xFF4D7EF7),
            decoration: TextDecoration.underline),
        placeHolder: DefaultTextBlockStyle(
            TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.grey.withOpacity(0.6),
            ),
            const VerticalSpacing(0, 0),
            const VerticalSpacing(0, 0),
            null),
      ),
    ),
    );
  return _editor;
}

MobileToolbar createMobileToolbar(BuildContext context,
    {required QuillController controller,
      VoidCallback? afterButtonPressed,
      VoidCallback? onMentionPressed}) {
  final _toolbar = MobileToolbar(
    controller: controller,
    afterButtonPressed: afterButtonPressed,
    onMentionPressed: onMentionPressed,
    iconTheme: MobileIconTheme(
        iconSelectedColor: isLight(context)
            ? const Color(0xFF165DFF)
            : const Color(0xFFFFFFFF).withOpacity(0.7),
        iconUnselectedColor: isLight(context)
            ? const Color(0xFF4E5969)
            : const Color(0xFFFFFFFF).withOpacity(0.7),
        iconSelectedFillColor: isLight(context)
            ? const Color(0xFFE8F3FF)
            : const Color(0xFF4F6EFF).withOpacity(0.16),
        iconUnselectedFillColor: Colors.transparent,
        borderRadius: 4),
  );
  return _toolbar;
}

int getQuillLength(QuillController? controller) {
  final document = controller?.document;
  if (document == null || document.isEmpty()) {
    return 0;
  }
  return document.length;
}

String getQuillJson(QuillController? controller) {
  final document = controller?.document;
  if (document == null || document.isEmpty()) {
    return "";
  }
  final json = jsonEncode(document.toDelta().toJson());
  return json;
}

List<String> getMentionList(QuillController? controller) {
  List<String> mentionList = [];
  final delta = controller?.document.toDelta();
  if (delta == null || delta.isEmpty) {
    return mentionList;
  }
  delta.toList().forEach((element) {
    var data = element.data;
    if (data != null && data is Map) {
      var userInfo = data["styled-mention"];
      if (userInfo != null && userInfo is Map) {
        var uid = userInfo["uid"];
        var nickname = userInfo["nickname"];
        if (uid != null) {
          if (!mentionList.contains(uid)) {
            mentionList.add(uid);
          }
        }
      }
    }
  });
  return mentionList;
}
