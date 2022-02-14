import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/modules/note/view/note_preview_screen.dart';
import 'package:note_app/utils/color_utils.dart';
import 'package:note_app/utils/slide_animation.dart';
import 'package:note_app/widgets/default_listtile_widget.dart';

import '../../../data/models/note.dart';
import '../../note/view/note_edit_screen.dart';

class NoteCard extends StatelessWidget {
  final int index;
  final Note note;

  const NoteCard({
    Key? key,
    required this.index,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('notes');

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: const Color(ColorUtils.primary),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        minVerticalPadding: 15,
        title: Text(note.title),
        subtitle: Text(
          note.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => Wrap(
                    children: [
                      DefaultListTileWidget(
                        title: 'Info',
                        icon: const Icon(Icons.info_outline),
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => const Dialog(),
                        ),
                      ),
                      DefaultListTileWidget(
                        title: 'Edit',
                        icon: const Icon(Icons.edit_outlined),
                        onTap: () {
                          Navigator.of(context).pop();

                          Navigator.of(context).push(
                            SlideAnimationRoute(
                              builder: (context) => NoteEditScreen(
                                index: index,
                              ),
                            ),
                          );
                        },
                      ),
                      DefaultListTileWidget(
                        icon: const Icon(Icons.delete_outline),
                        title: 'Delete',
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete note?'),
                              content: const Text(
                                'this will be delete this note permanent',
                                style: TextStyle(color: Colors.black54),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('CANCEL'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    box.deleteAt(index);

                                    Navigator.pop(context);
                                  },
                                  child: const Text('ACCEPT'),
                                ),
                              ],
                            ),
                          ).then((_) => Navigator.pop(context));
                        },
                      ),
                      DefaultListTileWidget(
                        title: 'Cancel',
                        icon: const Icon(Icons.cancel_outlined),
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.more_vert),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
