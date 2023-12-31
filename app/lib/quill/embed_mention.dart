import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/extensions.dart' as base;
import 'package:flutter_quill/flutter_quill.dart' hide Text;

class MentionEmbed extends Embeddable {
  const MentionEmbed(
    dynamic value,
  ) : super(mentionType, value);

  static const String mentionType = 'styled-mention';

  static MentionEmbed fromDocument(Document document) =>
      MentionEmbed(jsonEncode(document.toDelta().toJson()));

  Document get document => Document.fromJson(jsonDecode(data));
}

class MentionEmbedBuilder extends EmbedBuilder {
  MentionEmbedBuilder({required this.currentUid});

  final String? currentUid;

  @override
  String get key => 'styled-mention';

  @override
  bool get expanded => false;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    base.Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final primaryColor =
        isLight ? const Color(0xFF165DFF) : const Color(0xFF4D7EF7);
    final data = node.value.data;
    final text = "@${data['nickname']}";
    final isCurrentUser = currentUid == data['uid'];
    final textColor = (isCurrentUser ? const Color(0xFFF7F8FA) : primaryColor);
    final style = TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.none,
        overflow: TextOverflow.ellipsis);

    if (isCurrentUser) {
      return Padding(
          padding: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99), color: primaryColor),
            child: Text(
              text,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: style.copyWith(fontSize: 14),
            ),
          ));
    } else {
      return Padding(
        padding: EdgeInsets.zero,
        child: Text(
          text,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: style,
        ),
      );
    }
  }
}
