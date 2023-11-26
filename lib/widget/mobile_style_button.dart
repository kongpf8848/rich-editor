import 'package:flutter/material.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

typedef MobileStyleButtonBuilder = Widget Function(
    BuildContext context,
    Attribute attribute,
    IconData icon,
    Color? fillColor,
    bool? isToggled,
    VoidCallback? onPressed,
    VoidCallback? afterPressed, [
    double iconSize,
    QuillIconTheme? iconTheme,
    ]);

class MobileStyleButton extends StatefulWidget {
  const MobileStyleButton({
    required this.attribute,
    required this.icon,
    required this.controller,
    this.iconSize = kDefaultIconSize,
    this.fillColor,
    this.childBuilder = defaultMobileStyleButtonBuilder,
    this.iconTheme,
    this.afterButtonPressed,
    this.tooltip,
    Key? key,
  }) : super(key: key);

  final Attribute attribute;

  final IconData icon;
  final double iconSize;

  final Color? fillColor;

  final QuillController controller;

  final MobileStyleButtonBuilder childBuilder;

  ///Specify an icon theme for the icons in the toolbar
  final QuillIconTheme? iconTheme;

  final VoidCallback? afterButtonPressed;
  final String? tooltip;

  @override
  _ToggleStyleButtonState createState() => _ToggleStyleButtonState();
}

class _ToggleStyleButtonState extends State<MobileStyleButton> {
  bool? _isToggled;

  Style get _selectionStyle => widget.controller.getSelectionStyle();

  @override
  void initState() {
    super.initState();
    _isToggled = _getIsToggled(_selectionStyle.attributes);
    widget.controller.addListener(_didChangeEditingValue);
  }

  @override
  Widget build(BuildContext context) {
    return UtilityWidgets.maybeTooltip(
      message: widget.tooltip,
      child: widget.childBuilder(
        context,
        widget.attribute,
        widget.icon,
        widget.fillColor,
        _isToggled,
        _toggleAttribute,
        widget.afterButtonPressed,
        widget.iconSize,
        widget.iconTheme,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant MobileStyleButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_didChangeEditingValue);
      widget.controller.addListener(_didChangeEditingValue);
      _isToggled = _getIsToggled(_selectionStyle.attributes);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_didChangeEditingValue);
    super.dispose();
  }

  void _didChangeEditingValue() {
    setState(() => _isToggled = _getIsToggled(_selectionStyle.attributes));
  }

  bool _getIsToggled(Map<String, Attribute> attrs) {
    if (widget.attribute.key == Attribute.list.key ||
        widget.attribute.key == Attribute.script.key ||
        widget.attribute.key == Attribute.header.key) {
      final attribute = attrs[widget.attribute.key];
      if (attribute == null) {
        return false;
      }
      return attribute.value == widget.attribute.value;
    }
    return attrs.containsKey(widget.attribute.key);
  }

  void _toggleAttribute() {
    widget.controller.formatSelection(_isToggled!
        ? Attribute.clone(widget.attribute, null)
        : widget.attribute);
  }
}

Widget defaultMobileStyleButtonBuilder(
    BuildContext context,
    Attribute attribute,
    IconData icon,
    Color? fillColor,
    bool? isToggled,
    VoidCallback? onPressed,
    VoidCallback? afterPressed, [
      double iconSize = kDefaultIconSize,
      QuillIconTheme? iconTheme,
    ]) {
  final theme = Theme.of(context);
  final isEnabled = onPressed != null;
  final iconColor = isEnabled
      ? isToggled == true
      ? (iconTheme?.iconSelectedColor ??
      theme
          .primaryIconTheme.color) //You can specify your own icon color
      : (iconTheme?.iconUnselectedColor ?? theme.iconTheme.color)
      : (iconTheme?.disabledIconColor ?? theme.disabledColor);
  final fill = isEnabled
      ? isToggled == true
      ? (iconTheme?.iconSelectedFillColor ??
      Theme.of(context).primaryColor) //Selected icon fill color
      : (iconTheme?.iconUnselectedFillColor ??
      theme.canvasColor) //Unselected icon fill color :
      : (iconTheme?.disabledIconFillColor ??
      (fillColor ?? theme.canvasColor)); //Disabled icon fill color
  Widget? widget;
  if (attribute == Attribute.h1) {
    widget = Image.asset(
      'images/quill/toolbar_h1.png',
      width: iconSize,
      height: iconSize,
      color: iconColor,
    );
  } else if (attribute == Attribute.h2) {
    widget = Image.asset(
      'images/quill/toolbar_h2.png',
      width: iconSize,
      height: iconSize,
      color: iconColor,
    );
  } else if (attribute == Attribute.bold) {
    widget = Image.asset(
      'images/quill/toolbar_bold.png',
      width: iconSize,
      height: iconSize,
      color: iconColor,
    );
  } else if (attribute == Attribute.underline) {
    widget = Image.asset(
      'images/quill/toolbar_underline.png',
      width: iconSize,
      height: iconSize,
      color: iconColor,
    );
  } else if (attribute == Attribute.strikeThrough) {
    widget = Image.asset(
      'images/quill/toolbar_strike.png',
      width: iconSize,
      height: iconSize,
      color: iconColor,
    );
  } else if (attribute == Attribute.italic) {
    widget = Image.asset(
      'images/quill/toolbar_italic.png',
      width: iconSize,
      height: iconSize,
      color: iconColor,
    );
  } else if (attribute == Attribute.ol) {
    widget = Image.asset(
      'images/quill/toolbar_ordered.png',
      width: iconSize,
      height: iconSize,
      color: iconColor,
    );
  } else if (attribute == Attribute.ul) {
    widget = Image.asset(
      'images/quill/toolbar_bullet.png',
      width: iconSize,
      height: iconSize,
      color: iconColor,
    );
  } else if (attribute == Attribute.highlight) {
    widget = Image.asset(
      'images/quill/toolbar_highlight.png',
      width: iconSize,
      height: iconSize,
      color: iconColor,
    );
  } else {
    widget = Icon(icon, size: iconSize, color: iconColor);
  }
  return QuillIconButton(
    highlightElevation: 0,
    hoverElevation: 0,
    size: iconSize * kIconButtonFactor,
    icon: widget,
    fillColor: fill,
    onPressed: onPressed,
    afterPressed: afterPressed,
    borderRadius: iconTheme?.borderRadius ?? 2,
  );
}