import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:rich_editor/quill/toolbar_divider_button.dart';
import 'package:rich_editor/quill/toolbar_style_button.dart';
import 'package:rich_editor/quill/toolbar_link_button.dart';

import '../theme/theme_util.dart';
import 'toolbar_mention_button.dart';

class MobileToolbar extends StatelessWidget {
  MobileToolbar({
    required this.controller,
    this.iconTheme,
    this.onMentionPressed,
    this.afterButtonPressed,
    Key? key,
  }) : super(key: key);

  static const BackgroundAttribute highlight = BackgroundAttribute('#FF984E');
  final double toolbarIconSize = 24.0;
  final QuillController? controller;
  final QuillIconTheme? iconTheme;
  final VoidCallback? onMentionPressed;
  final VoidCallback? afterButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tightFor(
        height: toolbarIconSize*2,
      ),
      color: isLight(context)
          ? const Color(0xFFFFFFFF)
          : const Color(0xFF658AFF).withOpacity(0.1),
      child: Row(children: [
        _buildScrollableList(),
        _buildKeyboardButton(context),
      ]),
    );
  }

  Widget _buildScrollableList() {
    List<Widget>widgetList = [];
    widgetList.add(const SizedBox(width: 16));
    widgetList.add(
      MentionButton(
          icon: Icons.abc,
          controller: controller!,
          iconSize: toolbarIconSize,
          iconTheme: iconTheme,
          onPressed: onMentionPressed,
          afterButtonPressed: afterButtonPressed),
    );
    widgetList.add(const SizedBox(width: 20));

    widgetList.add(
        MobileStyleButton(
      attribute: Attribute.h1,
      icon: Icons.bolt,
      iconSize: toolbarIconSize,
      tooltip: 'H1',
      controller: controller!,
      iconTheme: iconTheme,
      afterButtonPressed: afterButtonPressed,
    ));
    widgetList.add(const SizedBox(width: 20));

    widgetList.add(
        MobileStyleButton(
          attribute: Attribute.h2,
          icon: Icons.bolt,
          iconSize: toolbarIconSize,
          tooltip: 'H2',
          controller: controller!,
          iconTheme: iconTheme,
          afterButtonPressed: afterButtonPressed,
        ));
    widgetList.add(const SizedBox(width: 20));


    widgetList.add(
        MobileStyleButton(
          attribute: Attribute.bold,
          icon: Icons.bolt,
          iconSize: toolbarIconSize,
          tooltip: 'Bold',
          controller: controller!,
          iconTheme: iconTheme,
          afterButtonPressed: afterButtonPressed,
        ));
    widgetList.add(const SizedBox(width: 20));

    widgetList.add(
        MobileStyleButton(
          attribute: Attribute.italic,
          icon: Icons.bolt,
          iconSize: toolbarIconSize,
          tooltip: 'italic',
          controller: controller!,
          iconTheme: iconTheme,
          afterButtonPressed: afterButtonPressed,
        ));
    widgetList.add(const SizedBox(width: 20));

    widgetList.add(
        MobileStyleButton(
          attribute: Attribute.underline,
          icon: Icons.bolt,
          iconSize: toolbarIconSize,
          tooltip: 'underline',
          controller: controller!,
          iconTheme: iconTheme,
          afterButtonPressed: afterButtonPressed,
        ));
    widgetList.add(const SizedBox(width: 20));

    widgetList.add(
        MobileStyleButton(
          attribute: Attribute.strikeThrough,
          icon: Icons.bolt,
          iconSize: toolbarIconSize,
          tooltip: 'strikeThrough',
          controller: controller!,
          iconTheme: iconTheme,
          afterButtonPressed: afterButtonPressed,
        ));
    widgetList.add(const SizedBox(width: 20));

    widgetList.add(
        MobileStyleButton(
          attribute: Attribute.ol,
          icon: Icons.bolt,
          iconSize: toolbarIconSize,
          tooltip: 'ol',
          controller: controller!,
          iconTheme: iconTheme,
          afterButtonPressed: afterButtonPressed,
        ));
    widgetList.add(const SizedBox(width: 20));

    widgetList.add(
        MobileStyleButton(
          attribute: Attribute.ul,
          icon: Icons.bolt,
          iconSize: toolbarIconSize,
          tooltip: 'ul',
          controller: controller!,
          iconTheme: iconTheme,
          afterButtonPressed: afterButtonPressed,
        ));
    widgetList.add(const SizedBox(width: 20));

    widgetList.add(
        MobileLinkButton(
          icon: Icons.bolt,
          iconSize: toolbarIconSize,
          tooltip: 'link',
          controller: controller!,
          iconTheme: iconTheme,
          afterButtonPressed: afterButtonPressed,
        ));
    widgetList.add(const SizedBox(width: 20));

    widgetList.add(
        MobileStyleButton(
          attribute: highlight,
          icon: Icons.bolt,
          iconSize: toolbarIconSize,
          tooltip: 'highlight',
          controller: controller!,
          iconTheme: iconTheme,
          afterButtonPressed: afterButtonPressed,
        ));
    widgetList.add(const SizedBox(width: 20));

    widgetList.add(
        DividerButton(
          icon: Icons.bolt,
          iconSize: toolbarIconSize,
          tooltip: 'divider',
          controller: controller!,
          iconTheme: iconTheme,
        ));
    widgetList.add(const SizedBox(width: 20));

    widgetList.add(const SizedBox(width: 16));
    return Expanded(
      child: ScrollConfiguration(
        behavior: _NoGlowBehavior(),
        child: CustomScrollView(
          controller: ScrollController(),
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: widgetList,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildKeyboardButton(BuildContext context) {
    final bool light = isLight(context);
    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: light
            ? const Color(0xFFFFFFFF)
            : const Color(0xFF658AFF).withOpacity(0.1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(-2, 0),
            blurRadius: 2,
          ),
        ],
      ),
      child: IconButton(
        icon: Image.asset(
          'images/quill/toolbar_keyboard.png',
          width: 24,
          height: 24,
          color: light
              ? const Color(0xFF4E5969)
              : const Color(0xFFFFFFFF).withOpacity(0.7),
        ),
        iconSize: 24,
        onPressed: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          //widget.afterButtonPressed?.call();
        },
      ),
    );
  }
}

class _NoGlowBehavior extends ScrollBehavior {
  Widget buildViewportChrome(BuildContext _, Widget child, AxisDirection __) {
    return child;
  }
}
