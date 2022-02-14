import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/exception/not_selected_type.dart';
import 'package:note_app/utils/color_utils.dart';

import '../../../data/models/note.dart';

class HomeModel extends ChangeNotifier {
  Color textButtonColor = Colors.transparent;
  Widget textButtonChild = const Text(
    'Text',
    style: TextStyle(
      decoration: TextDecoration.none,
      color: Color(ColorUtils.primary),
    ),
  );

  Color markdownButtonColor = Colors.transparent;
  Widget markdownButtonChild = const Text(
    'Markdown',
    style: TextStyle(
      decoration: TextDecoration.none,
      color: Color(ColorUtils.primary),
    ),
  );

  Color htmlButtonColor = Colors.transparent;
  Widget htmlButtonChild = const Text(
    'HTML',
    style: TextStyle(
      decoration: TextDecoration.none,
      color: Color(ColorUtils.primary),
    ),
  );

  Widget restoreButton(String text) {
    return Text(
      text,
      style: const TextStyle(
        decoration: TextDecoration.none,
        color: Color(ColorUtils.primary),
      ),
    );
  }

  void onPressTextButton() {
    // markdown
    markdownButtonColor = Colors.transparent;
    markdownButtonChild = restoreButton('Markdown');

    // html
    htmlButtonColor = Colors.transparent;
    htmlButtonChild = restoreButton('HTML');

    if (textButtonColor == Colors.transparent) {
      textButtonColor = const Color(ColorUtils.primary);
      textButtonChild = const Icon(
        Icons.done_all,
        color: Colors.white,
      );
    } else {
      textButtonColor = Colors.transparent;
      textButtonChild = restoreButton('Text');
    }

    notifyListeners();
  }

  void onPressMarkdownButton() {
    // text
    textButtonColor = Colors.transparent;
    textButtonChild = restoreButton('Text');

    // html
    htmlButtonColor = Colors.transparent;
    htmlButtonChild = restoreButton('HTML');

    if (markdownButtonColor == Colors.transparent) {
      markdownButtonColor = const Color(ColorUtils.primary);
      markdownButtonChild = const Icon(
        Icons.done_all,
        color: Colors.white,
      );
    } else {
      markdownButtonColor = Colors.transparent;
      markdownButtonChild = restoreButton('Markdown');
    }

    notifyListeners();
  }

  void onPressHTMLButton() {
    // markdown
    markdownButtonColor = Colors.transparent;
    markdownButtonChild = restoreButton('Markdown');

    // text
    textButtonColor = Colors.transparent;
    textButtonChild = restoreButton('Text');

    if (htmlButtonColor == Colors.transparent) {
      htmlButtonColor = const Color(ColorUtils.primary);
      htmlButtonChild = const Icon(
        Icons.done_all,
        color: Colors.white,
      );
    } else {
      htmlButtonColor = Colors.transparent;
      htmlButtonChild = restoreButton('HTML');
    }

    notifyListeners();
  }

  String getSelectedType() {
    if (textButtonColor != Colors.transparent) {
      return NoteType.text.value;
    } else if (markdownButtonColor != Colors.transparent) {
      return NoteType.markdown.value;
    } else if (htmlButtonColor != Colors.transparent) {
      return NoteType.html.value;
    } else {
      throw NotSelectedTypeException();
    }
  }

  Future<int> addNewNote(Note note) async {
    var box = Hive.box(Note.boxName);

    return await box.add(note);
  }
}
