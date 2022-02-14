import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app/data/models/note.dart';
import 'package:note_app/utils/color_utils.dart';
import 'package:note_app/utils/loading_screen.dart';
import 'package:note_app/utils/size_utils.dart';

import 'create_note_sheet.dart';
import 'note_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SeiorTech. NoteApp',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      drawer: drawer(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: SizeUtils.defaultPadding,
          right: SizeUtils.defaultPadding,
          top: SizeUtils.defaultPadding,
        ),
        child: FutureBuilder(
          future: Hive.openBox('notes'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error : ${snapshot.error.toString()}'),
                );
              }

              return ValueListenableBuilder(
                valueListenable: (snapshot.data as Box).listenable(),
                builder: (context, value, child) => ListView.builder(
                  itemCount: (snapshot.data as Box).length,
                  itemBuilder: (context, index) {
                    Note note = (snapshot.data as Box).getAt(index);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: NoteCard(
                        index: index,
                        note: note,
                      ),
                    );
                  },
                ),
              );
            } else {
              return const LoadingScreen();
            }
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: SizeUtils.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'favorit',
              onPressed: () {},
              child: const Icon(Icons.favorite_border_outlined),
            ),
            const SizedBox(height: SizeUtils.defaultPadding),
            FloatingActionButton(
              heroTag: 'cloud',
              onPressed: () {},
              child: const Icon(Icons.cloud_outlined),
            ),
            const SizedBox(height: SizeUtils.defaultPadding),
            FloatingActionButton(
              heroTag: 'add',
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => const CreateNoteSheet(),
                );
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      child: ListView(
        children: [
          Container(
            child: Row(
              children: const [
                Icon(Icons.flutter_dash),
                SizedBox(width: 8),
                Text(
                  'SeiorTech. NoteApp',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            padding: const EdgeInsets.all(SizeUtils.defaultPadding),
            decoration: const BoxDecoration(
              color: Color(ColorUtils.primary),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Home'),
          ),
          const ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('Settings'),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
          const Divider(height: 20),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Exit'),
            onTap: () => SystemNavigator.pop(),
          ),
        ],
      ),
    );
  }
}
