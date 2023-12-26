import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;



class MentionButton extends StatefulWidget {
  const MentionButton({
    required this.icon,
    required this.controller,
    this.iconSize = kDefaultIconSize,
    this.iconTheme,
    this.onPressed,
    this.afterButtonPressed,
    this.tooltip,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final double iconSize;
  final QuillController controller;
  final QuillIconTheme? iconTheme;
  final VoidCallback? onPressed;
  final VoidCallback? afterButtonPressed;
  final String? tooltip;

  @override
  _MentionButtonState createState() => _MentionButtonState();
}

class _MentionButtonState extends State<MentionButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor =
        widget.iconTheme?.iconUnselectedColor ?? theme.iconTheme.color;
    final fillColor =
        widget.iconTheme?.iconUnselectedFillColor ?? theme.canvasColor;

    return QuillIconButton(
      tooltip: widget.tooltip,
      highlightElevation: 0,
      hoverElevation: 0,
      size: widget.iconSize * kIconButtonFactor,
      icon: Image.asset('images/quill/toolbar_mention.png',
          width: widget.iconSize, height: widget.iconSize, color: iconColor),
      fillColor: fillColor,
      borderRadius: widget.iconTheme?.borderRadius ?? 2,
      onPressed: widget.onPressed,
      afterPressed: widget.afterButtonPressed,
    );
  }
}
