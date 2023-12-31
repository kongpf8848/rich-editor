import 'package:flutter/material.dart';
import 'package:flutter_quill/extensions.dart';

class LinkDialog extends StatefulWidget {
  const LinkDialog({
    this.link,
    this.text,
    Key? key,
  }) : super(key: key);

  final String? link;
  final String? text;

  @override
  _LinkDialogState createState() => _LinkDialogState();
}

class _LinkDialogState extends State<LinkDialog> {
  late String _link;
  late String _text;
  late RegExp linkRegExp;
  late TextEditingController _linkController;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _link = widget.link ?? '';
    _text = widget.text ?? '';
    linkRegExp = AutoFormatMultipleLinksRule.linkRegExp;
    _linkController = TextEditingController(text: _link);
    _textController = TextEditingController(text: _text);
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return AlertDialog(
      backgroundColor:
          isLight ? const Color(0xFFFFFFFF) : const Color(0xFF25262A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      title: const Text(
        '编辑链接',
        maxLines: 1,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
      titleTextStyle: TextStyle(
          color: isLight ? const Color(0xFF1D2129) : const Color(0xFFFFFFFF),
          fontSize: 16,
          fontWeight: FontWeight.bold),
      content: Container(
          constraints:
              BoxConstraints.tightFor(width: MediaQuery.of(context).size.width),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('文本',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: isLight
                        ? const Color(0xFF1D2129)
                        : const Color(0xFFFFFFFF),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(height: 8),
              Container(
                  height: 36,
                  decoration: BoxDecoration(
                    color: isLight
                        ? const Color(0xFFF6F6FA)
                        : const Color(0xFF658AFF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        color: isLight
                            ? const Color(0xFF1D2129)
                            : const Color(0xFFFFFFFF),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis),
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 15),
                        hintText: '输入文本',
                        hintStyle: TextStyle(
                            color: isLight
                                ? const Color(0xFFB5B9C7)
                                : const Color(0xFF86909C),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: isLight
                                    ? const Color(0xFF165DFF)
                                    : const Color(0xFF658AFF)))),
                    autofocus: true,
                    onChanged: _textChanged,
                    controller: _textController,
                  )),
              const SizedBox(height: 20),
              Text('链接',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: isLight
                        ? const Color(0xFF1D2129)
                        : const Color(0xFFFFFFFF),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(height: 8),
              Container(
                  height: 36,
                  decoration: BoxDecoration(
                    color: isLight
                        ? const Color(0xFFF6F6FA)
                        : const Color(0xFF658AFF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                        color: isLight
                            ? const Color(0xFF1D2129)
                            : const Color(0xFFFFFFFF),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis),
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 15, right: 15),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: isLight
                                  ? const Color(0xFF165DFF)
                                  : const Color(0xFF658AFF))),
                      hintText: '粘贴或输入链接',
                      hintStyle: TextStyle(
                          color: isLight
                              ? const Color(0xFFB5B9C7)
                              : const Color(0xFF86909C),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    autofocus: true,
                    onChanged: _linkChanged,
                    controller: _linkController,
                  )),
              const SizedBox(height: 20),
              Container(
                height: 36,
                alignment: Alignment.center,
                child: Row(children: [
                  Expanded(
                      child: getBottomButton('取消',
                          bgColor: isLight
                              ? const Color(0xFFE7F0FF)
                              : const Color(0xFF4A4E59),
                          textColor: isLight
                              ? const Color(0xFF4B7BFF)
                              : const Color(0xFFFFFFFF), onClick: () {
                    Navigator.of(context).pop();
                  })),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: getBottomButton(
                    '确定',
                    bgColor: isLight
                        ? (_canPress()
                            ? const Color(0xFF165DFF)
                            : const Color(0xFF94BFFF))
                        : (_canPress()
                            ? const Color(0xFF658AFF)
                            : const Color(0xFF658AFF).withOpacity(0.6)),
                    textColor: isLight
                        ? (_canPress()
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFFE8F3FF))
                        : (_canPress()
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFFFFFFFF).withOpacity(0.6)),
                    onClick: _canPress() ? _applyLink : null,
                  )),
                ]),
              )
            ],
          )),
      //actions: [_okButton(), _okButton()],
    );
  }

  Widget getBottomButton(String text,
      {Color? bgColor, Color? textColor, Function? onClick}) {
    return Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              onClick?.call();
            },
            child: Container(
                height: 32,
                alignment: Alignment.center,
                child: Text(text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                    )))));
  }

  bool _canPress() {
    if (_text.trim().isEmpty || _link.trim().isEmpty) {
      return false;
    }
    // if (!linkRegExp.hasMatch(_link)) {
    //   return false;
    // }

    return true;
  }

  void _linkChanged(String value) {
    setState(() {
      _link = value;
    });
  }

  void _textChanged(String value) {
    setState(() {
      _text = value;
    });
  }

  void _applyLink() {
    Navigator.pop(context, TextLink(_text.trim(), _link.trim()));
  }
}

class TextLink {
  TextLink(
    this.text,
    this.link,
  );

  final String text;
  final String link;
}
