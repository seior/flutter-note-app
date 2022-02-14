import 'package:flutter/material.dart';
import 'package:note_app/modules/note/provider/note_model.dart';
import 'package:note_app/utils/size_utils.dart';
import 'package:provider/provider.dart';

class TextPreviewWidget extends StatelessWidget {
  final String content;

  const TextPreviewWidget({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SizeUtils.defaultPadding),
      child: SingleChildScrollView(
        child: Consumer<NoteModel>(
          builder: (context, value, child) => Text(
            content,
            style: TextStyle(fontSize: value.textSize),
          ),
        ),
      ),
    );
  }
}
