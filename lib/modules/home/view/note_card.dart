import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/utils/color_utils.dart';
import 'package:note_app/utils/slide_animation.dart';

import '../../../data/models/note.dart';
import '../../note/view/note_screen.dart';

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
                      ListTile(
                        leading: const Icon(Icons.info_outline, color: Colors.black87),
                        title: const Text(
                          'Info',
                          style: TextStyle(color: Colors.black87),
                        ),
                        onTap: () =>
                            showDialog(context: context, builder: (context) => const Dialog()),
                      ),
                      ListTile(
                        leading: const Icon(Icons.edit_outlined, color: Colors.black87),
                        title: const Text(
                          'Edit',
                          style: TextStyle(color: Colors.black87),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();

                          Navigator.of(context).push(
                            SlideAnimationRoute(
                              builder: (context) => NoteScreen(
                                index: index,
                              ),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete_outline, color: Colors.black87),
                        title: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.black87),
                        ),
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
                      ListTile(
                        leading: const Icon(Icons.cancel_outlined, color: Colors.black87),
                        title: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black87),
                        ),
                        onTap: () => Navigator.pop(context),
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
        onTap: () {},
      ),
    );
  }
}
