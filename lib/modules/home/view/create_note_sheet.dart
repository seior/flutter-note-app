import 'package:flutter/material.dart';
import 'package:note_app/data/models/note.dart';
import 'package:note_app/exception/not_selected_type.dart';
import 'package:note_app/modules/home/provider/home_model.dart';
import 'package:note_app/modules/note/view/note_edit_screen.dart';
import 'package:note_app/utils/color_utils.dart';
import 'package:note_app/utils/size_utils.dart';
import 'package:note_app/utils/slide_animation.dart';
import 'package:note_app/widgets/default_textfield_widget.dart';

import 'dart:math' as math;

import 'package:provider/provider.dart';

class CreateNoteSheet extends StatefulWidget {
  const CreateNoteSheet({Key? key}) : super(key: key);

  @override
  State<CreateNoteSheet> createState() => _CreateNoteSheetState();
}

class _CreateNoteSheetState extends State<CreateNoteSheet> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.all(SizeUtils.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Create Note',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Transform.rotate(
                  angle: -(90 * math.pi / 180),
                  child: const Icon(Icons.arrow_forward_ios),
                ),
                color: Colors.black,
                iconSize: 18,
              ),
            ],
          ),
          DefaultTextFieldWidget(
            controller: _titleController,
            hintText: 'Title',
            fontWeight: FontWeight.w500,
            textSize: 20,
          ),
          DefaultTextFieldWidget(
            controller: _descriptionController,
            hintText: 'Description',
            fontWeight: FontWeight.w300,
            textSize: 16,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: SizeUtils.defaultPadding),
            child: Text(
              'Type',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Row(
            children: [
              Consumer<HomeModel>(
                builder: (context, value, child) => typeButton(
                  context,
                  child: value.textButtonChild,
                  color: value.textButtonColor,
                  onPressed: () => value.onPressTextButton(),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.10),
              Consumer<HomeModel>(
                builder: (context, value, child) => typeButton(context,
                    child: value.markdownButtonChild,
                    color: value.markdownButtonColor,
                    onPressed: () => value.onPressMarkdownButton()),
              ),
            ],
          ),
          Consumer<HomeModel>(
            builder: (context, value, child) => typeButton(
              context,
              child: value.htmlButtonChild,
              color: value.htmlButtonColor,
              onPressed: () => value.onPressHTMLButton(),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: SizeUtils.defaultPadding),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: 'done',
                onPressed: () async {
                  String title = _titleController.text;

                  if (title.length < 3) {
                    showDialog(
                      context: context,
                      builder: (context) => const Dialog(
                        child: Text('Title must be more than 3 chars'),
                      ),
                    );
                  } else {
                    try {
                      var note = Note(
                        title: title,
                        description: _descriptionController.text,
                        favorite: false,
                        type: Provider.of<HomeModel>(context, listen: false).getSelectedType(),
                        content: '',
                      );

                      var index =
                          await Provider.of<HomeModel>(context, listen: false).addNewNote(note);

                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        SlideAnimationRoute(
                          builder: (context) => NoteEditScreen(
                            index: index,
                          ),
                        ),
                      );
                    } catch (e) {
                      if (e is NotSelectedTypeException) {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(),
                        );
                      } else {
                        throw Exception(e.toString());
                      }
                    }
                  }
                },
                child: const Icon(Icons.done),
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlinedButton typeButton(
    BuildContext context, {
    required Color color,
    required Widget child,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      child: child,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 0, horizontal: 45),
        ),
        side: MaterialStateProperty.all(
          const BorderSide(
            color: Color(ColorUtils.primary),
            style: BorderStyle.solid,
            width: 2.0,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
