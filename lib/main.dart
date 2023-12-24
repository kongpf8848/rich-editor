import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/embeds/mention.dart';
import 'package:flutter_quill/embeds/unknown_type.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill/flutter_quill_extensions.dart';
import 'package:rich_editor/quill/history_button.dart';
import 'package:rich_editor/theme/AppTheme.dart';
import 'package:rich_editor/theme/ThemeVariable.dart';
import 'package:rich_editor/util/rich_editor_util.dart';
import 'package:rich_editor/util/theme_util.dart';
import 'package:rich_editor/widget/ZenNavigationBar.dart';
import 'package:rich_editor/widget/mobile_toolbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        isLight(context) ? SystemUiLight : SystemUiDark);
    if (Platform.isAndroid) {
      SystemUiOverlayStyle style = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,

        ///这是设置状态栏的图标和字体的颜色, 否则上面会有灰色的条
        ///Brightness.light  一般都是显示为白色
        ///Brightness.dark 一般都是显示为黑色
      );
      SystemChrome.setSystemUIOverlayStyle(style);
    }
    return MaterialApp(
      title: 'RichEditor',
      debugShowCheckedModeBanner: false,
      theme: appThemeData[AppTheme.PureLight],
      darkTheme: appThemeData[AppTheme.PureDark],
      home: const MyHomePage(title: 'RichEditor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  QuillController? _quillController;
  QuillToolbar? _quillToolbar;
  QuillEditor? _quillEditor;
  final int maxLength = 10000;
  int preTextLength = 0;
  final ValueNotifier<bool> _editingStatusNotifier = ValueNotifier(false);
  final ValueNotifier<bool> _saveStatusNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _loadFromAssets();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _quillController?.removeListener(_textChangeListener);
    _quillController?.dispose();
    super.dispose();
  }

  void _moveToQuillBottom() {
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      _quillController?.moveCursorToEnd();
    });
  }

  Future<void> _loadFromAssets() async {
    try {
      final summary = await rootBundle.loadString('assets/template.json');
      setState(() {
        _editingStatusNotifier.value = true;
        if (_quillController != null) {
          _quillController?.removeListener(_textChangeListener);
          _quillController?.dispose();
        }
        _quillController = createQuillController(context, summary: summary);
        _quillController!.addListener(_textChangeListener);
        if (_editingStatusNotifier.value) {
          _moveToQuillBottom();
        }
      });
    } catch (error) {
      debugPrint('++++++++_loadFromAssets error:$error');
      setState(() {
        _editingStatusNotifier.value = true;
        final doc = Document()..insert(0, 'Empty asset');
        _quillController = QuillController(
          document: doc,
          selection: const TextSelection.collapsed(offset: 0),
        );
      });
    }
  }

  void _textChangeListener() {
    debugPrint('++++++++++++++_textChangeListener');
    int curTextLength = getQuillLength(_quillController);
    var curContent = getQuillJson(_quillController);
    _saveStatusNotifier.value = (curTextLength > 0);
    if (curTextLength > 1 && (curTextLength > preTextLength)) {
      final index = _quillController!.selection.baseOffset;
      if (index > 0) {
        var value = _quillController!.plainTextEditingValue.text;
        var newString = value.substring(index - 1, index);
        if (newString == '@') {
          _onMentionPressed();
        }
      }
    }
    preTextLength = curTextLength;
  }

  @override
  Widget build(BuildContext context) {
    if (_quillController == null) {
      return const Scaffold(body: Center(child: Text('Loading...')));
    }
    Color mainColor =
        findResource(ConstKey.MAIN_NAVIGATIONBAR_BG_COLOR, context);
    return CupertinoPageScaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      navigationBar: createNavigationBar(),
      child: Material(
        color: mainColor,
        child: SafeArea(
          top: false,
          child: _buildBody(),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            child: Column(
              children: [
                createMeetingTopicWidget(),
                const SizedBox(
                  height: 5,
                ),
                ValueListenableBuilder<bool>(
                    valueListenable: _editingStatusNotifier,
                    builder: (context, value, _) {
                      return Container(
                        margin: const EdgeInsets.only(left: 16, right: 16),
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (value) createDivider(),
                            _getQuillEditor(readOnly: !value, autoFocus: value),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
        ValueListenableBuilder<bool>(
            valueListenable: _editingStatusNotifier,
            builder: ((context, value, _) {
              return value ? _getQuillToolbar() : const SizedBox.shrink();
            }))
      ],
    );
  }

  ZenNavigationBar createNavigationBar() {
    //保存按钮
    Widget saveWidget = ValueListenableBuilder(
        valueListenable: _editingStatusNotifier,
        builder: (BuildContext context, bool flag, Widget? child) {
          return GestureDetector(
              onTap: onClickSave,
              child: Container(
                  margin: const EdgeInsets.only(left: 6.0, right: 6.0),
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                  child: Text(
                    flag ? "保存" : "编辑",
                    style: TextStyle(
                      color: isLight(context)
                          ? Color(0xFF165DFF)
                          : Color(0xFF4D7EF7),
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  )));
        });
    return ZenNavigationBar(
      backgroundColor: findResource(ConstKey.NAVIGATIONBAR_BG_COLOR, context),
      leading: createCloseWidget(),
      middle: Container(
          alignment: Alignment.centerRight,
          child: ValueListenableBuilder<bool>(
            builder: (BuildContext context, bool value, Widget? child) {
              if (value) {
                return Row(mainAxisSize: MainAxisSize.min, children: [
                  createUndoRedoWidget(true),
                  SizedBox(
                    width: 24,
                  ),
                  createUndoRedoWidget(false),
                  saveWidget
                ]);
              } else {
                return saveWidget;
              }
            },
            valueListenable: _editingStatusNotifier,
          )),
    );
  }

  ///关闭按钮
  Widget? createCloseWidget() {
    return GestureDetector(
        onTap: () async {
          exit(0);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            "images/ic_close.png",
            color: isLight(context)
                ? Color(0xFF070707)
                : Color(0xFFFFFFFF).withOpacity(0.7),
            height: 20,
            width: 20,
          ),
        ));
  }

  void onClickSave() {
    _editingStatusNotifier.value = !_editingStatusNotifier.value;
    if (_editingStatusNotifier.value) {
      _focusNode.requestFocus();
      _moveToQuillBottom();
    }
  }

  Widget createUndoRedoWidget(bool undo) {
    if (_quillController != null) {
      return UndoRedoButton(
        icon: undo ? "images/quill/ic_undo.png" : "images/quill/ic_redo.png",
        controller: _quillController!,
        undo: undo,
        iconTheme: QuillIconTheme(
            iconUnselectedFillColor: Colors.transparent,
            iconSelectedFillColor: Colors.transparent,
            iconUnselectedColor: isLight(context)
                ? Color(0xFF070707)
                : Color(0xFFFFFFFF).withOpacity(0.7),
            disabledIconColor: isLight(context)
                ? Color(0xFF070707).withOpacity(0.5)
                : Color(0xFFFFFFFF).withOpacity(0.4)),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  ///会议主题
  createMeetingTopicWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      alignment: Alignment.centerLeft,
      child: Text(
        "周一质量监控方案讨论会",
        textAlign: TextAlign.left,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: isLight(context)
                ? const Color(0xFF1D2129)
                : const Color(0xFFFFFFFF)),
      ),
    );
  }

  //分割线
  createDivider() {
    return Divider(
        thickness: 1,
        color: isLight(context)
            ? const Color(0xFF86909C)
            : const Color(0xFF929293));
  }

  Widget _getQuillEditor({
    required bool readOnly,
    required bool autoFocus,
  }) {
    debugPrint('++++++++++++++_getQuillEditor:${_quillController != null}');
    if (_quillController != null) {
      _quillEditor = createQuillEditor(context,
          controller: _quillController!,
          scrollController: _scrollController,
          focusNode: _focusNode,
          readOnly: readOnly,
          autoFocus: autoFocus,
          scrollable: false,
          paddingBottom: 30.0,
          hint: "请输入内容",
          userId: "");
    }
    return _quillEditor ?? const SizedBox.shrink();
  }

  Widget _getQuillToolbar() {
    _quillToolbar = createQuillToolbar(context,
        controller: _quillController!,
        afterButtonPressed: _focusNode.requestFocus,
        onMentionPressed: _onMentionPressed);
    return Column(
      children: [
        Divider(
          thickness: 0.8,
          height: 0.8,
          color: isLight(context)
              ? Color(0xFFC9CDD4)
              : Color(0xFF658AFF).withOpacity(0.1),
        ),
        _quillToolbar!
      ],
    );
  }

  void _onMentionPressed() async {
    debugPrint('+++++++++++++++++++++++_onMentionPressed');
  }
}
