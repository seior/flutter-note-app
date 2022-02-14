import 'package:flutter/material.dart';

class NoteModel extends ChangeNotifier {
  String _title = '';
  double _textSize = 15;
  bool checkboxStatus = false;

  double get textSize => _textSize;

  String get title => _title;

  set setTitle(String title) => _title = title;

  void increaseTextSize(BuildContext context) {
    if (_textSize > 30) {
      showSnacbar(context, 'Can\'t increase text size');
    } else {
      _textSize += 1;

      notifyListeners();
    }
  }

  void decreaseTextSize(BuildContext context) {
    if (_textSize < 11) {
      showSnacbar(context, 'Can\'t decrease text size');
    } else {
      _textSize -= 1;

      notifyListeners();
    }
  }

  void editTitle(String title) {}

  void changeHelperButton(bool value) {
    checkboxStatus = value;

    notifyListeners();
  }

  void showSnacbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 10 * 100),
        content: Text(text),
      ),
    );
  }
}
