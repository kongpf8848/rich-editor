import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/embeds/mention.dart';
import 'package:flutter_quill/embeds/unknown_type.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill/flutter_quill_extensions.dart';
import 'package:rich_editor/rich_editor_util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RichEditor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController=ScrollController();

  QuillController? _quillController;
  QuillToolbar? _quillToolbar;
  QuillEditor? _quillEditor;
  int preTextLength = 0;
  ValueNotifier<bool> _editingStatusNotifier = ValueNotifier(true);

  void _doEdit() {
    setState(() {
      _editingStatusNotifier.value = true;
    });
  }

  Future<void> _loadFromAssets() async {
    try {
      final result = await rootBundle.loadString('assets/template.json');
      final doc = Document.fromJson(jsonDecode(result));
      setState(() {
        _quillController = QuillController(
          document: doc,
          selection: const TextSelection.collapsed(offset: 0),
        );
      });
    } catch (error) {
      final doc = Document()..insert(0, 'Empty asset');
      setState(() {
        _quillController = QuillController(
          document: doc,
          selection: const TextSelection.collapsed(offset: 0),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadFromAssets();
  }

  @override
  void dispose() {
    _quillController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_quillController == null) {
      return const Scaffold(body: Center(child: Text('Loading...')));
    }
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _buildBody(),// This trailing comma makes auto-formatting nicer for build methods.
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
              mainAxisSize: MainAxisSize.max,
              children: [
                _createMeetingTopicWidget(),
                ValueListenableBuilder<bool>(
                    valueListenable: _editingStatusNotifier,
                    builder: (context, value, _) {
                      return Container(
                          margin: const EdgeInsets.only(left: 16, right: 16),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              createDivider(),
                              _getQuillEditor(
                                  readOnly: !value, autoFocus: value),
                            ],
                          ));
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

  Widget _createMeetingTopicWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
      alignment: Alignment.centerLeft,
      child: Text(
        "我是文章标题",
        textAlign: TextAlign.left,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: isLight(context) ? const Color(0xFF1D2129) : const Color(0xFFFFFFFF)),
      ),
    );
  }

  Widget createDivider() {
    return Divider(
        thickness: 1,
        color: isLight(context) ? const Color(0xFF86909C) : const Color(0xFF929293));
  }

  Widget _getQuillEditor({
    required bool readOnly,
    required bool autoFocus,
  }) {
    _quillEditor = createQuillEditor(context,
        controller: _quillController!,
        scrollController: _scrollController,
        focusNode: _focusNode,
        readOnly: readOnly,
        autoFocus: autoFocus,
        scrollable: false,
        paddingBottom: 30.0,
        hint: "请输入文章内容",
        userId: "01");
    return _quillEditor!;
  }

  Widget _getQuillToolbar() {
    _quillToolbar = createQuillToolbar(context,
        controller: _quillController!,
        afterButtonPressed: _focusNode.requestFocus,
        onMentionPressed:(){
        });
    return Column(
      children: [
        Divider(
          thickness: 0.8,
          height: 0.8,
          color: isLight(context)
              ? const Color(0xFFC9CDD4)
              : const Color(0xFF658AFF).withOpacity(0.1),
        ),
        _quillToolbar!
      ],
    );
  }
}
