
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Scrollable list with arrow indicators.
///
/// The arrow indicators are automatically hidden if the list is not
/// scrollable in the direction of the respective arrow.
class ArrowIndicatedButtonList extends StatefulWidget {
  const ArrowIndicatedButtonList({
    required this.axis,
    required this.buttons,
    required this.afterButtonPressed,
    Key? key,
  }) : super(key: key);

  final Axis axis;
  final List<Widget> buttons;
  final VoidCallback? afterButtonPressed;

  @override
  _ArrowIndicatedButtonListState createState() =>
      _ArrowIndicatedButtonListState();
}

class _ArrowIndicatedButtonListState extends State<ArrowIndicatedButtonList>
    with WidgetsBindingObserver {
  final ScrollController _controller = ScrollController();
  bool _showBackwardArrow = false;
  bool _showForwardArrow = false;

  @override
  void initState() {
    super.initState();
    //_controller.addListener(_handleScroll);

    // Listening to the WidgetsBinding instance is necessary so that we can
    // hide the arrows when the window gets a new size and thus the toolbar
    // becomes scrollable/unscrollable.
    //WidgetsBinding.instance.addObserver(this);

    // Workaround to allow the scroll controller attach to our ListView so that
    // we can detect if overflow arrows need to be shown on init.
    //Timer.run(_handleScroll);
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      //_buildBackwardArrow(),
      _buildScrollableList(),
      //_buildForwardArrow(),
      //_buildShadow(),
      _buildKeyboardButton()
    ];

    return widget.axis == Axis.horizontal
        ? Row(
            children: children,
          )
        : Column(
            children: children,
          );
  }

  @override
  void didChangeMetrics() => _handleScroll();

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _handleScroll() {
    if (!mounted) return;

    setState(() {
      _showBackwardArrow =
          _controller.position.minScrollExtent != _controller.position.pixels;
      _showForwardArrow =
          _controller.position.maxScrollExtent != _controller.position.pixels;
    });
  }

  Widget _buildBackwardArrow() {
    IconData? icon;
    if (_showBackwardArrow) {
      if (widget.axis == Axis.horizontal) {
        icon = Icons.arrow_left;
      } else {
        icon = Icons.arrow_drop_up;
      }
    }

    return SizedBox(
      width: 8,
      child: Transform.translate(
        // Move the icon a few pixels to center it
        offset: const Offset(-5, 0),
        child: icon != null ? Icon(icon, size: 18) : null,
      ),
    );
  }

  Widget _buildScrollableList() {
    final list = <Widget>[const SizedBox(width: 16)];
    widget.buttons.forEach((element) {
      list
        ..add(element)
        ..add(const SizedBox(width: 20));
    });
    list.add(const SizedBox(width: 20));
    return Expanded(
      child: ScrollConfiguration(
        // Remove the glowing effect, as we already have the arrow indicators
        behavior: _NoGlowBehavior(),
        // The CustomScrollView is necessary so that the children are not
        // stretched to the height of the toolbar:
        // https://stackoverflow.com/a/65998731/7091839
        child: CustomScrollView(
          scrollDirection: widget.axis,
          controller: _controller,
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: widget.axis == Axis.horizontal
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: list,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: list,
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildForwardArrow() {
    IconData? icon;
    if (_showForwardArrow) {
      if (widget.axis == Axis.horizontal) {
        icon = Icons.arrow_right;
      } else {
        icon = Icons.arrow_drop_down;
      }
    }

    return SizedBox(
      width: 8,
      child: Transform.translate(
        // Move the icon a few pixels to center it
        offset: const Offset(-5, 0),
        child: icon != null ? Icon(icon, size: 18) : null,
      ),
    );
  }

  Widget _buildKeyboardButton() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isLight
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
          color: isLight
              ? const Color(0xFF4E5969)
              : const Color(0xFFFFFFFF).withOpacity(0.7),
        ),
        iconSize: 24,
        onPressed: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          widget.afterButtonPressed?.call();
        },
      ),
    );
  }
}

/// ScrollBehavior without the Material glow effect.
class _NoGlowBehavior extends ScrollBehavior {
  Widget buildViewportChrome(BuildContext _, Widget child, AxisDirection __) {
    return child;
  }
}
