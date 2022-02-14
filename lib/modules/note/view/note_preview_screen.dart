import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:note_app/data/models/note.dart';
import 'package:note_app/modules/note/provider/note_model.dart';
import 'package:note_app/utils/size_utils.dart';
import 'package:provider/provider.dart';

import '../../../widgets/text_preview_widget.dart';

class NotePreviewScreen extends StatelessWidget {
  final String title;
  final String type;
  final String content;

  const NotePreviewScreen({
    Key? key,
    required this.title,
    required this.content,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var noteModel = Provider.of<NoteModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: showContent(context, content),
      floatingActionButton: (type == NoteType.text.value)
          ? Padding(
              padding: const EdgeInsets.all(SizeUtils.defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag: 'increase text size',
                    onPressed: () => noteModel.increaseTextSize(context),
                    child: const Icon(Icons.add_outlined),
                  ),
                  const SizedBox(height: SizeUtils.defaultPadding),
                  FloatingActionButton(
                    heroTag: 'decrease text size',
                    onPressed: () => noteModel.decreaseTextSize(context),
                    child: const Icon(Icons.remove_outlined),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget showContent(BuildContext context, String content) {
    if (content.isEmpty) {
      content = '(empty)';
    }

    if (type == NoteType.text.value) {
      return TextPreviewWidget(content: content);
    } else if (type == NoteType.markdown.value) {
      return Markdown(
        data: content,
      );
    } else {
      return SingleChildScrollView(
        child: Html(
          data: content,
        ),
      );
    }
  }
}
