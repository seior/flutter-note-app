import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/data/models/note.dart';
import 'package:note_app/modules/note/provider/note_model.dart';
import 'package:note_app/modules/note/view/note_preview_screen.dart';
import 'package:note_app/utils/color_utils.dart';
import 'package:note_app/utils/size_utils.dart';
import 'package:note_app/utils/slide_animation.dart';
import 'package:note_app/widgets/default_listtile_widget.dart';
import 'package:provider/provider.dart';

class NoteEditScreen extends StatefulWidget {
  final int index;

  const NoteEditScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  late final Box box;
  late final Note note;
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    box = Hive.box(Note.boxName);
    note = box.getAt(widget.index);

    controller.text = note.content;
    controller.selection = TextSelection.collapsed(offset: note.content.length);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<NoteModel>(context, listen: false).setTitle = note.title;

    return Scaffold(
      appBar: AppBar(
        title: Consumer<NoteModel>(
          builder: (context, value, child) => Text(
            value.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => Wrap(
                children: [
                  DefaultListTileWidget(
                    title: 'Edit title',
                    icon: const Icon(Icons.title_outlined),
                    onTap: () {},
                  ),
                  DefaultListTileWidget(
                    title: 'Edit Description',
                    icon: const Icon(Icons.subtitles_outlined),
                    onTap: () {},
                  ),
                  DefaultListTileWidget(
                    title: 'Edit Type',
                    icon: const Icon(Icons.description_outlined),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.construction_outlined),
                    title: const Text(
                      'Show helper button',
                      style: TextStyle(color: Colors.black87),
                    ),
                    trailing: Consumer<NoteModel>(
                      builder: (context, value, child) => Checkbox(
                        value: value.checkboxStatus,
                        fillColor:
                            MaterialStateProperty.all<Color>(const Color(ColorUtils.primary)),
                        onChanged: (status) {
                          value.changeHelperButton(status ?? false);
                        },
                      ),
                    ),
                    onTap: () {},
                  ),
                  DefaultListTileWidget(
                    title: 'Cancel',
                    icon: const Icon(Icons.cancel_outlined),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: SizeUtils.defaultPadding),
                child: TextField(
                  controller: controller,
                  maxLines: 99999,
                  autofocus: true,
                  cursorColor: const Color(ColorUtils.primary),
                  decoration: const InputDecoration(
                    hintText: 'Content',
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            bottomBar(
              context,
              widget.index,
              note,
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomBar(BuildContext context, int index, Note note) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: SizeUtils.defaultPadding),
      color: const Color(ColorUtils.primary),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.help_outline),
          ),
          IconButton(
            onPressed: () {
              note.content = controller.text;

              box.putAt(index, note);

              Navigator.of(context).push(
                SlideAnimationRoute(
                  builder: (context) => NotePreviewScreen(
                    title: note.title,
                    content: note.content,
                    type: note.type,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.article_outlined),
          ),
          IconButton(
            onPressed: () {
              note.content = controller.text;

              box.putAt(index, note);

              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.done),
          ),
        ],
      ),
    );
  }
}
